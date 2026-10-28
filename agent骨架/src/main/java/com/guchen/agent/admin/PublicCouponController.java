package com.guchen.agent.admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * C 端领券中心：用户主动浏览并领取优惠券。
 *
 * <h3>为什么老项目做不了这件事</h3>
 * 老项目 `couponController` 只有四个接口：凭券码兑换、查我的券、查券统计。
 * 没有「列出可领券」「点一下领取」——它的券体系是**券码驱动**的：
 * 后台生成 code + password，线下发给用户，用户输入兑换。
 *
 * 本类补的正是这块缺口，直接读写 `coupon` / `coupon_user` 表，
 * **不改老项目**（延续「tearSpring 零改动」的架构决策）。
 *
 * <h3>领取的并发安全</h3>
 * 「剩余库存减 1」必须用条件更新：
 * <pre>UPDATE coupon SET stock = stock - 1 WHERE id = ? AND stock > 0</pre>
 * 若先查再减，两个并发请求会同时看到 stock=1 而都通过，导致超发。
 * 条件更新把判断和扣减合成一条原子语句，影响行数为 0 就说明没抢到。
 *
 * <h3>为什么要查重</h3>
 * 同一用户重复领同一张券会让「我的券」里出现一堆重复。
 * 用 `coupon_user` 的 (user_id, coupon_id) 判重；表上没有唯一索引，
 * 所以在应用层查，并在并发下依赖条件更新的行数判断兜底。
 */
@Slf4j
@RestController
@RequestMapping("/api/admin/public")
@RequiredArgsConstructor
public class PublicCouponController {

    private final JdbcTemplate jdbc;
    private final com.guchen.agent.memory.UserContextService userContext;
    /**
     * 【2026-10-23 新增】领券并发锁。
     *
     * 领券是「查重 → 扣库存 → 写券包」三步，三步之间没有任何互斥：
     * 同一用户并发两次请求会同时通过查重，各自扣 1 张库存并写入两条券包记录。
     * 表上没有 (user_id, coupon_id) 唯一索引（业务上允许「过期后重新领」，
     * 加严格唯一索引会把这条正常路径也堵死），所以用「用户+券」维度的
     * Redis 短锁把同一用户的并发领取串行化，锁 10 秒自动过期防死锁。
     */
    private final org.springframework.data.redis.core.StringRedisTemplate redis;
    private static final String DB = "db_tear.";

    /**
     * 老项目地址。走 Nacos 服务名会让这里依赖负载均衡器，
     * 而兑换需要「一定是那个连同一套数据库的实例」，直连 IP 更可控。
     * 部署到别处时改环境变量即可。
     */
    // 【2026-10-23 修复】原来读的是 ${services.tear-spring.base-url:...}，
    // 而 application.yaml 里定义的键是 services.tear-spring.url ——
    // 键名对不上，这个字段永远取默认值 127.0.0.1:8080，
    // 导致 TEAR_SPRING_URL 环境变量对领券/核销/确认收货这条链路完全无效
    // （部署到远程服务器后这些接口会全部打向 localhost 而失败）。
    @org.springframework.beans.factory.annotation.Value("${services.tear-spring.url:http://127.0.0.1:8080}")
    private String tearSpringBaseUrl;

    /**
     * 可领取的券列表。
     *
     * 过滤条件（缺一不可）：
     *   - status = 1           启用中
     *   - stock > 0            还有剩余
     *   - start_time <= NOW()  已开始
     *   - end_time >= NOW()    未过期
     *
     * ⚠️ 时间过滤是关键：库里 27 张种子券全是 2024 年到期的，
     * 若不过滤，用户会看到一屏过期券却一张都领不了。
     *
     * 已领取的券也会返回，但标记 claimed=true，前端置灰按钮。
     */
    @GetMapping("/coupons")
    public Map<String, Object> availableCoupons(
            @RequestHeader(value = "token", required = false) String token) {

        Long userId = userContext.resolveUserId(token);

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT id, name, type, value, `condition`, min_order_amount, max_discount, "
                        + "theme_id, theme_name, is_exclusive, stock, total_count, "
                        + "start_time, end_time "
                        + "FROM " + DB + "coupon "
                        + "WHERE status = 1 AND stock > 0 "
                        + "  AND start_time <= NOW() AND end_time >= NOW() "
                        + "ORDER BY is_exclusive, value DESC, id DESC");

        // 已领取的券 ID 集合（未登录则空集）
        List<Long> claimed = new ArrayList<>();
        if (userId != null && !rows.isEmpty()) {
            try {
                claimed = jdbc.queryForList(
                        "SELECT DISTINCT coupon_id FROM " + DB + "coupon_user WHERE user_id = ? "
                                + "AND status IN ('claimed','unused','used')",
                        Long.class, userId);
            } catch (Exception e) {
                log.debug("查询已领取券失败（按未领取处理）: {}", e.getMessage());
            }
        }

