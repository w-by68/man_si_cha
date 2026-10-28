package com.guchen.agent.admin;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.HexFormat;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * 后台鉴权拦截器：账号口令登录 + 两档角色。
 *
 * <h3>为什么只有两个角色，不做 user/role/menu 三张表</h3>
 * 需求是「账号密码登录 + 区分能不能改数据」，不是完整 RBAC。
 * 建表做角色管理需要账号表、角色表、菜单表、授权表加增删改查界面；
 * 而实际只有两种人——能改数据的和只能看的。两个枚举值就够。
 *
 * <h3>账号从哪来</h3>
 * 环境变量 {@code ADMIN_USERS}，格式 {@code 用户名:口令:角色}，逗号分隔：
 * <pre>ADMIN_USERS=admin:pass123:admin,viewer:look456:viewer</pre>
 * 账号是部署配置而非业务数据，改账号重启即可；不建表就不必考虑初始化与备份。
 *
 * <h3>角色能力</h3>
 * <ul>
 *   <li><b>admin</b>：读写全部</li>
 *   <li><b>viewer</b>：只读。写接口（改订单状态、改商品、改知识块、切模型）返回 403</li>
 * </ul>
 */
@Slf4j
@Component
public class AdminAuthInterceptor implements HandlerInterceptor {

    /** 多账号配置。为空时回落到单口令模式（admin.password），再为空则整体放行。 */
    @Value("${admin.users:}")
    private String usersConfig;

    /** 单口令模式（兼容旧配置），视为 admin 账号。 */
    @Value("${admin.password:}")
    private String adminPassword;

    @Value("${admin.token-ttl-hours:8}")
    private long tokenTtlHours;

    /** 令牌值存 {@code 用户名|角色}。以登录时的权限为准，改权限后需重新登录生效。 */
    private static final String TOKEN_PREFIX = "agent:admin:token:";

    /**
     * viewer 禁止访问的写接口。
     *
     * ⚠️ 新增任何改变数据的接口必须在此登记，否则 viewer 能越权调用。
     * 用路径白名单而非方法注解：注解漏标就默认放行（失败方向危险）；
     * 路径清单集中一处，review 时一眼看完。
     */
    private static final Set<String> WRITE_ENDPOINTS = Set.of(
            "POST /api/admin/order-status",
            "POST /api/admin/product-status",
            "POST /api/admin/spec-update",
            "POST /api/admin/chunk-create",
            "POST /api/admin/chunk-update",
            "POST /api/admin/chunk-delete",
            "POST /api/admin/knowledge/rebuild",
            // ⚠️ 这条必须带 POST：同一路径还有 GET /api/admin/agent/model（查看配置），
            // 只按路径匹配会把「查看模型」也判成写操作，导致只读角色连看都看不了。
            "POST /api/admin/agent/model",
            // ---- 商品新建与编辑 ----
            "POST /api/admin/product-create",
            "POST /api/admin/product-update",
            "POST /api/admin/spec-create",
            "POST /api/admin/spec-delete",
            "POST /api/admin/product-image-add",
            "POST /api/admin/product-image-delete",
            "POST /api/admin/product-themes",
            // ---- 评价 / 茶友圈 / 积分 / 优惠券 ----
            "POST /api/admin/review-audit",
            "POST /api/admin/review-reply",
            "POST /api/admin/review-delete",
            "POST /api/admin/moment-delete",
            "POST /api/admin/moment-comment-delete",
            "POST /api/admin/points-adjust",
            "POST /api/admin/coupon-generate",
            // ---- 优惠券自定义创建 ----
            "POST /api/admin/coupon-create",
            "POST /api/admin/coupon-update",
            "POST /api/admin/coupon-delete",
            "POST /api/admin/coupon-toggle"
    );

    /** 用 POST 但语义只读的接口，viewer 允许调用（只是要传 JSON body 才用 POST）。 */
    private static final Set<String> READ_ONLY_POST = Set.of(
            "POST /api/admin/agent/route-test",
            "POST /api/admin/search-lab"
    );

