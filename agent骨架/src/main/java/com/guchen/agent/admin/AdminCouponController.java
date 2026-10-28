package com.guchen.agent.admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 优惠券模板的自定义创建与编辑。
 *
 * <h3>两种券型的语义差异（最容易写错的地方）</h3>
 * <ul>
 *   <li><b>full（满减）</b>：value 是**减多少钱**。如「满 300 减 30」→ value=30, min_order_amount=300</li>
 *   <li><b>discount（折扣）</b>：value 是**折扣率**，0.85 表示 85 折。实际抵扣 = 订单额 ×(1-0.85)，
 *       且被 max_discount 封顶。所以折扣券必须校验 value 在 (0,1) 之间 —— 若把 85 当折扣率存进去，
 *       用户会得到一个「付 85 倍价钱」的荒谬结果。</li>
 * </ul>
 *
 * <h3>为什么 stock 与 total_count 要分开</h3>
 * 看既有数据：`total_count=3000, stock=300`。
 * total_count 是「发行总量」（对外展示），stock 是「当前剩余可领」。领取时只减 stock，
 * total_count 保持不变。若不区分，领完就无法判断这张券当初发了多少。
 */
@Slf4j
@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminCouponController {

    private final JdbcTemplate jdbc;
    /**
     * 兑换码生成逻辑复用 AdminOpsController 的实现。
     * 若在这里另写一份，两处规则（码格式、密码位数、必填字段）早晚会漂移，
     * 出现「建券时生成的码」和「事后补生成的码」行为不一致。
     */
    private final AdminOpsController opsController;
    private static final String DB = "db_tear.";

    private static final List<String> VALID_TYPES = List.of("full", "discount");

    /**
     * 新建优惠券模板。
     *
     * 请求体：
     * <pre>
     * {
     *   "name": "双十一满减券",
     *   "type": "full",                    // full=满减 / discount=折扣
     *   "value": 30,                       // 满减=减免金额；折扣=折扣率(0.85)
     *   "minOrderAmount": 300,             // 门槛，0=无门槛
     *   "maxDiscount": 100,                // 折扣券封顶，满减券可留空
     *   "themeId": null,                   // 关联主题，null=通用
     *   "isExclusive": false,              // 是否仅限主题商品
     *   "totalCount": 1000,                // 发行总量
     *   "startTime": "2026-11-01 00:00:00",
     *   "endTime":   "2026-11-11 23:59:59",
     *   "status": 1,
     *   "conditionText": "满300减30"        // 可选，留空自动生成
     * }
     * </pre>
     */
    @PostMapping("/coupon-create")
    public Map<String, Object> createCoupon(@RequestBody Map<String, Object> body) {
        String name = str(body.get("name"));
        String type = str(body.get("type"));
        Double value = dblOrNull(body.get("value"));
        Double minOrder = dblOrNull(body.get("minOrderAmount"));
        Double maxDiscount = dblOrNull(body.get("maxDiscount"));
        Integer totalCount = intOrNull(body.get("totalCount"));
        String startTime = str(body.get("startTime"));
        String endTime = str(body.get("endTime"));
        Integer themeId = intOrNull(body.get("themeId"));
        Boolean isExclusive = Boolean.TRUE.equals(body.get("isExclusive"));
        Integer status = intOrNull(body.get("status"));

        // ---------- 基础校验 ----------
        if (name.isBlank()) return bad("券名称不能为空");
        if (name.length() > 100) return bad("券名称超长（上限 100 字）");
        if (!VALID_TYPES.contains(type)) return bad("类型只能是 full（满减）或 discount（折扣）");
        if (value == null || value <= 0) return bad("面值必须大于 0");
        if (totalCount == null || totalCount <= 0) return bad("发行总量必须大于 0");
        if (totalCount > 100000) return bad("发行总量过大（上限 10 万）");
        if (startTime.isBlank() || endTime.isBlank()) return bad("必须填写有效期起止时间");

        // ---------- 类型相关校验 ----------
        if ("discount".equals(type)) {
            // 折扣率必须 (0,1)。若传 85（想表达 85 折），实际会变成「付 85 倍」，必须拦住。
            if (value >= 1) {
                return bad("折扣率必须在 0 到 1 之间（如 85 折请填 0.85，不是 85）");
            }
            if (value < 0.01) return bad("折扣率过小（下限 0.01，即 1 折）");
            // 折扣券强烈建议设封顶，否则「满 10000 打 85 折」会一次减 1500
            if (maxDiscount == null || maxDiscount <= 0) {
                return bad("折扣券必须设置最高抵扣金额（防止大额订单过度让利）");
            }
        } else {
            // 满减券：减免额必须小于门槛，否则等于无限白送
            if (minOrder != null && minOrder > 0 && value >= minOrder) {
                return bad(String.format("减免金额（%.2f）不能大于等于门槛（%.2f），否则等于无条件白送", value, minOrder));
            }
            maxDiscount = null;   // 满减券不需要封顶
        }

        // 时间合法性
        if (endTime.compareTo(startTime) <= 0) {
            return bad("结束时间必须晚于开始时间");
        }

        // 主题存在性
        String themeName = null;
        if (themeId != null) {
            List<Map<String, Object>> t = jdbc.queryForList(
                    "SELECT name FROM " + DB + "theme WHERE id = ?", themeId);
            if (t.isEmpty()) return bad("主题不存在: " + themeId);
            themeName = String.valueOf(t.get(0).get("name"));
        }
        // 专享券必须绑主题，否则「仅限某主题商品使用」无从判断
        if (isExclusive && themeId == null) {
            return bad("专享券必须关联一个主题");
        }

        // 条件描述：没填就按类型自动生成，避免列表里全是空白
        String conditionText = str(body.get("conditionText"));
        if (conditionText.isBlank()) {
            conditionText = "full".equals(type)
                    ? (minOrder != null && minOrder > 0
                        ? String.format("满%.0f减%.0f", minOrder, value)
                        : String.format("无门槛减%.0f", value))
                    : String.format("%.0f折%s", value * 10,
                        maxDiscount != null ? String.format("，最高减%.0f", maxDiscount) : "");
        }

        // ---------- 入库 ----------
        final Double finalMaxDiscount = maxDiscount;
        final String finalThemeName = themeName;
        final String finalCondition = conditionText;
        final int finalStatus = status == null ? 1 : status;

        KeyHolder kh = new GeneratedKeyHolder();
        jdbc.update(con -> {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO " + DB + "coupon "
                            + "(name, type, value, `condition`, min_order_amount, max_discount, "
                            + " theme_id, theme_name, is_exclusive, stock, total_count, "
                            + " received_count, used_count, start_time, end_time, status, created_at, updated_at) "
                            + "VALUES (?,?,?,?,?,?,?,?,?,?,?,0,0,?,?,?,NOW(),NOW())",
                    Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, name);
            ps.setString(2, type);
            ps.setDouble(3, value);
            ps.setString(4, finalCondition);
            if (minOrder == null) ps.setBigDecimal(5, java.math.BigDecimal.ZERO);
            else ps.setBigDecimal(5, java.math.BigDecimal.valueOf(minOrder));
            if (finalMaxDiscount == null) ps.setNull(6, java.sql.Types.DECIMAL);
            else ps.setBigDecimal(6, java.math.BigDecimal.valueOf(finalMaxDiscount));
            if (themeId == null) ps.setNull(7, java.sql.Types.INTEGER); else ps.setInt(7, themeId);
            if (finalThemeName == null) ps.setNull(8, java.sql.Types.VARCHAR); else ps.setString(8, finalThemeName);
            ps.setInt(9, isExclusive ? 1 : 0);
            // 新建时 stock = totalCount（还没人领）
            ps.setInt(10, totalCount);
            ps.setInt(11, totalCount);
            ps.setString(12, startTime);
            ps.setString(13, endTime);
            ps.setInt(14, finalStatus);
            return ps;
        }, kh);

        long id = kh.getKey() == null ? 0 : kh.getKey().longValue();
        log.info("后台新建优惠券: id={} name={} type={} value={} 总量={}", id, name, type, value, totalCount);

        // ---- 可选：建券时一并生成兑换码 ----
        // 表单里填了「生成兑换码数量」就直接生成，省掉「建完再点一次」的步骤。
        // 生成失败不影响券本身（券已入库，可事后补生成），只把失败信息带回去。
        Integer codeCount = intOrNull(body.get("codeCount"));
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("ok", true);
        out.put("id", id);
        out.put("condition", finalCondition);

        if (codeCount != null && codeCount > 0) {
            try {
                Map<String, Object> gen = opsController.generateCodesFor(id, codeCount);
                out.put("codeCount", gen.get("generated"));
                out.put("codes", gen.get("codes"));
                log.info("建券时生成兑换码: coupon={} 数量={}", id, gen.get("generated"));
            } catch (Exception e) {
                log.warn("建券成功但生成兑换码失败 coupon={}: {}", id, e.getMessage());
                out.put("codeError", "券已创建，但兑换码生成失败：" + e.getMessage());
            }
        }
        return out;
    }

    /**
     * 编辑券模板。
     *
     * 只允许改「还没被领取」的券的面值与规则 —— 已发出的券若改规则，
     * 持券用户体验会突变（今天说满300减30，明天变成满500减10）。
     * 已被领取的券只允许改名称、有效期延长、上下架状态。
     */
    @PostMapping("/coupon-update")
    public Map<String, Object> updateCoupon(@RequestBody Map<String, Object> body) {
        Long id = longOrNull(body.get("id"));
        if (id == null) return bad("缺少券 ID");

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT received_count, used_count, type, value FROM " + DB + "coupon WHERE id = ?", id);
        if (rows.isEmpty()) return bad("优惠券不存在: " + id);

        int received = ((Number) rows.get(0).get("received_count")).intValue();
        int used = ((Number) rows.get(0).get("used_count")).intValue();
        boolean hasIssued = received > 0 || used > 0;

        // 已发放的券限制可改字段
        if (hasIssued) {
            boolean wantsRuleChange = body.get("value") != null
                    || body.get("minOrderAmount") != null
                    || body.get("type") != null
                    || body.get("maxDiscount") != null;
            if (wantsRuleChange) {
                return bad(String.format(
                        "该券已发放（领取 %d / 使用 %d），不能修改面值与规则。"
                        + "如需新规则，请新建一张券并停用这张。", received, used));
            }
        }

        List<String> sets = new ArrayList<>();
        List<Object> args = new ArrayList<>();

        if (body.get("name") != null) {
            String n = str(body.get("name"));
            if (n.isBlank()) return bad("券名称不能为空");
            sets.add("name = ?"); args.add(n);
        }
        if (!hasIssued) {
            if (body.get("type") != null) {
                String t = str(body.get("type"));
                if (!VALID_TYPES.contains(t)) return bad("类型只能是 full 或 discount");
                sets.add("type = ?"); args.add(t);
            }
            if (body.get("value") != null) {
                Double v = dblOrNull(body.get("value"));
                if (v == null || v <= 0) return bad("面值必须大于 0");
                sets.add("value = ?"); args.add(v);
            }
            if (body.get("minOrderAmount") != null) {
                sets.add("min_order_amount = ?"); args.add(dblOrNull(body.get("minOrderAmount")));
            }
            if (body.get("maxDiscount") != null) {
                sets.add("max_discount = ?"); args.add(dblOrNull(body.get("maxDiscount")));
            }
            if (body.get("conditionText") != null) {
                sets.add("`condition` = ?"); args.add(str(body.get("conditionText")));
            }
        }
        if (body.get("startTime") != null) { sets.add("start_time = ?"); args.add(str(body.get("startTime"))); }
        if (body.get("endTime") != null) { sets.add("end_time = ?"); args.add(str(body.get("endTime"))); }
        if (body.get("totalCount") != null) { sets.add("total_count = ?"); args.add(intOrNull(body.get("totalCount"))); }
        if (body.get("status") != null) { sets.add("status = ?"); args.add(intOrNull(body.get("status"))); }

        if (sets.isEmpty()) return bad("没有要修改的字段");
        sets.add("updated_at = NOW()");
        args.add(id);

        jdbc.update("UPDATE " + DB + "coupon SET " + String.join(", ", sets) + " WHERE id = ?", args.toArray());
        log.info("后台编辑优惠券: id={} 字段数={} 已发放={}", id, sets.size() - 1, hasIssued);
        return Map.of("ok", true, "updated", sets.size() - 1, "hasIssued", hasIssued);
    }

    /**
     * 删除券模板。
     *
     * <h3>为什么不能只看 received_count</h3>
     * 旧实现用 {@code coupon.received_count} 当唯一判据，结果是**一张都删不掉**：
     * 这个字段是冗余计数器，会随补发/回滚/历史脚本漂移；而真正决定能不能删的是
     * 三张真实引用表 —— {@code coupon_user}（用户手里的券）、{@code coupon_code}
     * （已发出/未领取的兑换码）、{@code order}（历史订单的优惠回溯）。
     * 其中「未领取」的兑换码只是还没被任何人拿走的库存，删券时一并清理即可，
     * 不该成为删除的阻碍。
     *
     * <h3>过期券为什么可以连用户券一起删（2026-10-24 新增）</h3>
     * 券到期后已经不可能再被使用，用户券只是躺在「已失效」列表里的历史记录。
     * 运营清理过期模板时，若还要求「先联系用户退券」就不现实了。所以对
     * {@code end_time < NOW()} 的券，允许在显式 force 下连带删除 coupon_user 与
     * coupon_code。但**订单引用仍然拦截**：订单是财务凭证，删券会让
     * {@code order.coupon_id} 悬空，宁可让人改「停用」。
     *
     * <h3>删除策略矩阵</h3>
     * <table border="1">
     *   <caption>判据优先级从上到下</caption>
     *   <tr><th>券的状态</th><th>结果</th></tr>
     *   <tr><td>order.coupon_id 有引用（任何情况）</td><td>禁止，返回 COUPON_HAS_ORDERS</td></tr>
     *   <tr><td>未过期 + coupon_user 有记录</td><td>禁止，返回 COUPON_IN_USE</td></tr>
     *   <tr><td>未过期 + 已发出的兑换码</td><td>禁止，返回 COUPON_HAS_ISSUED_CODES</td></tr>
     *   <tr><td>未过期 + 仅有未领取兑换码</td><td>需 force=true，先清码再删券</td></tr>
     *   <tr><td>已过期 + 有用户券/兑换码</td><td>需 force=true，连带清理后再删券</td></tr>
     *   <tr><td>无引用（received_count 漂移为 &gt;0）</td><td>允许，只打 WARN 记录漂移</td></tr>
     * </table>
     *
     * 请求体：{@code {"id":27, "force":true}}
     *
     * @return 成功 {@code {ok:true, deleted:1, purgedCodes:N, purgedUserCoupons:M, id:id}}；
     *         被拒时 {@code {ok:false, code:"...", error:"...", refs:{...}}}
     */
    @PostMapping("/coupon-delete")
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> deleteCoupon(@RequestBody Map<String, Object> body) {
        Long id = longOrNull(body.get("id"));
        if (id == null) return fail("BAD_REQUEST", "缺少券 ID");
        boolean force = truthy(body.get("force"));

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT name FROM " + DB + "coupon WHERE id = ?", id);
        if (rows.isEmpty()) {
            return fail("NOT_FOUND", "优惠券不存在或已被删除: " + id);
        }
        String name = String.valueOf(rows.get(0).get("name"));

        // 判据一律取真实引用表的 COUNT(*)；计数器只用于日志与返回体
        Map<String, Object> refs = collectCouponRefs(id);
        int userCoupons = num(refs.get("userCoupons"));
        int codesIssued = num(refs.get("codesIssued"));
        int orders = num(refs.get("orders"));
        int codesUnclaimed = num(refs.get("codesUnclaimed"));
        int receivedCount = num(refs.get("receivedCount"));
        boolean expired = Boolean.TRUE.equals(refs.get("expired"));

        // ---------- 订单引用：任何情况都拦（财务凭证不能断链） ----------
        if (orders > 0) {
            return blockDelete(id, "COUPON_HAS_ORDERS",
                    "无法删除：该券关联 " + orders + " 笔历史订单。"
                            + "订单是财务凭证，删券会让优惠记录悬空，请改为「停用」。", refs);
        }

        // ---------- 未过期：沿用严格规则 ----------
        if (!expired && (userCoupons > 0 || codesIssued > 0)) {
            List<String> reasons = new ArrayList<>();
            if (userCoupons > 0) reasons.add("已被领取 " + userCoupons + " 次");
            if (codesIssued > 0) reasons.add("已发放 " + codesIssued + " 个兑换码");
            String code = userCoupons > 0 ? "COUPON_IN_USE" : "COUPON_HAS_ISSUED_CODES";
            return blockDelete(id, code,
                    "无法删除：该券" + String.join("、", reasons)
                            + "。删除会让用户券与历史订单悬空，请改为「停用」。", refs);
        }

        // ---------- 过期券：允许连带清理，但要显式确认 ----------
        // 这里把「用户券」和「兑换码」都算作需要确认的清理项：
        // 过期券的 coupon_user 是历史记录，兑换码也已不可能再兑换，一起清掉才是干净的删除。
        int totalCodes = num(refs.get("codes"));
        if (expired && !force && (userCoupons > 0 || totalCodes > 0)) {
            Map<String, Object> out = new LinkedHashMap<>();
            out.put("ok", false);
            out.put("code", "COUPON_EXPIRED_NEEDS_CONFIRM");
            out.put("error", String.format(
                    "该券已于 %s 过期。继续删除将同时清理 %d 条用户券记录、%d 个兑换码，且不可恢复。",
                    String.valueOf(refs.get("endTime")), userCoupons, totalCodes));
            out.put("refs", refs);
            log.info("删除过期券需要二次确认: id={} refs={}", id, refs);
            return out;
        }

        // ---------- 未过期且只有未领取码：也需要 force ----------
        if (!expired && codesUnclaimed > 0 && !force) {
            Map<String, Object> out = new LinkedHashMap<>();
            out.put("ok", false);
            out.put("code", "COUPON_HAS_UNCLAIMED_CODES");
            out.put("error", "该券有 " + codesUnclaimed + " 个未领取兑换码，确认后可一并清理");
            out.put("refs", refs);
            log.info("删除优惠券需要二次确认（未领取码 {} 个）: id={}", codesUnclaimed, id);
            return out;
        }

        // ---------- 允许删除 ----------
        // 删除顺序：先删用户券（它引用 coupon_code），再删兑换码，最后删券模板。
        // 三步在同一事务里，中途失败整体回滚，不会留下半张券。
        int purgedUserCoupons = 0;
        int purgedCodes = 0;
        if (expired) {
            purgedUserCoupons = jdbc.update(
                    "DELETE FROM " + DB + "coupon_user WHERE coupon_id = ?", id);
            purgedCodes = jdbc.update(
                    "DELETE FROM " + DB + "coupon_code WHERE coupon_id = ?", id);
        } else if (codesUnclaimed > 0) {
            purgedCodes = jdbc.update("DELETE FROM " + DB + "coupon_code "
                    + "WHERE coupon_id = ? AND status = 'unclaimed' AND user_id IS NULL", id);
        }
        int deleted = jdbc.update("DELETE FROM " + DB + "coupon WHERE id = ?", id);

        if (receivedCount > 0 && !expired) {
            // 计数器说被领过，但三张引用表都查不到 —— 脏数据。只记日志，不拦功能。
            log.warn("删除优惠券时检测到 received_count 漂移: id={} received_count={} 真实引用均为 0，已按引用表放行",
                    id, receivedCount);
        }
        log.info("后台删除优惠券: id={} name={} 过期={} 清理用户券={} 清理兑换码={} force={}",
                id, name, expired, purgedUserCoupons, purgedCodes, force);

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("ok", true);
        out.put("deleted", deleted);
        out.put("purgedCodes", purgedCodes);
        out.put("purgedUserCoupons", purgedUserCoupons);
        out.put("expired", expired);
        out.put("id", id);
        return out;
    }

    /** 上下架（停用/启用）。 */
    @PostMapping("/coupon-toggle")
    public Map<String, Object> toggleCoupon(@RequestBody Map<String, Object> body) {
        Long id = longOrNull(body.get("id"));
        Integer status = intOrNull(body.get("status"));
        if (id == null || status == null) return bad("缺少券 ID 或状态");
        if (status != 0 && status != 1) return bad("状态只能是 0（停用）或 1（启用）");

        int n = jdbc.update("UPDATE " + DB + "coupon SET status = ?, updated_at = NOW() WHERE id = ?", status, id);
        if (n == 0) return bad("优惠券不存在: " + id);
        log.info("后台{}优惠券: id={}", status == 1 ? "启用" : "停用", id);
        return Map.of("ok", true, "status", status);
    }

    /** 单张券的完整信息，供编辑表单回填。 */
    @GetMapping("/coupon-detail")
    public Map<String, Object> couponDetail(@RequestParam long id) {
        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT * FROM " + DB + "coupon WHERE id = ?", id);
        if (rows.isEmpty()) return Map.of("error", "优惠券不存在: " + id);

        // MySQL tinyint(1) 会被映射成 Boolean，前端 Number(status) 会得到 NaN。
        // 统一转 0/1，与商品列表的处理保持一致。
        Map<String, Object> cp = rows.get(0);
        cp.put("status", int01(cp.get("status")));
        cp.put("is_exclusive", int01(cp.get("is_exclusive")));

        // 真实引用计数，供前端删除前做前置判断（弹窗里没有列表那份统计）
        Map<String, Object> refs = collectCouponRefs(id);
        cp.put("code_total", refs.get("codes"));
        cp.put("code_unclaimed", refs.get("codesUnclaimed"));
        cp.put("code_issued", refs.get("codesIssued"));
        cp.put("user_count", refs.get("userCoupons"));
        cp.put("order_count", refs.get("orders"));
        cp.put("expired", refs.get("expired"));

        List<Map<String, Object>> themes = jdbc.queryForList(
                "SELECT id, name FROM " + DB + "theme ORDER BY id");
        return Map.of("coupon", cp, "themes", themes);
    }

    // ==================== 工具 ====================

    /**
     * 统计某张券的**真实引用**，作为能否删除的唯一判据。
     *
     * <p>刻意不把 {@code coupon.received_count} 当判据：它是冗余计数器，
     * 与三张引用表的口径会漂移（补发、回滚、历史脚本都会让它偏离）。
     * 这里把它一并返回，仅用于日志排查与提示文案。</p>
     *
     * <p>{@code expired} 以 {@code end_time < NOW()} 判定，不看 {@code status}：
     * status 是「上架/下架」的人工开关，与「是否过期」是两件事。一张已过期的券
     * 仍可能 status=1（运营没来得及下架），不能因此把它当成有效券。</p>
     *
     * @param id 券 ID
     * @return 字段：userCoupons / codes / codesUnclaimed / codesIssued / orders /
     *         receivedCount / usedCount / expired / endTime
     */
    private Map<String, Object> collectCouponRefs(long id) {
        int userCoupons = countOf(
                "SELECT COUNT(*) FROM " + DB + "coupon_user WHERE coupon_id = ?", id);
        int codes = countOf(
                "SELECT COUNT(*) FROM " + DB + "coupon_code WHERE coupon_id = ?", id);
        // 未领取 = 还没被任何人拿走：status 仍是 unclaimed 且没有绑定用户
        int codesUnclaimed = countOf(
                "SELECT COUNT(*) FROM " + DB + "coupon_code "
                        + "WHERE coupon_id = ? AND status = 'unclaimed' AND user_id IS NULL", id);
        // order 是 MySQL 保留字，必须反引号
        int orders = countOf(
                "SELECT COUNT(*) FROM " + DB + "`order` WHERE coupon_id = ?", id);

        List<Map<String, Object>> cp = jdbc.queryForList(
                "SELECT received_count, used_count, end_time FROM " + DB + "coupon WHERE id = ?", id);
        int receivedCount = cp.isEmpty() ? 0 : num(cp.get(0).get("received_count"));
        int usedCount = cp.isEmpty() ? 0 : num(cp.get(0).get("used_count"));

        boolean expired = false;
        String endTime = "";
        if (!cp.isEmpty() && cp.get(0).get("end_time") != null) {
            Object et = cp.get(0).get("end_time");
            // MySQL Connector/J 8 把 DATETIME 映射成 LocalDateTime，不是 java.util.Date；
            // 早期按 Date 判断的写法会永远落空（过期券被判成未过期）。统一走 isPast。
            endTime = String.valueOf(et).replace('T', ' ');
            expired = isPast(et);
        }

        Map<String, Object> refs = new LinkedHashMap<>();
        refs.put("userCoupons", userCoupons);
        refs.put("codes", codes);
        refs.put("codesUnclaimed", codesUnclaimed);
        // 已发出 = 总数 - 未领取。脏数据（unclaimed 却绑了 user_id）会被算进已发出，
        // 方向偏保守：宁可拦住让人改停用，也不误删别人手里的券。
        refs.put("codesIssued", Math.max(0, codes - codesUnclaimed));
        refs.put("orders", orders);
        refs.put("receivedCount", receivedCount);
        refs.put("usedCount", usedCount);
        refs.put("expired", expired);
        // 截到日期即可，提示文案里不需要时分秒
        refs.put("endTime", endTime.length() >= 10 ? endTime.substring(0, 10) : endTime);
        return refs;
    }

    /** 统一的「拒绝删除」响应：带机器可读 code 与引用明细。 */
    private Map<String, Object> blockDelete(long id, String code, String msg, Map<String, Object> refs) {
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("ok", false);
        out.put("code", code);
        out.put("error", msg);
        out.put("refs", refs);
        log.info("拒绝删除优惠券: id={} 原因={} refs={}", id, code, refs);
        return out;
    }

    /**
     * 时间是否早于当前时刻。
     *
     * <p>必须兼容三种返回类型：MySQL Connector/J 8 对 DATETIME 返 {@code LocalDateTime}，
     * 老驱动返 {@code Timestamp}，个别视图/表达式返字符串。只判 {@code java.util.Date}
     * 会让 MySQL 8 上的「过期」永远为 false —— 这个坑在本项目已经踩过一次。</p>
     */
    private boolean isPast(Object v) {
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
            log.debug("解析时间失败，按未过期处理: {}", v);
            return false;
        }
    }

    private int countOf(String sql, Object arg) {
        Integer n = jdbc.queryForObject(sql, Integer.class, arg);
        return n == null ? 0 : n;
    }

    private int num(Object o) {
        if (o instanceof Number n) return n.intValue();
        if (o == null) return 0;
        try { return Integer.parseInt(String.valueOf(o).trim()); } catch (Exception e) { return 0; }
    }

    /** 前端可能传 true / "true" / 1，三种都认。 */
    private boolean truthy(Object o) {
        if (o instanceof Boolean b) return b;
        if (o instanceof Number n) return n.intValue() != 0;
        return "true".equalsIgnoreCase(str(o)) || "1".equals(str(o));
    }

    /** 带机器可读 code 的失败体，供前端区分「被引用」与「参数错」。 */
    private Map<String, Object> fail(String code, String msg) {
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("ok", false);
        out.put("code", code);
        out.put("error", msg);
        return out;
    }

    private int int01(Object o) {
        if (o instanceof Boolean b) return b ? 1 : 0;
        if (o instanceof Number n) return n.intValue();
        return 0;
    }

    private Map<String, Object> bad(String msg) { return Map.of("ok", false, "error", msg); }
    private String str(Object o) { return o == null ? "" : String.valueOf(o).trim(); }

    private Integer intOrNull(Object o) {
        if (o == null) return null;
        if (o instanceof Number n) return n.intValue();
        try { return Integer.parseInt(String.valueOf(o).trim()); } catch (Exception e) { return null; }
    }

    private Long longOrNull(Object o) {
        if (o == null) return null;
        if (o instanceof Number n) return n.longValue();
        try { return Long.parseLong(String.valueOf(o).trim()); } catch (Exception e) { return null; }
    }

    private Double dblOrNull(Object o) {
        if (o == null) return null;
        if (o instanceof Number n) return n.doubleValue();
        try { return Double.parseDouble(String.valueOf(o).trim()); } catch (Exception e) { return null; }
    }
}
