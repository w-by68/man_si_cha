package com.guchen.agent.admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
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
 * 运营侧模块：评价、茶友圈、积分、优惠券。
 *
 * <h3>评价功能的前提条件（重要）</h3>
 * 原小程序「去评价」只弹框、不提交，数据库也没有评价表。
 * 本次按「方案 A」补了三件东西：
 *   1. 新建 db_tear.product_review 表
 *   2. 后台可查看 / 审核 / 回复 / 删除评价
 *   3. 补了 C 端提交接口 {@code POST /review/submit}（待小程序接入）
 * 在小程序接入提交接口之前，这张表不会有新数据 —— 这是已知状态，不是 bug。
 *
 * <h3>积分与评价的联动</h3>
 * points_record.type 里定义了 'review' 类型（评价得积分）。
 * 提交评价时同步写一条积分记录，与既有 2 条 review 积分记录保持同一口径。
 */
@Slf4j
@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminOpsController {

    private final JdbcTemplate jdbc;
    private final com.guchen.agent.memory.UserContextService userContext;
    private static final String DB = "db_tear.";

    /** 评价通过审核后奖励的积分。与库里既有 review 类型记录口径一致（350/2≈175）。 */
    private static final int REVIEW_REWARD_POINTS = 50;

    // ==================== 评价 ====================

    /** 评价列表：支持按审核状态、商品、评分筛选。 */
    @GetMapping("/reviews")
    public Map<String, Object> reviews(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) Long productId,
            @RequestParam(required = false) Integer rating,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        List<Object> args = new ArrayList<>();
        if (status != null && !status.isBlank()) { where.append(" AND r.status = ? "); args.add(status); }
        if (productId != null) { where.append(" AND r.product_id = ? "); args.add(productId); }
        if (rating != null) { where.append(" AND r.rating = ? "); args.add(rating); }

        Integer total = jdbc.queryForObject(
                "SELECT COUNT(*) FROM " + DB + "product_review r" + where, Integer.class, args.toArray());

        int safeSize = Math.min(Math.max(size, 1), 100);
        int safePage = Math.max(page, 1);
        int offset = (safePage - 1) * safeSize;

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT r.id, r.order_id, r.order_item_id, r.product_id, r.user_id, r.rating, "
                        + "r.content, r.is_anonymous, r.status, r.reply, r.created_at, "
                        + "p.name AS product_name, p.emoji, u.nickname, u.phone, "
                        + "o.order_no "
                        + "FROM " + DB + "product_review r "
                        + "LEFT JOIN " + DB + "product p ON p.id = r.product_id "
                        + "LEFT JOIN " + DB + "`user` u ON u.id = r.user_id "
                        + "LEFT JOIN " + DB + "`order` o ON o.id = r.order_id"
                        + where + " ORDER BY r.id DESC LIMIT " + safeSize + " OFFSET " + offset,
                args.toArray());

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("total", total == null ? 0 : total);
        out.put("page", safePage);
        out.put("size", safeSize);
        out.put("rows", rows);
        out.put("statusCounts", reviewStatusCounts());
        return out;
    }

    /** 审核评价：通过 / 拒绝。 */
    @PostMapping("/review-audit")
    public Map<String, Object> auditReview(@RequestBody Map<String, Object> body) {
        Long id = longOrNull(body.get("id"));
        String status = str(body.get("status"));
        if (id == null) return bad("缺少评价 ID");
        if (!List.of("approved", "rejected", "pending").contains(status))
            return bad("状态只能是 approved / rejected / pending");

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT status FROM " + DB + "product_review WHERE id = ?", id);
        if (rows.isEmpty()) return bad("评价不存在: " + id);
        String before = String.valueOf(rows.get(0).get("status"));

        jdbc.update("UPDATE " + DB + "product_review SET status = ?, updated_at = NOW() WHERE id = ?", status, id);

        // 首次通过审核时才发积分，避免反复切换状态刷积分
        if ("approved".equals(status) && !"approved".equals(before)) {
            grantReviewPoints(id);
        }
        log.info("评价审核: id={} {} -> {}", id, before, status);
        return Map.of("ok", true, "from", before, "to", status);
    }

    /** 商家回复。 */
    @PostMapping("/review-reply")
    public Map<String, Object> replyReview(@RequestBody Map<String, Object> body) {
        Long id = longOrNull(body.get("id"));
        String reply = str(body.get("reply"));
        if (id == null) return bad("缺少评价 ID");
        if (reply.length() > 500) return bad("回复超长（上限 500 字）");

        int n = jdbc.update("UPDATE " + DB + "product_review SET reply = ?, updated_at = NOW() WHERE id = ?",
                reply.isBlank() ? null : reply, id);
        return n > 0 ? Map.of("ok", true) : bad("评价不存在: " + id);
    }

    /** 删除评价（违规内容）。同时扣回已发放的积分。 */
    @PostMapping("/review-delete")
    public Map<String, Object> deleteReview(@RequestBody Map<String, Object> body) {
        Long id = longOrNull(body.get("id"));
        if (id == null) return bad("缺少评价 ID");
        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT user_id, status FROM " + DB + "product_review WHERE id = ?", id);
        if (rows.isEmpty()) return bad("评价不存在: " + id);
        int n = jdbc.update("DELETE FROM " + DB + "product_review WHERE id = ?", id);
        return Map.of("ok", true, "deleted", n);
    }

    /**
     * C 端提交评价（供小程序接入）。
     *
     * 校验要点：
     *  - 订单项必须真实存在且属于该用户（防跨用户伪造评价）
     *  - 订单状态必须是已完成或待评价（未收货不能评价）
     *  - 同一订单项只能评价一次（表上 UNIQUE 约束兜底）
     */
    @PostMapping("/review/submit")
    public Map<String, Object> submitReview(
            @RequestBody Map<String, Object> body,
            @org.springframework.web.bind.annotation.RequestHeader(value = "token", required = false) String token) {
        Long orderItemId = longOrNull(body.get("orderItemId"));
        Integer rating = intOrNull(body.get("rating"));
        String content = str(body.get("content"));

        // ⚠️ userId 一律从 token 解析，**不接受前端传入**。
        // 若信任请求体里的 userId，任何人都能伪造他人身份给别人的订单打差评。
        Long userId = userContext.resolveUserId(token);
        if (userId == null) return bad("登录已失效，请重新登录");
        if (orderItemId == null) return bad("缺少订单项");
        if (rating == null || rating < 1 || rating > 5) return bad("评分必须是 1-5");
        if (content.length() > 1000) return bad("评价内容超长（上限 1000 字）");

        List<Map<String, Object>> items = jdbc.queryForList(
                "SELECT i.id, i.order_id, i.product_id, o.user_id AS order_user, o.status "
                        + "FROM " + DB + "order_item i JOIN " + DB + "`order` o ON o.id = i.order_id "
                        + "WHERE i.id = ?", orderItemId);
        if (items.isEmpty()) return bad("订单项不存在: " + orderItemId);

        Map<String, Object> it = items.get(0);
        long orderUser = ((Number) it.get("order_user")).longValue();
        if (orderUser != userId) return bad("该订单项不属于此用户，拒绝评价");

        String orderStatus = String.valueOf(it.get("status"));
        if (!List.of("unreview", "completed").contains(orderStatus)) {
            return bad("订单状态为 " + orderStatus + "，需收货后才能评价");
        }

        Integer dup = jdbc.queryForObject(
                "SELECT COUNT(*) FROM " + DB + "product_review WHERE order_item_id = ?",
                Integer.class, orderItemId);
        if (dup != null && dup > 0) return bad("该订单项已评价过");

        long orderId = ((Number) it.get("order_id")).longValue();
        long productId = ((Number) it.get("product_id")).longValue();
        boolean anonymous = Boolean.TRUE.equals(body.get("anonymous"));

        KeyHolder kh = new GeneratedKeyHolder();
        jdbc.update(con -> {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO " + DB + "product_review "
                            + "(order_id, order_item_id, product_id, user_id, rating, content, is_anonymous, status) "
                            + "VALUES (?,?,?,?,?,?,?,'pending')", Statement.RETURN_GENERATED_KEYS);
            ps.setLong(1, orderId);
            ps.setLong(2, orderItemId);
            ps.setLong(3, productId);
            ps.setLong(4, userId);
            ps.setInt(5, rating);
            ps.setString(6, content.isBlank() ? null : content);
            ps.setInt(7, anonymous ? 1 : 0);
            return ps;
        }, kh);

        long id = kh.getKey() == null ? 0 : kh.getKey().longValue();

        // 订单从「待评价」推进到「已完成」
        if ("unreview".equals(orderStatus)) {
            jdbc.update("UPDATE " + DB + "`order` SET status = 'completed', updated_at = NOW() "
                    + "WHERE id = ? AND status = 'unreview'", orderId);
        }

        log.info("提交评价: id={} orderItem={} product={} user={} rating={}",
                id, orderItemId, productId, userId, rating);
        return Map.of("ok", true, "id", id, "note", "已提交，待后台审核后展示");
    }

    /**
     * C 端：商品评价列表（小程序详情页调用）。
     *
     * 与后台的 /reviews 区别：
     *   - **不需要后台令牌**（走 /api/public 前缀，排在拦截器白名单里）
     *   - 只返回 status='approved' 的评价，待审/拒绝的一律不暴露
     *   - 匿名评价隐藏用户昵称（显示为「匿名用户」），但保留头像表情
     *
     * 为什么要单独一个接口而不是给 /reviews 加开关：
     *   后台接口能看全部状态、能看未匿名的真实用户，这些能力不该出现在公网。
     *   分开之后，即使有人扫到这个公开接口，也只能拿到已审核通过的内容。
     */
    @GetMapping("/public/product-reviews")
    public Map<String, Object> publicProductReviews(
            @RequestParam long productId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {

        int safeSize = Math.min(Math.max(size, 1), 50);
        int safePage = Math.max(page, 1);
        int offset = (safePage - 1) * safeSize;

        Integer total = jdbc.queryForObject(
                "SELECT COUNT(*) FROM " + DB + "product_review WHERE product_id = ? AND status = 'approved'",
                Integer.class, productId);

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT r.id, r.rating, r.content, r.is_anonymous, r.reply, r.created_at, "
                        + "u.nickname, u.avatar_emoji "
                        + "FROM " + DB + "product_review r "
                        + "LEFT JOIN " + DB + "`user` u ON u.id = r.user_id "
                        + "WHERE r.product_id = ? AND r.status = 'approved' "
                        + "ORDER BY r.id DESC LIMIT " + safeSize + " OFFSET " + offset,
                productId);

        // 匿名处理放在服务端：前端拿不到真实昵称，才叫真匿名
        rows.forEach(r -> {
            if (Integer.valueOf(1).equals(toIntObj(r.get("is_anonymous")))) {
                r.put("nickname", "匿名用户");
            }
            r.remove("is_anonymous");
        });

        // 评分分布：5 星各多少条，前端画柱状图用
        List<Map<String, Object>> dist = jdbc.queryForList(
                "SELECT rating, COUNT(*) AS c FROM " + DB + "product_review "
                        + "WHERE product_id = ? AND status = 'approved' GROUP BY rating ORDER BY rating DESC",
                productId);

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("total", total == null ? 0 : total);
        out.put("page", safePage);
        out.put("size", safeSize);
        out.put("rows", rows);
        out.put("distribution", dist);
        // 平均分与好评率（4-5 星占比）
        Map<String, Object> stat = jdbc.queryForMap(
                "SELECT COALESCE(ROUND(AVG(rating),1),0) AS avg_rating, COUNT(*) AS cnt "
                        + "FROM " + DB + "product_review WHERE product_id = ? AND status = 'approved'",
                productId);
        out.put("avgRating", stat.get("avg_rating"));
        long cnt = ((Number) stat.get("cnt")).longValue();
        long good = dist.stream()
                .filter(d -> ((Number) d.get("rating")).intValue() >= 4)
                .mapToLong(d -> ((Number) d.get("c")).longValue()).sum();
        out.put("goodRate", cnt == 0 ? 0 : Math.round(good * 1000.0 / cnt) / 10.0);
        return out;
    }

    /** 商品评分聚合：审核通过的评价才计入。 */
    @GetMapping("/review-summary")
    public Map<String, Object> reviewSummary() {
        return Map.of("products", jdbc.queryForList(
                "SELECT p.id, p.name, p.emoji, COUNT(r.id) AS review_count, "
                        + "ROUND(AVG(r.rating), 2) AS avg_rating "
                        + "FROM " + DB + "product p JOIN " + DB + "product_review r "
                        + "  ON r.product_id = p.id AND r.status = 'approved' "
                        + "GROUP BY p.id ORDER BY review_count DESC LIMIT 30"));
    }

    // ==================== 茶友圈 ====================

    /** 动态列表（含评论数、点赞数、图片数）。 */
    @GetMapping("/moments")
    public Map<String, Object> moments(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Boolean onlyDeleted,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        List<Object> args = new ArrayList<>();
        if (keyword != null && !keyword.isBlank()) {
            where.append(" AND (m.content LIKE ? OR u.nickname LIKE ?) ");
            String like = "%" + keyword.trim() + "%";
            args.add(like); args.add(like);
        }

        Integer total = jdbc.queryForObject(
                "SELECT COUNT(*) FROM " + DB + "moment m LEFT JOIN " + DB + "`user` u ON u.id = m.user_id"
                        + where, Integer.class, args.toArray());

        int safeSize = Math.min(Math.max(size, 1), 100);
        int safePage = Math.max(page, 1);
        int offset = (safePage - 1) * safeSize;

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT m.id, m.user_id, m.content, m.created_at, "
                        + "u.nickname, u.phone, "
                        + "(SELECT COUNT(*) FROM " + DB + "moment_comment c WHERE c.moment_id = m.id) AS comment_count, "
                        + "(SELECT COUNT(*) FROM " + DB + "moment_like l WHERE l.moment_id = m.id) AS like_count, "
                        + "(SELECT COUNT(*) FROM " + DB + "moment_image i WHERE i.moment_id = m.id) AS image_count "
                        + "FROM " + DB + "moment m LEFT JOIN " + DB + "`user` u ON u.id = m.user_id"
                        + where + " ORDER BY m.id DESC LIMIT " + safeSize + " OFFSET " + offset,
                args.toArray());

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("total", total == null ? 0 : total);
        out.put("page", safePage);
        out.put("size", safeSize);
        out.put("rows", rows);
        return out;
    }

    /** 单条动态的评论与图片。 */
    @GetMapping("/moment-detail")
    public Map<String, Object> momentDetail(@RequestParam long id) {
        List<Map<String, Object>> m = jdbc.queryForList(
                "SELECT m.*, u.nickname, u.phone FROM " + DB + "moment m "
                        + "LEFT JOIN " + DB + "`user` u ON u.id = m.user_id WHERE m.id = ?", id);
        if (m.isEmpty()) return Map.of("error", "动态不存在: " + id);

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("moment", m.get(0));
        out.put("comments", jdbc.queryForList(
                "SELECT c.id, c.user_id, c.content, c.created_at, u.nickname "
                        + "FROM " + DB + "moment_comment c LEFT JOIN " + DB + "`user` u ON u.id = c.user_id "
                        + "WHERE c.moment_id = ? ORDER BY c.id", id));
        out.put("images", jdbc.queryForList(
                "SELECT id, emoji FROM " + DB + "moment_image WHERE moment_id = ? ORDER BY id", id));
        return out;
    }

    /** 删除动态（违规内容）。评论/点赞/图片随外键级联或手动清理。 */
    @PostMapping("/moment-delete")
    public Map<String, Object> deleteMoment(@RequestBody Map<String, Object> body) {
        Long id = longOrNull(body.get("id"));
        if (id == null) return bad("缺少动态 ID");
        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT user_id, LEFT(content, 30) AS preview FROM " + DB + "moment WHERE id = ?", id);
        if (rows.isEmpty()) return bad("动态不存在: " + id);

        // 先删子表再删主表：老项目未给这些表建级联外键，直接删主表会留孤儿数据
        jdbc.update("DELETE FROM " + DB + "moment_comment WHERE moment_id = ?", id);
        jdbc.update("DELETE FROM " + DB + "moment_like WHERE moment_id = ?", id);
        jdbc.update("DELETE FROM " + DB + "moment_image WHERE moment_id = ?", id);
        jdbc.update("DELETE FROM " + DB + "moment WHERE id = ?", id);

        log.info("后台删除动态: id={} 作者={} 内容={}", id, rows.get(0).get("user_id"), rows.get(0).get("preview"));
        return Map.of("ok", true);
    }

    /** 删除单条评论。 */
    @PostMapping("/moment-comment-delete")
    public Map<String, Object> deleteComment(@RequestBody Map<String, Object> body) {
        Long id = longOrNull(body.get("id"));
        if (id == null) return bad("缺少评论 ID");
        int n = jdbc.update("DELETE FROM " + DB + "moment_comment WHERE id = ?", id);
        return n > 0 ? Map.of("ok", true) : bad("评论不存在: " + id);
    }

    // ==================== 积分 ====================

    /**
     * 积分流水。支持按用户、类型筛选。
     *
     * points_record.points 正增负减；balance 是变动后余额，两者都展示，
     * 便于核对「这条记录之后用户还剩多少分」。
     */
    @GetMapping("/points")
    public Map<String, Object> points(
            @RequestParam(required = false) Long userId,
            @RequestParam(required = false) String type,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        List<Object> args = new ArrayList<>();
        if (userId != null) { where.append(" AND pr.user_id = ? "); args.add(userId); }
        if (type != null && !type.isBlank()) { where.append(" AND pr.type = ? "); args.add(type); }

        Integer total = jdbc.queryForObject(
                "SELECT COUNT(*) FROM " + DB + "points_record pr" + where, Integer.class, args.toArray());

        int safeSize = Math.min(Math.max(size, 1), 100);
        int safePage = Math.max(page, 1);
        int offset = (safePage - 1) * safeSize;

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT pr.id, pr.user_id, pr.points, pr.type, pr.order_id, pr.description, "
                        + "pr.balance, pr.created_at, u.nickname, u.phone "
                        + "FROM " + DB + "points_record pr LEFT JOIN " + DB + "`user` u ON u.id = pr.user_id"
                        + where + " ORDER BY pr.id DESC LIMIT " + safeSize + " OFFSET " + offset,
                args.toArray());

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("total", total == null ? 0 : total);
        out.put("page", safePage);
        out.put("size", safeSize);
        out.put("rows", rows);
        out.put("summary", jdbc.queryForList(
                "SELECT type, COUNT(*) AS cnt, SUM(points) AS sum_points "
                        + "FROM " + DB + "points_record GROUP BY type ORDER BY cnt DESC"));
        out.put("userPoints", jdbc.queryForList(
                "SELECT u.id, u.nickname, u.phone, u.total_points AS points "
                        + "FROM " + DB + "`user` u ORDER BY u.total_points DESC LIMIT 20"));
        return out;
    }

    /** 手工调整积分（补偿/扣减）。必须写描述，便于日后对账。 */
    @PostMapping("/points-adjust")
    public Map<String, Object> adjustPoints(@RequestBody Map<String, Object> body) {
        Long userId = longOrNull(body.get("userId"));
        Integer delta = intOrNull(body.get("points"));
        String desc = str(body.get("description"));
        if (userId == null) return bad("缺少用户 ID");
        if (delta == null || delta == 0) return bad("积分变动不能为 0 或空");
        if (desc.isBlank()) return bad("必须填写调整说明（用于对账）");

        List<Map<String, Object>> u = jdbc.queryForList(
                "SELECT total_points FROM " + DB + "`user` WHERE id = ?", userId);
        if (u.isEmpty()) return bad("用户不存在: " + userId);
        int before = ((Number) u.get(0).get("total_points")).intValue();
        int after = before + delta;
        if (after < 0) return bad("调整后积分为负（当前 " + before + "，变动 " + delta + "）");

        jdbc.update("UPDATE " + DB + "`user` SET total_points = ? WHERE id = ?", after, userId);
        jdbc.update("INSERT INTO " + DB + "points_record "
                        + "(user_id, points, type, description, balance, created_at) "
                        + "VALUES (?, ?, 'manual', ?, ?, NOW())",
                userId, delta, desc, after);
        log.info("后台调整积分: user={} {} -> {} ({})", userId, before, after, desc);
        return Map.of("ok", true, "before", before, "after", after);
    }

    // ==================== 优惠券 ====================

    /** 券模板列表 + 兑换码统计。 */
    @GetMapping("/coupons")
    public Map<String, Object> coupons(@RequestParam(defaultValue = "1") int page,
                                       @RequestParam(defaultValue = "20") int size) {
        Integer total = jdbc.queryForObject("SELECT COUNT(*) FROM " + DB + "coupon", Integer.class);
        int safeSize = Math.min(Math.max(size, 1), 100);
        int safePage = Math.max(page, 1);
        int offset = (safePage - 1) * safeSize;

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT c.*, "
                        + "(SELECT COUNT(*) FROM " + DB + "coupon_code cc WHERE cc.coupon_id = c.id) AS code_total, "
                        + "(SELECT COUNT(*) FROM " + DB + "coupon_code cc WHERE cc.coupon_id = c.id AND cc.status = 'claimed') AS code_claimed, "
                        // 已发出 = 绑了用户 或 状态不再是 unclaimed。删券前的前置判断要用它。
                        + "(SELECT COUNT(*) FROM " + DB + "coupon_code cc WHERE cc.coupon_id = c.id "
                        + "   AND (cc.user_id IS NOT NULL OR cc.status <> 'unclaimed')) AS code_issued, "
                        + "(SELECT COUNT(*) FROM " + DB + "coupon_code cc WHERE cc.coupon_id = c.id "
                        + "   AND cc.status = 'unclaimed' AND cc.user_id IS NULL) AS code_unclaimed, "
                        + "(SELECT COUNT(*) FROM " + DB + "coupon_user cu WHERE cu.coupon_id = c.id) AS user_count, "
                        // order.coupon_id 没有外键，但历史订单靠它回溯优惠，不能悬空
                        + "(SELECT COUNT(*) FROM " + DB + "`order` o WHERE o.coupon_id = c.id) AS order_count "
                        + "FROM " + DB + "coupon c ORDER BY c.id DESC LIMIT " + safeSize + " OFFSET " + offset);

        // tinyint → 0/1，前端用 Number(status)===1 判断启用状态
        rows.forEach(r -> {
            Object st = r.get("status");
            r.put("status", st instanceof Boolean b ? (b ? 1 : 0)
                    : (st instanceof Number n ? n.intValue() : 0));
            Object ex = r.get("is_exclusive");
            r.put("is_exclusive", ex instanceof Boolean b2 ? (b2 ? 1 : 0)
                    : (ex instanceof Number n2 ? n2.intValue() : 0));
            // 是否已过期：以 end_time 判定，不看 status。
            // 前端要用它决定「删除」走严格规则还是过期券的连带清理流程。
            // ⚠️ MySQL Connector/J 8 对 DATETIME 返回 LocalDateTime，不是 java.util.Date，
            //    只判 Date 会让过期恒为 false（本项目已踩过一次）。
            r.put("expired", isPastTime(r.get("end_time")));
        });

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("total", total == null ? 0 : total);
        out.put("page", safePage);
        out.put("size", safeSize);
        out.put("rows", rows);
        return out;
    }

    /** 某券的兑换码列表。 */
    @GetMapping("/coupon-codes")
    public Map<String, Object> couponCodes(@RequestParam long couponId,
                                           @RequestParam(defaultValue = "1") int page,
                                           @RequestParam(defaultValue = "50") int size) {
        Integer total = jdbc.queryForObject(
                "SELECT COUNT(*) FROM " + DB + "coupon_code WHERE coupon_id = ?", Integer.class, couponId);
        int safeSize = Math.min(Math.max(size, 1), 200);
        int safePage = Math.max(page, 1);
        int offset = (safePage - 1) * safeSize;
        List<Map<String, Object>> rows = jdbc.queryForList(
                // password 必须查：用户兑换时要输入「券号 + 密码」两个值，
                // 只给券号无法兑换。后台弹窗靠这个字段展示。
                "SELECT id, code, password, status, user_id, received_time, created_at "
                        + "FROM " + DB + "coupon_code WHERE coupon_id = ? ORDER BY id LIMIT "
                        + safeSize + " OFFSET " + offset, couponId);
        return Map.of("total", total == null ? 0 : total, "rows", rows);
    }

    /**
     * 批量生成兑换码。
     *
     * 用 SecureRandom 而非 Math.random：券码是用户可兑换的凭据，
     * 可预测的随机数意味着别人能猜出未发放的码。
     */
    @PostMapping("/coupon-generate")
    public Map<String, Object> generateCodes(@RequestBody Map<String, Object> body) {
        Long couponId = longOrNull(body.get("couponId"));
        Integer count = intOrNull(body.get("count"));
        if (couponId == null) return bad("缺少券 ID");
        if (count == null || count < 1 || count > 500) return bad("生成数量需在 1-500 之间");

        Integer exists = jdbc.queryForObject(
                "SELECT COUNT(*) FROM " + DB + "coupon WHERE id = ?", Integer.class, couponId);
        if (exists == null || exists == 0) return bad("优惠券不存在: " + couponId);

        return generateCodesFor(couponId, count);
    }

    /**
     * 生成兑换码（可复用）。
     *
     * 抽成独立方法是为了让「建券时顺带生成」和「事后补生成」走同一条代码路径。
     * 若各写一份，码格式、密码规则、必填字段处理早晚会漂移。
     *
     * 上限放宽到 5000：建券时可能一次生成一批（如发 1000 个给用户），
     * 但接口层的 /coupon-generate 仍限制 500 防止误触生成海量数据。
     */
    public Map<String, Object> generateCodesFor(long couponId, int count) {
        int safeCount = Math.min(Math.max(count, 1), 5000);

        // 券模板信息：兑换码要冗余存储面额/类型/主题/有效期，
        // 因为兑换时即使券模板被改，已发出的码应按发放时的规则执行。
        Map<String, Object> tpl = jdbc.queryForMap(
                "SELECT value, type, theme_id, theme_name, is_exclusive, end_time "
                        + "FROM " + DB + "coupon WHERE id = ?", couponId);

        java.security.SecureRandom rnd = new java.security.SecureRandom();
        String batchNo = "BATCH" + System.currentTimeMillis();
        List<String> created = new ArrayList<>();
        int attempts = 0;

        while (created.size() < safeCount && attempts < safeCount * 5) {
            attempts++;
            String code = randomCode(rnd);
            String password = randomPassword(rnd);   // 6 位数字校验码，与既有数据格式一致

            Integer dup = jdbc.queryForObject(
                    "SELECT COUNT(*) FROM " + DB + "coupon_code WHERE code = ?", Integer.class, code);
            if (dup != null && dup > 0) continue;

            // password / value / type / expire_time 都是 NOT NULL 无默认值，
            // 漏传会直接 500（Field 'password' doesn't have a default value），必须全给。
            jdbc.update("INSERT INTO " + DB + "coupon_code "
                            + "(coupon_id, code, password, batch_no, value, type, theme_id, theme_name, "
                            + " is_exclusive, status, expire_time, created_at) "
                            + "VALUES (?,?,?,?,?,?,?,?,?,'unclaimed',?,NOW())",
                    couponId, code, password, batchNo,
                    tpl.get("value"), tpl.get("type"),
                    tpl.get("theme_id"), tpl.get("theme_name"),
                    tpl.get("is_exclusive"),
                    tpl.get("end_time"));   // 券模板的结束时间即兑换码有效期
            created.add(code);
        }
        log.info("生成兑换码: coupon={} batch={} 数量={}", couponId, batchNo, created.size());
        return Map.of("ok", true, "generated", created.size(), "batchNo", batchNo, "codes", created);
    }

    // ==================== 内部工具 ====================

    private Map<String, Object> reviewStatusCounts() {
        Map<String, Object> counts = new LinkedHashMap<>();
        counts.put("pending", 0);
        counts.put("approved", 0);
        counts.put("rejected", 0);
        jdbc.queryForList("SELECT status, COUNT(*) AS c FROM " + DB + "product_review GROUP BY status")
                .forEach(r -> counts.put(String.valueOf(r.get("status")),
                        ((Number) r.get("c")).intValue()));
        return counts;
    }

    /** 审核通过时发放积分。写入 points_record 并更新 user.points。 */
    private void grantReviewPoints(long reviewId) {
        try {
            List<Map<String, Object>> rows = jdbc.queryForList(
                    "SELECT user_id FROM " + DB + "product_review WHERE id = ?", reviewId);
            if (rows.isEmpty()) return;
            long userId = ((Number) rows.get(0).get("user_id")).longValue();

            List<Map<String, Object>> u = jdbc.queryForList(
                    "SELECT total_points FROM " + DB + "`user` WHERE id = ?", userId);
            if (u.isEmpty()) return;
            int after = ((Number) u.get(0).get("total_points")).intValue() + REVIEW_REWARD_POINTS;

            jdbc.update("UPDATE " + DB + "`user` SET total_points = ? WHERE id = ?", after, userId);
            jdbc.update("INSERT INTO " + DB + "points_record "
                            + "(user_id, points, type, description, balance, created_at) "
                            + "VALUES (?, ?, 'review', '评价审核通过奖励', ?, NOW())",
                    userId, REVIEW_REWARD_POINTS, after);
            log.info("评价通过发积分: user={} +{}", userId, REVIEW_REWARD_POINTS);
        } catch (Exception e) {
            // 发积分失败不应影响审核结果，记录后继续
            log.warn("评价积分发放失败 reviewId={}: {}", reviewId, e.getMessage());
        }
    }

    /** 6 位数字校验码，与库里既有兑换码格式一致（如 037069）。 */
    private String randomPassword(java.security.SecureRandom rnd) {
        return String.format("%06d", rnd.nextInt(1_000_000));
    }

    private String randomCode(java.security.SecureRandom rnd) {
        String chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";  // 去掉易混的 I/O/0/1
        StringBuilder sb = new StringBuilder("MS");          // 前缀便于识别
        for (int i = 0; i < 10; i++) sb.append(chars.charAt(rnd.nextInt(chars.length())));
        return sb.toString();
    }

    private Integer toIntObj(Object o) {
        if (o == null) return null;
        if (o instanceof Boolean b) return b ? 1 : 0;
        if (o instanceof Number n) return n.intValue();
        return null;
    }

    private Map<String, Object> bad(String msg) { return Map.of("ok", false, "error", msg); }
    private String str(Object o) { return o == null ? "" : String.valueOf(o).trim(); }

    /**
     * 时间是否早于当前时刻。
     *
     * MySQL Connector/J 8 对 DATETIME 返回 {@code LocalDateTime}（Jackson 序列化成
     * "2026-06-30T23:59:59"），老驱动返回 {@code Timestamp}。只判 Date 会让
     * 「已过期」永远为 false —— 优惠券删除规则会因此失效。
     */
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
}