    /**
     * C 端接口（小程序调用），不走后台鉴权 —— 它们用 JWT 校验用户身份，
     * 与后台的账号体系是两套。若误纳入后台拦截，小程序会全部 401。
     */
    /**
     * C 端接口（小程序调用，不带后台令牌）。
     * 第一道防线：AdminWebConfig 的 excludePathPatterns 已排除 /api/admin/public/**。
     * 这个集合是第二道防线——万一 excludePathPatterns 被改回精确路径，
     * 这里的判断仍然放行这些 C 端接口，不会全部 401。
     */
    private static final Set<String> C_SIDE_PATHS = Set.of(
            "POST /api/admin/review/submit",
            "GET /api/admin/public/coupons",
            "GET /api/admin/public/cart-check",
            "GET /api/admin/public/product-reviews",
            "GET /api/admin/public/samples",
            "POST /api/admin/public/coupon-claim",
            "POST /api/admin/public/coupon-redeem",
            "POST /api/admin/public/order-confirm-receipt",
            "POST /api/admin/public/order-pay",
            "POST /api/admin/public/search-lab",
            "POST /api/admin/public/route-test"
    );

    private static final SecureRandom RANDOM = new SecureRandom();

    private final StringRedisTemplate redis;

    /** 解析后的账号表：用户名 → [口令, 角色]。首次使用时构建并缓存。 */
    private volatile Map<String, String[]> accounts;