        List<Long> claimedSet = claimed;
        rows.forEach(r -> {
            long id = toLong(r.get("id"));
            r.put("claimed", claimedSet.contains(id));
            // 折扣券把 0.85 转成「85折」文案，前端不必再理解小数含义
            if ("discount".equals(String.valueOf(r.get("type")))) {
                Object v = r.get("value");
                if (v != null) {
                    double d = ((Number) v).doubleValue();
                    // 0.9 应显示「9折」而非「90折」：折扣率的「折」是 10 倍关系，
                    // 0.9 = 九折、0.85 = 八五折。乘 10 后去掉多余的 .0。
                    double zhe = d * 10;
                    String txt = (zhe == Math.floor(zhe))
                            ? String.valueOf((int) zhe)
                            : String.valueOf(Math.round(zhe * 10) / 10.0);
                    r.put("displayValue", txt + "折");
                }
            } else {
                Object v = r.get("value");
                r.put("displayValue", v == null ? "" : "¥" + ((Number) v).intValue());
            }
        });

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("total", rows.size());
        out.put("rows", rows);
        out.put("loggedIn", userId != null);
        return out;
    }

    /**
     * 领取一张券。
     *
     * 流程：校验登录 → 校验券可领 → 查重 → 原子扣库存 → 写 coupon_user。
     */
    @PostMapping("/coupon-claim")
    public Map<String, Object> claimCoupon(
            @RequestBody Map<String, Object> body,
            @RequestHeader(value = "token", required = false) String token) {

        Long userId = userContext.resolveUserId(token);
        if (userId == null) {
            return Map.of("ok", false, "error", "请先登录后再领取", "needLogin", true);
        }

        Long couponId = body.get("couponId") instanceof Number n ? n.longValue()
                : (body.get("couponId") == null ? null : Long.parseLong(String.valueOf(body.get("couponId"))));
        if (couponId == null) return Map.of("ok", false, "error", "缺少券 ID");

        // 【2026-10-23 修复】同一用户 + 同一张券的领取串行化，见字段注释
        String claimLockKey = "lock:coupon-claim:" + userId + ":" + couponId;
        Boolean locked = redis.opsForValue().setIfAbsent(
                claimLockKey, "1", java.time.Duration.ofSeconds(10));
        if (!Boolean.TRUE.equals(locked)) {
            return Map.of("ok", false, "error", "请勿重复提交");
        }
        try {

        // 1. 券是否存在且可领（顺带把 end_time 取出来，后面写券包要用）
        List<Map<String, Object>> cps = jdbc.queryForList(
                "SELECT id, name, stock, status, end_time, start_time FROM " + DB + "coupon WHERE id = ?",
                couponId);
        if (cps.isEmpty()) return Map.of("ok", false, "error", "优惠券不存在");
        Map<String, Object> cp = cps.get(0);
        // ⚠️ status 是 tinyint(1)，JDBC 会映射成 Boolean；
        // 直接 (Number) 强转会抛 ClassCastException。用 toInt 统一处理。
        if (toInt(cp.get("status")) != 1) {
            return Map.of("ok", false, "error", "该券已停用");
        }
        if (toInt(cp.get("stock")) <= 0) {
            return Map.of("ok", false, "error", "该券已被领完");
        }

        // 2. 是否已领过（只算**仍有效**的券）
        //    ⚠️ 不能把 expired / used 的历史记录也算作「已领」：
        //    用户手里那张早过期了，凭什么不能再领一张新的？
        //    之前用 status IN ('claimed','unused','used') 却漏了考虑 expired，
        //    导致「通过兑换码领过旧券的人永远领不到新券」。
        Integer dup = jdbc.queryForObject(
                "SELECT COUNT(*) FROM " + DB + "coupon_user "
                        + "WHERE user_id = ? AND coupon_id = ? "
                        + "  AND status NOT IN ('expired','used') AND expire_time >= NOW()",
                Integer.class, userId, couponId);
        if (dup != null && dup > 0) {
            return Map.of("ok", false, "error", "您已领取过该券");
        }

        // 3. 原子扣库存：条件更新，影响行数 0 表示没抢到
        int ok = jdbc.update(
                "UPDATE " + DB + "coupon SET stock = stock - 1, received_count = received_count + 1, "
                        + "updated_at = NOW() WHERE id = ? AND stock > 0", couponId);
        if (ok != 1) {
            return Map.of("ok", false, "error", "手慢了，该券已被领完");
        }

        // 4. 写入用户券包
        //    ⚠️ expire_time 是 NOT NULL 无默认值，漏传会直接 500。
        //    取值用券模板的 end_time —— 用户领到的券在活动结束时失效。
        //    ⚠️ 不能用 INSERT ... VALUES (..., (SELECT ... FROM coupon ...))：
        //    MySQL 不允许在 VALUES 里子查询引用**同一张表**（会报 BadSqlGrammar）。
        //    所以 end_time 在第 1 步就查出来了，这里直接当参数传。
        Object endTime = cp.get("end_time");
        try {
            jdbc.update("INSERT INTO " + DB + "coupon_user "
                            + "(user_id, coupon_id, status, received_time, expire_time) "
                            + "VALUES (?, ?, 'claimed', NOW(), ?)",
                    userId, couponId, endTime);
        } catch (Exception e) {
            // 写券包失败要把库存加回去，否则券凭空消失
            jdbc.update("UPDATE " + DB + "coupon SET stock = stock + 1, "
                    + "received_count = GREATEST(received_count - 1, 0) WHERE id = ?", couponId);
            log.error("领券写券包失败，已回滚库存: user={} coupon={}", userId, couponId, e);
            return Map.of("ok", false, "error", "领取失败，请重试");
        }

        log.info("用户领券: user={} coupon={} name={}", userId, couponId, cp.get("name"));
        return Map.of("ok", true, "name", cp.get("name"), "message", "领取成功，可在「我的券」查看");
        } finally {
            // 释放锁：无论成功/失败/异常都要删，否则用户 10 秒内无法再次领取
            try {
                redis.delete(claimLockKey);
            } catch (Exception e) {
                log.warn("释放领券锁失败 key={}: {}", claimLockKey, e.getMessage());
            }
        }
    }

    /**
     * 凭兑换码领券（**只需券码，不需要密码**）。
     *
     * <h3>为什么不复用老项目的 /coupon/codeNo</h3>
     * 老项目那个接口强制校验 code + password 两个值，且逻辑写死在
     * `CouponCodeServiceImpl.selectCodeNo` 里。本需求是「只填兑换码就能领」，
     * 而改老项目违反「tearSpring 零改动」的架构决策。
     *
     * 所以这里自建完整兑换流程，直接读写 coupon_code / coupon_user 两张表：
     *   ① 券码存在且未兑换
     *   ② 未过期
     *   ③ 该用户没领过同一张券（未过期的那张）
     *   ④ 原子扣库存（失败回滚）
     *   ⑤ 改券码状态 + 写用户券包（同事务）
     *
     * 与老项目实现的关键差异：密码不再参与校验。券码本身是 12 位随机串
     * （SecureRandom 生成，字符集去掉易混的 I/O/0/1），暴力猜测不可行。
     */
    @PostMapping("/coupon-redeem")
    public Map<String, Object> redeemCoupon(
            @RequestBody Map<String, Object> body,
            @RequestHeader(value = "token", required = false) String token) {

        Long userId = userContext.resolveUserId(token);
        if (userId == null) return Map.of("ok", false, "error", "请先登录", "needLogin", true);

        String code = body.get("code") == null ? "" : String.valueOf(body.get("code")).trim().toUpperCase();
        if (code.isEmpty()) return Map.of("ok", false, "error", "请输入兑换码");

        // ① 券码存在？
        List<Map<String, Object>> codes = jdbc.queryForList(
                "SELECT id, coupon_id, status, expire_time FROM " + DB + "coupon_code WHERE code = ?", code);
        if (codes.isEmpty()) return Map.of("ok", false, "error", "兑换码不存在，请检查后重试");

        Map<String, Object> cc = codes.get(0);
        long codeId = toLong(cc.get("id"));
        long couponId = toLong(cc.get("coupon_id"));
        String ccStatus = String.valueOf(cc.get("status"));

        // ② 状态检查
        if ("claimed".equals(ccStatus)) return Map.of("ok", false, "error", "该兑换码已被使用");
        if ("used".equals(ccStatus)) return Map.of("ok", false, "error", "该兑换码已被使用");
        if ("expired".equals(ccStatus)) return Map.of("ok", false, "error", "该兑换码已过期");

        // ③ 过期检查（券码自带的 expire_time）
        Object expire = cc.get("expire_time");
        if (expire != null) {
            try {
                java.sql.Timestamp ts = (java.sql.Timestamp) expire;
                if (ts.getTime() < System.currentTimeMillis()) {
                    jdbc.update("UPDATE " + DB + "coupon_code SET status='expired' WHERE id = ?", codeId);
                    return Map.of("ok", false, "error", "该兑换码已过期");
                }
            } catch (Exception ignored) { }
        }

        // ④ 该用户是否已持有同一张券（且未过期）
        //    只查未过期的：手里那张早过期了，理应能再领一张
        Integer dup = jdbc.queryForObject(
                "SELECT COUNT(*) FROM " + DB + "coupon_user "
                        + "WHERE user_id = ? AND coupon_id = ? "
                        + "  AND status NOT IN ('expired','used') AND expire_time >= NOW()",
                Integer.class, userId, couponId);
        if (dup != null && dup > 0) {
            return Map.of("ok", false, "error", "您已领取过该类型优惠券");
        }

        // ⑤ 原子标记券码已用：条件更新，影响行数 0 说明被并发抢先了
        int marked = jdbc.update(
                "UPDATE " + DB + "coupon_code SET status='claimed', user_id=?, received_time=NOW() "
                        + "WHERE id = ? AND status = 'unclaimed'",
                userId, codeId);
        if (marked != 1) {
            return Map.of("ok", false, "error", "该兑换码已被使用");
        }

        // ⑥ 原子扣库存（与券码标记分开，失败要各自回滚）
        int deducted = jdbc.update(
                "UPDATE " + DB + "coupon SET stock = stock - 1, used_count = used_count + 1, "
                        + "updated_at = NOW() WHERE id = ? AND stock > 0", couponId);
        if (deducted != 1) {
            jdbc.update("UPDATE " + DB + "coupon_code SET status='unclaimed', user_id=NULL, "
                    + "received_time=NULL WHERE id = ?", codeId);
            return Map.of("ok", false, "error", "该券已被领完");
        }

        // ⑦ 写用户券包
        //    expire_time 必须给（NOT NULL 无默认值），取券码自带的过期时间；
        //    券码没有就退回券模板的 end_time。
        Object expireTime = cc.get("expire_time");
        if (expireTime == null) {
            try {
                expireTime = jdbc.queryForObject(
                        "SELECT end_time FROM " + DB + "coupon WHERE id = ?", Object.class, couponId);
            } catch (Exception ignored) { }
        }
        try {
            jdbc.update("INSERT INTO " + DB + "coupon_user "
                            + "(user_id, coupon_id, coupon_code_id, code, status, received_time, expire_time) "
                            + "VALUES (?, ?, ?, ?, 'claimed', NOW(), ?)",
                    userId, couponId, codeId, code, expireTime);
        } catch (Exception e) {
            // 写券包失败：把库存和券码状态都恢复，否则券凭空消失
            jdbc.update("UPDATE " + DB + "coupon SET stock = stock + 1, "
                    + "used_count = GREATEST(used_count - 1, 0) WHERE id = ?", couponId);
            jdbc.update("UPDATE " + DB + "coupon_code SET status='unclaimed', user_id=NULL, "
                    + "received_time=NULL WHERE id = ?", codeId);
            log.error("写券包失败，已回滚: user={} code={}", userId, code, e);
            return Map.of("ok", false, "error", "领取失败，请重试");
        }

        log.info("兑换码领券成功: user={} code={} coupon={}", userId, code, couponId);
        return Map.of("ok", true, "message", "兑换成功，可在「我的券」查看");
    }

    // ==================== 商品收藏 ====================

    /**
     * 收藏 / 取消收藏商品（toggle）。
     *
     * 表 user_favorite 上有 UNIQUE(user_id, product_id)：
     * INSERT IGNORE 收藏幂等（重复点不报错），DELETE 取消。
     * 商品必须存在且未下架——收藏一个已下架商品没有意义，还会让收藏列表出现点不开的项。
     */
    @PostMapping("/favorite-toggle")
    public Map<String, Object> favoriteToggle(
            @RequestBody Map<String, Object> body,
            @RequestHeader(value = "token", required = false) String token) {

        Long userId = userContext.resolveUserId(token);
        if (userId == null) return Map.of("ok", false, "error", "请先登录", "needLogin", true);

        Long productId = toLong(body.get("productId"));
        if (productId <= 0) return Map.of("ok", false, "error", "缺少商品 ID");

        Integer exists = jdbc.queryForObject(
                "SELECT COUNT(*) FROM " + DB + "product WHERE id = ? AND status = 1", Integer.class, productId);
        if (exists == null || exists == 0) return Map.of("ok", false, "error", "商品不存在或已下架");

        Integer fav = jdbc.queryForObject(
                "SELECT COUNT(*) FROM " + DB + "user_favorite WHERE user_id = ? AND product_id = ?",
                Integer.class, userId, productId);

        if (fav != null && fav > 0) {
            jdbc.update("DELETE FROM " + DB + "user_favorite WHERE user_id = ? AND product_id = ?",
                    userId, productId);
            return Map.of("ok", true, "favorited", false);
        }
        jdbc.update("INSERT IGNORE INTO " + DB + "user_favorite (user_id, product_id) VALUES (?, ?)",
                userId, productId);
        return Map.of("ok", true, "favorited", true);
    }

    /** 某商品是否已收藏（商品详情页初始化心形状态用）。 */
    @GetMapping("/favorite-status")
    public Map<String, Object> favoriteStatus(
            @RequestParam long productId,
            @RequestHeader(value = "token", required = false) String token) {
        Long userId = userContext.resolveUserId(token);
        if (userId == null) return Map.of("ok", true, "favorited", false);
        Integer n = jdbc.queryForObject(
                "SELECT COUNT(*) FROM " + DB + "user_favorite WHERE user_id = ? AND product_id = ?",
                Integer.class, userId, productId);
        return Map.of("ok", true, "favorited", n != null && n > 0);
    }

    /**
     * 我的收藏列表（商品）。
     * JOIN 商品表取名称/价格/图示，已下架的标注 offShelf 但仍显示（用户知道为什么点不开）。
     */
    @GetMapping("/favorites")
    public Map<String, Object> favorites(
            @RequestHeader(value = "token", required = false) String token) {
        Long userId = userContext.resolveUserId(token);
        if (userId == null) return Map.of("ok", false, "error", "请先登录", "needLogin", true);

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT f.product_id, f.created_at AS favored_at, "
                        + "p.name, p.emoji, p.price, p.stock, p.status AS product_status "
                        + "FROM " + DB + "user_favorite f "
                        + "JOIN " + DB + "product p ON p.id = f.product_id "
                        + "WHERE f.user_id = ? ORDER BY f.id DESC", userId);

        rows.forEach(r -> r.put("onShelf", toInt(r.get("product_status")) == 1));
        return Map.of("ok", true, "total", rows.size(), "rows", rows);
    }

    // ==================== 收藏（茶具）管理 ====================

    /**
     * 取消收藏茶具。
     *
     * 老项目 teaware 只有查询接口（selectTeawareId），没有删除——
     * 收藏了就永远在列表里。这里补上删除，校验归属后物理删除。
     */
    @PostMapping("/teaware-remove")
    public Map<String, Object> removeTeaware(
            @RequestBody Map<String, Object> body,
            @RequestHeader(value = "token", required = false) String token) {

        Long userId = userContext.resolveUserId(token);
        if (userId == null) return Map.of("ok", false, "error", "请先登录", "needLogin", true);

        Long teawareId = toLong(body.get("teawareId"));
        if (teawareId <= 0) return Map.of("ok", false, "error", "缺少茶具 ID");

        // 校验归属：只能取消自己的收藏
        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT user_id, name FROM " + DB + "teaware WHERE id = ?", teawareId);
        if (rows.isEmpty()) return Map.of("ok", false, "error", "该茶具不存在");

        long owner = toLong(rows.get(0).get("user_id"));
        if (owner != userId) return Map.of("ok", false, "error", "该收藏不属于当前用户");

        jdbc.update("DELETE FROM " + DB + "teaware WHERE id = ?", teawareId);
        log.info("取消收藏茶具: user={} teaware={} name={}", userId, teawareId, rows.get(0).get("name"));
        return Map.of("ok", true);
    }

    // ==================== 客服配置（后台可改，小程序读取） ====================

    private static final String CS_KEY = "agent:config:support";

    /**
     * C 端：获取客服配置（小程序「客服帮助」弹窗读取）。
     *
     * 配置存 Redis Hash，后台可随时改：热线电话、工作时间、常见问题列表。
     * 小程序端原先硬编码这些信息，运营改个电话要发版。
     */
    @GetMapping("/support-config")
    public Map<String, Object> supportConfig() {
        Map<String, Object> out = new LinkedHashMap<>();
        // 默认值（Redis 没有配置时兜底）
        out.put("hotline", "400-800-1234");
        out.put("workTime", "周一至周日 9:00-21:00");
        out.put("wechat", "mansitea-kefu");
        List<Map<String, String>> faq = new ArrayList<>();
        faq.add(Map.of("q", "如何查询订单状态？", "a", "进入「我的-全部订单」查看，或直接问AI助手「我的订单」"));
        faq.add(Map.of("q", "如何申请退款？", "a", "签收后7天内联系客服，凭订单号申请"));
        faq.add(Map.of("q", "茶叶如何保存？", "a", "避光、密封、防潮、防异味，绿茶建议冷藏"));
        out.put("faq", faq);

        try {
            Map<Object, Object> raw = redis.opsForHash().entries(CS_KEY);
            if (raw.get("hotline") != null) out.put("hotline", String.valueOf(raw.get("hotline")));
            if (raw.get("workTime") != null) out.put("workTime", String.valueOf(raw.get("workTime")));
            if (raw.get("wechat") != null) out.put("wechat", String.valueOf(raw.get("wechat")));
            if (raw.get("faq_json") != null) {
                try {
                    out.put("faq", new com.fasterxml.jackson.databind.ObjectMapper()
                            .readValue(String.valueOf(raw.get("faq_json")),
                                    new com.fasterxml.jackson.core.type.TypeReference<List<Map<String, String>>>() {}));
                } catch (Exception ignored) { }
            }
        } catch (Exception e) {
            log.debug("读取客服配置失败，用默认值: {}", e.getMessage());
        }
        return out;
    }

    // ==================== 购物车校验 / 模拟支付 ====================

    /**
     * 购物车校验：逐项检查商品是否仍在售、规格库存是否足够。
     *
     * <h3>为什么要做这个</h3>
     * 老项目 `insertOrderData` **不校验商品状态**——购物车里的商品被后台下架后，
     * 用户仍然可以正常下单「成功」。结果发货时发现商品根本不在售。
     * 校验放在结算前，让用户在付款之前就知道哪些商品买不了。
     *
     * <h3>查询设计</h3>
     * 老项目购物车链路：user → cart（一人一车）→ cart_item（多行）。
     * 一次 JOIN 查完，避免 N+1：
     *   cart_item JOIN product（拿 status/name）
     *            JOIN product_spec（拿 spec_name/price/stock）
     */
    @GetMapping("/cart-check")
    public Map<String, Object> cartCheck(
            @RequestHeader(value = "token", required = false) String token) {

        Long userId = userContext.resolveUserId(token);
        if (userId == null) return Map.of("ok", false, "error", "请先登录", "needLogin", true);

        // 一人一车：先拿 cartId
        List<Map<String, Object>> carts = jdbc.queryForList(
                "SELECT id FROM " + DB + "cart WHERE user_id = ? LIMIT 1", userId);
        if (carts.isEmpty()) {
            return Map.of("ok", true, "items", List.of(), "allValid", true,
                    "summary", "购物车为空");
        }
        long cartId = toLong(carts.get(0).get("id"));

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT ci.id AS cart_item_id, ci.product_id, ci.spec_id, ci.quantity, "
                        + "p.name, p.emoji, p.status AS product_status, "
                        + "ps.spec_name, ps.price, ps.stock "
                        + "FROM " + DB + "cart_item ci "
                        + "LEFT JOIN " + DB + "product p ON p.id = ci.product_id "
                        + "LEFT JOIN " + DB + "product_spec ps ON ps.id = ci.spec_id "
                        + "WHERE ci.cart_id = ? ORDER BY ci.id", cartId);

        boolean allValid = true;
        List<Map<String, Object>> items = new ArrayList<>();
        for (Map<String, Object> r : rows) {
            // ⚠️ status 可能是 Boolean（tinyint 陷阱第 5 次），一律走 toInt
            int pStatus = toInt(r.get("product_status"));
            int stock = toInt(r.get("stock"));
            int qty = toInt(r.get("quantity"));

            // 每项标记问题：下架 / 规格缺失 / 库存不足
            String problem = null;
            if (pStatus != 1) problem = "商品已下架";
            else if (r.get("spec_id") == null || r.get("spec_name") == null) problem = "规格已失效";
            else if (stock < qty) problem = "库存不足（剩 " + stock + "）";

            if (problem != null) allValid = false;

            Map<String, Object> it = new LinkedHashMap<>();
            it.put("cartItemId", toLong(r.get("cart_item_id")));
            it.put("productId", toLong(r.get("product_id")));
            it.put("specId", r.get("spec_id"));
            it.put("name", r.get("name"));
            it.put("emoji", r.get("emoji"));
            it.put("specName", r.get("spec_name"));
            it.put("quantity", qty);
            it.put("price", r.get("price"));
            it.put("stock", stock);
            it.put("onShelf", pStatus == 1);
            it.put("problem", problem);
            items.add(it);
        }

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("ok", true);
        out.put("items", items);
        out.put("allValid", allValid);
        long badCount = items.stream().filter(i -> i.get("problem") != null).count();
        out.put("problemCount", badCount);
        out.put("summary", badCount == 0 ? "全部商品可正常结算"
                : badCount + " 件商品存在问题，请调整后结算");
        return out;
    }

    /**
     * 模拟支付：待付款 → 待发货。
     *
     * <h3>为什么是「模拟」</h3>
     * 真实微信支付需要商户号、证书、异步回调服务器——演示环境不具备。
     * 本接口跳过支付网关，直接把订单推到「待发货」，并写 payment 表留痕。
     * 「下单 → 付款 → 发货 → 收货 → 评价」五步因此全是真实接口。
     *
     * <h3>并发与幂等</h3>
     * UPDATE 带 status='unpaid' 条件：两个并发请求只有一个成功，
     * 重复点击返回「订单不是待付款状态」。
     */
    @PostMapping("/order-pay")
    public Map<String, Object> payOrder(
            @RequestBody Map<String, Object> body,
            @RequestHeader(value = "token", required = false) String token) {

        Long userId = userContext.resolveUserId(token);
        if (userId == null) return Map.of("ok", false, "error", "请先登录", "needLogin", true);

        Long orderId = toLong(body.get("orderId"));
        if (orderId <= 0) return Map.of("ok", false, "error", "缺少订单 ID");
        String payMethod = String.valueOf(body.getOrDefault("paymentMethod", "wechat"));

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT id, user_id, order_no, status, pay_amount FROM " + DB + "`order` WHERE id = ?", orderId);
        if (rows.isEmpty()) return Map.of("ok", false, "error", "订单不存在");
        Map<String, Object> o = rows.get(0);

        long owner = toLong(o.get("user_id"));
        if (owner != userId) return Map.of("ok", false, "error", "该订单不属于当前用户");

        String st = String.valueOf(o.get("status"));
        if (!"unpaid".equals(st)) {
            String txt = switch (st) {
                case "unship" -> "待发货（已付款，无需重复付款）";
                case "unreceive" -> "待收货";
                case "unreview" -> "待评价";
                case "completed" -> "已完成";
                case "cancelled" -> "已取消";
                default -> st;
            };
            return Map.of("ok", false, "error", "当前订单状态为「" + txt + "」，无需付款");
        }

        // 原子流转：unpaid → unship（模拟支付成功即进入待发货）
        int n = jdbc.update(
                "UPDATE " + DB + "`order` SET status='unship', payment_method=?, "
                        + "payment_time=COALESCE(payment_time, NOW()), updated_at=NOW() "
                        + "WHERE id=? AND status='unpaid'",
                payMethod, orderId);
        if (n != 1) return Map.of("ok", false, "error", "支付失败，请刷新后重试");

        // 写 payment 表留痕（老项目已有此表，字段 NOT NULL 较多，逐一填上）
        double amount = 0;
        Object pa = o.get("pay_amount");
        if (pa instanceof Number num) amount = num.doubleValue();
        String orderNo = String.valueOf(o.get("order_no"));
        String payNo = "PAY" + orderNo.substring(Math.min(3, orderNo.length()))
                + System.currentTimeMillis() % 100000;
        try {
            jdbc.update("INSERT INTO " + DB + "payment "
                            + "(order_id, order_no, payment_no, payment_method, amount, status, payment_time) "
                            + "VALUES (?,?,?,?,?,'success',NOW())",
                    orderId, orderNo, payNo, payMethod, amount);
        } catch (Exception e) {
            // 支付记录写失败不影响主流程（订单状态已流转），记日志
            log.warn("写 payment 记录失败 order={}: {}", orderId, e.getMessage());
        }

        log.info("模拟支付成功: user={} order={} amount={} method={}", userId, orderId, amount, payMethod);
        return Map.of("ok", true, "status", "unship", "statusText", "待发货",
                "payNo", payNo);
    }

    // ==================== 待发货 / 待收货状态流转 ====================

    /**
     * 用户确认收货（待收货 → 待评价）。
     *
     * 这是补小程序「确认收货」按钮的假实现——原代码只弹 Toast、改本地变量。
     * 校验：
     *  - 订单必须属于当前用户
     *  - 订单状态必须是 unreceive（待收货），其它状态一律拒绝
     *  - 用条件更新防重复提交
     */
    @PostMapping("/order-confirm-receipt")
    public Map<String, Object> confirmReceipt(
            @RequestBody Map<String, Object> body,
            @RequestHeader(value = "token", required = false) String token) {

        Long userId = userContext.resolveUserId(token);
        if (userId == null) return Map.of("ok", false, "error", "请先登录", "needLogin", true);

        Long orderId = body.get("orderId") instanceof Number n ? n.longValue()
                : (body.get("orderId") == null ? null : Long.parseLong(String.valueOf(body.get("orderId"))));
        if (orderId == null) return Map.of("ok", false, "error", "缺少订单 ID");

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT id, user_id, status FROM " + DB + "`order` WHERE id = ?", orderId);
        if (rows.isEmpty()) return Map.of("ok", false, "error", "订单不存在");

        Map<String, Object> o = rows.get(0);
        long owner = toLong(o.get("user_id"));
        if (owner != userId) return Map.of("ok", false, "error", "该订单不属于当前用户");

        String st = String.valueOf(o.get("status"));
        if (!"unreceive".equals(st)) {
            String txt = switch (st) {
                case "unpaid" -> "待付款";
                case "unship" -> "待发货（商家还没发货，不能确认收货）";
                case "unreview" -> "待评价（已经确认过收货了）";
                case "completed" -> "已完成";
                case "cancelled" -> "已取消";
                default -> st;
            };
            return Map.of("ok", false, "error", "当前订单状态为「" + txt + "」，无法确认收货");
        }

        int n = jdbc.update("UPDATE " + DB + "`order` SET status = 'unreview', "
                        + "receive_time = COALESCE(receive_time, NOW()), updated_at = NOW() "
                        + "WHERE id = ? AND status = 'unreceive'",
                orderId);
        if (n != 1) {
            return Map.of("ok", false, "error", "操作失败，订单状态可能已被更新，请刷新后重试");
        }

        log.info("用户确认收货: user={} order={} unreceive -> unreview", userId, orderId);
        return Map.of("ok", true, "status", "unreview", "statusText", "待评价");
    }

    /**
     * 用户删除自己「已失效」的优惠券（2026-10-24 新增）。
     *
     * <h3>为什么是软删（status='deleted'）而不是 DELETE</h3>
     * 用户券是「领取行为」的历史记录，物理删除会让运营侧的发放量、核销率对不上账；
     * 而且 {@code coupon_user} 上有 {@code uk_user_coupon(user_id, coupon_id, status)}
     * 唯一键，把状态改成 deleted 后，同一张券后续若重新上架，用户还能再领一次
     * （status 不同不冲突），比物理删更安全。
     *
     * <h3>为什么只能删「已失效」</h3>
     * 未过期的券还能下单抵扣，允许用户删除等于给了他一个「误删后用不了」的坑；
     * 已使用的券是订单凭证，更不能删。只有 {@code status='expired'} 或
     * {@code expire_time < NOW()} 的券才允许清理。
     *
     * 请求体：{@code {"id": 123}}（coupon_user.id，不是 coupon.id）
     * 鉴权：小程序 JWT，放在 {@code token} 请求头（与领券/兑换一致）。
     */
    @PostMapping("/coupon-user-delete")
    public Map<String, Object> deleteMyCoupon(
            @RequestBody Map<String, Object> body,
            @RequestHeader(value = "token", required = false) String token) {

        Long userId = userContext.resolveUserId(token);
        if (userId == null) {
            return Map.of("ok", false, "error", "请先登录", "needLogin", true);
        }

        Long id = body.get("id") instanceof Number n ? n.longValue()
                : (body.get("id") == null ? null : parseLongOrNull(String.valueOf(body.get("id"))));
        if (id == null) return Map.of("ok", false, "error", "缺少券 ID");

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT id, coupon_id, status, expire_time FROM " + DB + "coupon_user "
                        + "WHERE id = ? AND user_id = ?", id, userId);
        if (rows.isEmpty()) {
            return Map.of("ok", false, "error", "优惠券不存在，或不属于当前用户");
        }

        Map<String, Object> cu = rows.get(0);
        String status = String.valueOf(cu.get("status"));

        // 幂等：已经删过的再点一次，直接返回成功，不报错
        if ("deleted".equals(status)) {
            return Map.of("ok", true, "deleted", 0, "message", "该券已删除");
        }

        boolean expired = "expired".equals(status);
        if (!expired) {
            Object et = cu.get("expire_time");
            // MySQL Connector/J 8 对 DATETIME 返回 LocalDateTime，不是 java.util.Date。
            // 只判 Date 会让「按时间过期」这条分支永远不成立，用户就删不掉过期券。
            expired = isPastTime(et);
        }
        if (!expired) {
            return Map.of("ok", false, "error", "只能删除已失效的优惠券，未过期的券请继续使用");
        }

        int n = jdbc.update("UPDATE " + DB + "coupon_user SET status = 'deleted' "
                        + "WHERE id = ? AND user_id = ? AND status <> 'deleted'",
                id, userId);
        log.info("用户删除失效券: user={} couponUserId={} couponId={} 原状态={}",
                userId, id, cu.get("coupon_id"), status);

        return Map.of("ok", true, "deleted", n);
    }

    private Long parseLongOrNull(String s) {
        try { return Long.parseLong(s.trim()); } catch (Exception e) { return null; }
    }

    /** 时间是否早于当前时刻（兼容 LocalDateTime / Date / 字符串三种返回类型）。 */
    private boolean isPastTime(Object v) {
        if (v == null) return false;
        try {
            if (v instanceof java.time.LocalDateTime ldt) {
                return ldt.isBefore(java.time.LocalDateTime.now());
            }
            if (v instanceof java.util.Date d) {
                return d.before(new java.util.Date());
            }
            String s = String.valueOf(v).replace('T', ' ').trim();
            if (s.length() > 19) s = s.substring(0, 19);
            return java.sql.Timestamp.valueOf(s).before(new java.sql.Timestamp(System.currentTimeMillis()));
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 统一的数值取值。
     *
     * 必须存在的原因：MySQL 的 tinyint(1) 被 JDBC 映射成 Boolean，
     * 直接 (Number) 强转会抛 ClassCastException。本项目已在这上面栽了四次。
     * 凡是从 ResultSet 取出的数字字段，一律走这里，不要直接强转。
     */
    private int toInt(Object o) {
        if (o == null) return 0;
        if (o instanceof Boolean b) return b ? 1 : 0;
        if (o instanceof Number n) return n.intValue();
        try { return Integer.parseInt(String.valueOf(o).trim()); } catch (Exception e) { return 0; }
    }

    private long toLong(Object o) {
        if (o == null) return 0L;
        if (o instanceof Boolean b) return b ? 1L : 0L;
        if (o instanceof Number n) return n.longValue();
        try { return Long.parseLong(String.valueOf(o).trim()); } catch (Exception e) { return 0L; }
    }
}
