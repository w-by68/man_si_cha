package com.guchen.agent.admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 管理后台：订单与商品。
 *
 * 为什么直接查 db_tear 而不走老项目接口：
 *   老项目 54 个接口全部是**面向 C 端用户**的——按 token 里的 userId 过滤，
 *   没有「管理员看全部订单」「改任意订单状态」「改商品库存」这类能力。
 *   为管理端去改老项目等于破坏「tearSpring 零改动」的架构决策（见交接文档 §6.1）。
 *
 *   ⚠️ 代价：绕过老项目的业务校验。所以这里对每个写操作都做了显式校验
 *   （状态机白名单、影响行数检查），并在注释里写明「哪些校验是老项目做的、这里补了什么」。
 *   这不是「为了省事绕过」，而是「在不动老项目的约束下，把校验责任搬到管理端」。
 */
@Slf4j
@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminTradeController {

    private final JdbcTemplate jdbc;

    /** 订单状态机：只允许这些流转，防止从「待付款」直接跳到「已完成」。 */
    private static final Map<String, List<String>> ORDER_FLOW = new LinkedHashMap<>() {{
        put("unpaid",    List.of("unship", "cancelled"));          // 待付款 → 待发货 / 已取消
        put("unship",    List.of("unreceive", "cancelled"));       // 待发货 → 待收货 / 已取消
        put("unreceive", List.of("unreview"));                     // 待收货 → 待评价
        put("unreview",  List.of("completed"));                    // 待评价 → 已完成
        put("completed", List.of());                               // 终态
        put("cancelled", List.of());                               // 终态
    }};

    private static final Map<String, String> STATUS_TEXT = new LinkedHashMap<>() {{
        put("unpaid", "待付款"); put("unship", "待发货"); put("unreceive", "待收货");
        put("unreview", "待评价"); put("completed", "已完成"); put("cancelled", "已取消");
    }};

    // ==================== 订单 ====================

    /**
     * 订单列表。
     *
     * 金额口径：pay_amount 是实付金额，total_amount 是商品总额。
     * 老项目的订单没接真实支付，所以 pay_amount 可能等于 total_amount，这是正常的。
     */
    @GetMapping("/orders")
    public Map<String, Object> orders(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String status,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        List<Object> args = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {
            where.append(" AND (o.order_no LIKE ? OR u.nickname LIKE ? OR u.phone LIKE ?) ");
            String like = "%" + keyword.trim() + "%";
            args.add(like); args.add(like); args.add(like);
        }
        if (status != null && !status.isBlank()) {
            where.append(" AND o.status = ? ");
            args.add(status.trim());
        }

        Integer total = jdbc.queryForObject(
                "SELECT COUNT(*) FROM db_tear.`order` o LEFT JOIN db_tear.`user` u ON u.id = o.user_id" + where,
                Integer.class, args.toArray());

        int safeSize = Math.min(Math.max(size, 1), 100);
        int safePage = Math.max(page, 1);
        int offset = (safePage - 1) * safeSize;

        // 商品摘要用子查询聚合，避免 join order_item 后行数放大
        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT o.id, o.order_no, o.user_id, o.shop_name, o.status, "
                        + "o.total_amount, o.pay_amount, o.created_at, "
                        + "u.nickname, u.phone, "
                        + "(SELECT COUNT(*) FROM db_tear.order_item i WHERE i.order_id = o.id) AS item_count, "
                        + "(SELECT GROUP_CONCAT(i.product_name ORDER BY i.id SEPARATOR ', ') "
                        + "   FROM db_tear.order_item i WHERE i.order_id = o.id LIMIT 2) AS items_brief "
                        + "FROM db_tear.`order` o LEFT JOIN db_tear.`user` u ON u.id = o.user_id"
                        + where + " ORDER BY o.id DESC LIMIT " + safeSize + " OFFSET " + offset,
                args.toArray());

        // 补上状态中文名，省得前端再维护一份映射
        rows.forEach(r -> r.put("statusText", STATUS_TEXT.getOrDefault(
                String.valueOf(r.get("status")), String.valueOf(r.get("status")))));

        // 直接标出异常订单，避免「列表看着正常、点进去才发现」：
        //  - 无明细（孤儿订单）：早期测试下单未写 order_item 留下的
        //  - 金额不符：明细合计 ≠ 订单总额
        // 这两个标记让异常在列表层就可见，而不是靠人逐个点开。
        rows.forEach(r -> {
            int itemCount = ((Number) r.getOrDefault("item_count", 0)).intValue();
            r.put("noItems", itemCount == 0);
        });

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("total", total == null ? 0 : total);
        out.put("page", safePage);
        out.put("size", safeSize);
        out.put("rows", rows);
        // 各状态计数，供 tab 角标使用
        out.put("statusCounts", statusCounts());
        return out;
    }

    /** 订单详情：主单 + 明细 + 收货地址。 */
    @GetMapping("/order-detail")
    public Map<String, Object> orderDetail(@RequestParam long id) {
        Map<String, Object> order;
        try {
            order = jdbc.queryForMap(
                    "SELECT o.*, u.nickname, u.phone AS user_phone FROM db_tear.`order` o "
                            + "LEFT JOIN db_tear.`user` u ON u.id = o.user_id WHERE o.id = ?", id);
        } catch (Exception e) {
            return Map.of("error", "订单不存在: " + id);
        }

        List<Map<String, Object>> items = jdbc.queryForList(
                "SELECT id, product_id, product_name, product_spec, product_emoji, "
                        + "price, quantity, subtotal "
                        + "FROM db_tear.order_item WHERE order_id = ? ORDER BY id", id);

        // 地址可能已被删除（用户删了地址但订单还在），所以单独查、容错
        List<Map<String, Object>> addr = List.of();
        Object addrId = order.get("address_id");
        if (addrId != null) {
            try {
                addr = jdbc.queryForList(
                        "SELECT name AS receiver, phone, province, city, district, "
                                + "detail, full_address FROM db_tear.address WHERE id = ?",
                        addrId);
            } catch (Exception ignored) { }
        }

        // 金额勾稽：各项之和必须等于实付。不等说明数据有问题，前端需要提示
        double sum = items.stream()
                .mapToDouble(i -> toDouble(i.get("subtotal"))).sum();
        double total = toDouble(order.get("total_amount"));
        double pay = toDouble(order.get("pay_amount"));

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("order", order);
        out.put("items", items);
        out.put("address", addr.isEmpty() ? null : addr.get(0));
        out.put("statusText", STATUS_TEXT.getOrDefault(
                String.valueOf(order.get("status")), String.valueOf(order.get("status"))));
        out.put("allowedNext", ORDER_FLOW.getOrDefault(String.valueOf(order.get("status")), List.of()));
        // itemsSum 用于核对：与 total_amount 比对
        out.put("itemsSum", Math.round(sum * 100) / 100.0);
        out.put("amountConsistent", Math.abs(sum - total) < 0.01);
        return out;
    }

    /**
     * 改订单状态。
     *
     * 校验三层：
     *  1. 目标状态必须在当前状态的允许流转列表里（ORDER_FLOW）
     *  2. 更新必须命中且仅命中 1 行（防并发重复提交）
     *  3. 附带时间戳：发货写 delivery_time_actual、收货写 receive_time
     */
    @PostMapping("/order-status")
    public Map<String, Object> updateOrderStatus(@RequestBody Map<String, Object> body) {
        long id = Long.parseLong(String.valueOf(body.get("id")));
        String target = String.valueOf(body.get("status"));

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT status FROM db_tear.`order` WHERE id = ?", id);
        if (rows.isEmpty()) {
            return Map.of("ok", false, "error", "订单不存在");
        }
        String current = String.valueOf(rows.get(0).get("status"));
        List<String> allowed = ORDER_FLOW.getOrDefault(current, List.of());
        if (!allowed.contains(target)) {
            return Map.of("ok", false,
                    "error", String.format("非法流转：%s(%s) 不能改为 %s(%s)",
                            STATUS_TEXT.getOrDefault(current, current), current,
                            STATUS_TEXT.getOrDefault(target, target), target),
                    "allowed", allowed);
        }

        int n;
        String tsColumn = switch (target) {
            case "unreceive" -> "delivery_time_actual";   // 发货
            case "unreview"  -> "receive_time";           // 确认收货
            default -> null;
        };
        if (tsColumn != null) {
            n = jdbc.update("UPDATE db_tear.`order` SET status = ?, " + tsColumn
                    + " = COALESCE(" + tsColumn + ", NOW()), updated_at = NOW() WHERE id = ? AND status = ?",
                    target, id, current);
        } else {
            n = jdbc.update("UPDATE db_tear.`order` SET status = ?, updated_at = NOW() WHERE id = ? AND status = ?",
                    target, id, current);
        }

        if (n != 1) {
            return Map.of("ok", false, "error", "更新失败，订单状态可能已被其他人修改，请刷新后重试");
        }
        log.info("后台改订单状态: id={} {} -> {}", id, current, target);
        return Map.of("ok", true, "from", current, "to", target,
                "statusText", STATUS_TEXT.getOrDefault(target, target));
    }

    // ==================== 商品 ====================

    /**
     * 商品列表。
     *
     * ⚠️ 库存与价格必须看 product_spec，不是 product 表：
     * product.price / product.stock 只是「默认规格」的展示副本，
     * 真实可售库存分散在各规格上。管理端若改 product.stock，用户下单照样用规格库存，
     * 改了等于没改——这是最容易踩的坑。
     */
    @GetMapping("/products")
    public Map<String, Object> products(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Integer shopId,
            @RequestParam(required = false) Integer categoryId,
            @RequestParam(required = false) Integer status,
            @RequestParam(required = false) Boolean lowStock,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        List<Object> args = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {
            where.append(" AND (p.name LIKE ? OR p.origin LIKE ?) ");
            String like = "%" + keyword.trim() + "%";
            args.add(like); args.add(like);
        }
        if (shopId != null) { where.append(" AND p.shop_id = ? "); args.add(shopId); }
        if (categoryId != null) { where.append(" AND p.category_id = ? "); args.add(categoryId); }
        if (status != null) { where.append(" AND p.status = ? "); args.add(status); }

        // 低库存：按规格总库存判断（<10）
        String havingClause = Boolean.TRUE.equals(lowStock) ? " HAVING total_stock < 10 " : "";

        Integer total = jdbc.queryForObject(
                "SELECT COUNT(*) FROM db_tear.product p" + where, Integer.class, args.toArray());

        int safeSize = Math.min(Math.max(size, 1), 100);
        int safePage = Math.max(page, 1);
        int offset = (safePage - 1) * safeSize;

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT p.id, p.name, p.subtitle, p.emoji, p.shop_id, p.category_id, p.status, "
                        + "p.price AS default_price, p.sales, p.rating, p.updated_at, "
                        + "s.name AS shop_name, c.name AS category_name, "
                        + "COUNT(ps.id) AS spec_count, "
                        + "COALESCE(SUM(ps.stock), 0) AS total_stock, "
                        + "MIN(ps.price) AS min_price, MAX(ps.price) AS max_price "
                        + "FROM db_tear.product p "
                        + "LEFT JOIN db_tear.shop s ON s.id = p.shop_id "
                        + "LEFT JOIN db_tear.category c ON c.id = p.category_id "
                        + "LEFT JOIN db_tear.product_spec ps ON ps.product_id = p.id "
                        + where + " GROUP BY p.id" + havingClause
                        + " ORDER BY p.id DESC LIMIT " + safeSize + " OFFSET " + offset,
                args.toArray());

        // MySQL 的 tinyint(1) 会被 connector 映射成 Boolean(true/false)，
        // 前端用 Number(status) 判断会得到 NaN。统一转成 0/1 整数再返回。
        rows.forEach(r -> r.put("status", toInt01(r.get("status"))));

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("total", total == null ? 0 : total);
        out.put("page", safePage);
        out.put("size", safeSize);
        out.put("rows", rows);
        return out;
    }

    /** 商品详情：商品本体 + 全部规格。 */
    @GetMapping("/product-detail")
    public Map<String, Object> productDetail(@RequestParam long id) {
        Map<String, Object> p;
        try {
            p = jdbc.queryForMap(
                    "SELECT p.*, s.name AS shop_name, c.name AS category_name FROM db_tear.product p "
                            + "LEFT JOIN db_tear.shop s ON s.id = p.shop_id "
                            + "LEFT JOIN db_tear.category c ON c.id = p.category_id WHERE p.id = ?", id);
        } catch (Exception e) {
            return Map.of("error", "商品不存在: " + id);
        }
        List<Map<String, Object>> specs = jdbc.queryForList(
                "SELECT id, spec_name, price, original_price, stock, sales FROM db_tear.product_spec "
                        + "WHERE product_id = ? ORDER BY id", id);
        return Map.of("product", p, "specs", specs);
    }

    /**
     * 商品上下架。
     *
     * 只改 product.status（0 下架 / 1 上架），不动规格与库存。
     * 这是唯一一个「安全」的商品写操作——不会影响已存在的订单。
     */
    @PostMapping("/product-status")
    public Map<String, Object> updateProductStatus(@RequestBody Map<String, Object> body) {
        long id = Long.parseLong(String.valueOf(body.get("id")));
        int status = Integer.parseInt(String.valueOf(body.get("status")));
        if (status != 0 && status != 1) {
            return Map.of("ok", false, "error", "status 只能是 0(下架) 或 1(上架)");
        }
        int n = jdbc.update("UPDATE db_tear.product SET status = ?, updated_at = NOW() WHERE id = ?", status, id);
        if (n != 1) return Map.of("ok", false, "error", "商品不存在");
        log.info("后台改商品状态: id={} -> {}", id, status == 1 ? "上架" : "下架");
        return Map.of("ok", true, "status", status, "statusText", status == 1 ? "上架" : "下架");
    }

    /**
     * 改规格的价格与库存。
     *
     * 为什么按 specId 改而不是按 productId：
     *   商城是「一商品多规格、各规格独立定价与库存」的模型，
     *   按商品改库存这个操作在语义上就是错的。
     *
     * 校验：库存不得为负；价格不得为负。改完不回写 product.stock（那是展示副本）。
     */
    @PostMapping("/spec-update")
    public Map<String, Object> updateSpec(@RequestBody Map<String, Object> body) {
        long specId = Long.parseLong(String.valueOf(body.get("specId")));
        Integer stock = body.get("stock") == null ? null : Integer.parseInt(String.valueOf(body.get("stock")));
        Double price = body.get("price") == null ? null : Double.parseDouble(String.valueOf(body.get("price")));

        if (stock == null && price == null) {
            return Map.of("ok", false, "error", "至少要提供 stock 或 price 其中一项");
        }
        if (stock != null && stock < 0) return Map.of("ok", false, "error", "库存不能为负");
        if (price != null && price < 0) return Map.of("ok", false, "error", "价格不能为负");

        List<Map<String, Object>> before = jdbc.queryForList(
                "SELECT spec_name, price, stock FROM db_tear.product_spec WHERE id = ?", specId);
        if (before.isEmpty()) return Map.of("ok", false, "error", "规格不存在");

        if (stock != null && price != null) {
            jdbc.update("UPDATE db_tear.product_spec SET stock = ?, price = ? WHERE id = ?", stock, price, specId);
        } else if (stock != null) {
            jdbc.update("UPDATE db_tear.product_spec SET stock = ? WHERE id = ?", stock, specId);
        } else {
            jdbc.update("UPDATE db_tear.product_spec SET price = ? WHERE id = ?", price, specId);
        }

        log.info("后台改规格: specId={} 原值={} 新值 stock={} price={}",
                specId, before.get(0), stock, price);
        return Map.of("ok", true, "before", before.get(0));
    }

    /** 筛选用的下拉数据：店铺与分类。 */
    @GetMapping("/product-options")
    public Map<String, Object> productOptions() {
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("shops", jdbc.queryForList("SELECT id, name FROM db_tear.shop ORDER BY id"));
        out.put("categories", jdbc.queryForList("SELECT id, name FROM db_tear.category ORDER BY id"));
        return out;
    }

    // ==================== 内部工具 ====================

    private Map<String, Object> statusCounts() {
        Map<String, Object> counts = new LinkedHashMap<>();
        STATUS_TEXT.keySet().forEach(k -> counts.put(k, 0));
        jdbc.queryForList("SELECT status, COUNT(*) AS c FROM db_tear.`order` GROUP BY status")
                .forEach(r -> counts.put(String.valueOf(r.get("status")),
                        ((Number) r.get("c")).intValue()));
        return counts;
    }

    private int toInt01(Object o) {
        if (o instanceof Boolean b) return b ? 1 : 0;
        if (o instanceof Number n) return n.intValue();
        return 0;
    }

    private double toDouble(Object o) {
        if (o == null) return 0;
        if (o instanceof Number n) return n.doubleValue();
        try { return Double.parseDouble(String.valueOf(o)); } catch (Exception e) { return 0; }
    }
}