    public AdminAuthInterceptor(StringRedisTemplate redis) {
        this.redis = redis;
    }

    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler)
            throws Exception {

        // C 端接口不参与后台鉴权（走 JWT，见 C_SIDE_PATHS 注释）
        String reqKey = req.getMethod().toUpperCase() + " " + req.getRequestURI();
        if (C_SIDE_PATHS.contains(reqKey)) {
            return true;
        }

        // 完全未配置 = 本地开发模式，放行。默认可用比默认锁死更符合实际使用。
        if (!authEnabled()) {
            return true;
        }

        String token = req.getHeader("X-Admin-Token");
        if (token == null || token.isBlank()) {
            return deny(resp, "未登录，请先登录", 401);
        }

        String session;
        try {
            session = redis.opsForValue().get(TOKEN_PREFIX + token);
        } catch (Exception e) {
            log.error("鉴权时 Redis 异常，拒绝请求", e);
            return deny(resp, "鉴权服务暂不可用", 503);
        }
        if (session == null) {
            return deny(resp, "登录已过期，请重新登录", 401);
        }

        String[] parts = session.split("\\|", 2);
        String username = parts[0];
        String role = parts.length > 1 ? parts[1] : "viewer";

        String path = req.getRequestURI();
        // 判定键是「方法 + 路径」：同一路径可能既有读也有写（如 agent/model 的 GET 与 POST），
        // 只按路径判断会误伤读接口。
        String key = req.getMethod().toUpperCase() + " " + path;
        boolean isWrite = WRITE_ENDPOINTS.contains(key);
        boolean isReadOnlyPost = READ_ONLY_POST.contains(key);

        if (!"admin".equals(role) && isWrite) {
            log.warn("越权拦截: 用户={} 角色={} 调用写接口 {}", username, role, key);
            return deny(resp, "当前账号为只读角色，无权执行该操作", 403);
        }
        // 兜底：POST 既不在写清单也不在只读清单 → 是新加的写接口忘了登记。
        // 选择「拒绝」而非「放行」——漏登记时宁可误伤也不放开权限。
        if (!"admin".equals(role) && "POST".equalsIgnoreCase(req.getMethod())
                && !isWrite && !isReadOnlyPost) {
            log.error("未登记的 POST 接口被 viewer 调用，已拒绝: {}（请加入 WRITE_ENDPOINTS 或 READ_ONLY_POST）", key);
            return deny(resp, "该接口未登记权限，已拒绝", 403);
        }

        req.setAttribute("adminUser", username);
        req.setAttribute("adminRole", role);

        try {
            redis.expire(TOKEN_PREFIX + token, tokenTtlHours, TimeUnit.HOURS);
        } catch (Exception ignored) { }
        return true;
    }

    /**
     * 登录。返回 null 表示失败。
     *
     * 失败只给「账号或口令错误」——区分「用户不存在」和「口令错」会让人能枚举有效用户名。
     */
    public Map<String, Object> login(String username, String password) {
        if (!authEnabled()) {
            return session("anonymous", "admin", "no-auth-required");
        }
        if (username == null || password == null) return null;

        String[] acc = accounts().get(username.trim());
        if (acc == null) return null;
        if (!constantTimeEquals(password, acc[0])) return null;

        return session(username.trim(), acc[1], null);
    }

    private Map<String, Object> session(String username, String role, String fixedToken) {
        String token = fixedToken;
        if (token == null) {
            byte[] buf = new byte[32];
            RANDOM.nextBytes(buf);
            token = HexFormat.of().formatHex(buf);
        }
        try {
            redis.opsForValue().set(TOKEN_PREFIX + token, username + "|" + role,
                    tokenTtlHours, TimeUnit.HOURS);
        } catch (Exception e) {
            log.error("写入登录会话失败", e);
            return null;
        }
        log.info("后台登录成功: 用户={} 角色={}", username, role);

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("ok", true);
        out.put("token", token);
        out.put("username", username);
        out.put("role", role);
        return out;
    }

    public void logout(String token) {
        if (token == null || token.isBlank()) return;
        try {
            redis.delete(TOKEN_PREFIX + token);
        } catch (Exception e) {
            log.warn("登出清理令牌失败: {}", e.getMessage());
        }
    }

    /** 当前令牌对应的身份，供 auth-status 返回。 */
    public Map<String, String> whoami(String token) {
        if (token == null || token.isBlank()) return null;
        try {
            String s = redis.opsForValue().get(TOKEN_PREFIX + token);
            if (s == null) return null;
            String[] p = s.split("\\|", 2);
            return Map.of("username", p[0], "role", p.length > 1 ? p[1] : "viewer");
        } catch (Exception e) {
            return null;
        }
    }

    public boolean authEnabled() {
        return (usersConfig != null && !usersConfig.isBlank())
                || (adminPassword != null && !adminPassword.isBlank());
    }

    /**
     * 解析账号配置。
     *
     * 单口令模式（admin.password）映射为用户名 {@code admin} 的 admin 账号，
     * 保证旧配置仍可用，不必一次性改部署脚本。
     */
    private Map<String, String[]> accounts() {
        Map<String, String[]> cached = this.accounts;
        if (cached != null) return cached;

        Map<String, String[]> map = new LinkedHashMap<>();
        if (usersConfig != null && !usersConfig.isBlank()) {
            for (String entry : usersConfig.split(",")) {
                String[] f = entry.trim().split(":");
                if (f.length < 2) {
                    log.warn("ADMIN_USERS 配置项格式错误（应为 用户名:口令:角色），已跳过: {}", entry);
                    continue;
                }
                String u = f[0].trim();
                String p = f[1];
                String r = f.length >= 3 ? f[2].trim() : "viewer";
                if (!List.of("admin", "viewer").contains(r)) {
                    log.warn("未知角色 {}，账号 {} 降为 viewer", r, u);
                    r = "viewer";
                }
                map.put(u, new String[]{p, r});
            }
        }
        if (map.isEmpty() && adminPassword != null && !adminPassword.isBlank()) {
            map.put("admin", new String[]{adminPassword, "admin"});
        }
        log.info("后台账号已加载: {}", map.entrySet().stream()
                .map(e -> e.getKey() + "=" + e.getValue()[1]).toList());
        this.accounts = map;
        return map;
    }

    /** 常量时间比较，防时序侧信道。 */
    private boolean constantTimeEquals(String a, String b) {
        return MessageDigest.isEqual(
                a.getBytes(StandardCharsets.UTF_8), b.getBytes(StandardCharsets.UTF_8));
    }

    private boolean deny(HttpServletResponse resp, String msg, int status) throws Exception {
        resp.setStatus(status);
        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write("{\"error\":\"" + msg + "\",\"needLogin\":" + (status == 401) + "}");
        return false;
    }
}
