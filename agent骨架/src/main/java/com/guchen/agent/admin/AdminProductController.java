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
 * 商品新建与编辑（含多规格、图片、主题关联）。
 *
 * <h3>为什么必须用事务</h3>
 * 新建一个商品要写 3~4 张表：product → product_spec[] → product_image[] → shop_theme[]。
 * 任一环节失败都会留下「有商品没有规格」的残骸 —— 这种数据在小程序端表现为
 * 商品详情页空白、加购报错，而且很难排查。所以整个流程包在一个事务里，
 * 失败则全部回滚。
 *
 * <h3>product.stock / product.price 怎么维护</h3>
 * 这两个字段是「默认规格」的展示副本，真实库存在 product_spec。
 * 保存时从规格数组里取 is_default=1 的那条（没有就取第一条）回写到 product，
 * 保证列表页与详情页展示一致，而不是让两份数据各自漂移。
 */
@Slf4j
@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminProductController {

    private final JdbcTemplate jdbc;

    private static final String DB = "db_tear.";

    /**
     * 新建商品。请求体结构：
     * <pre>
     * {
     *   "name": "明前龙井", "categoryId": 1, "shopId": 1,
     *   "subtitle": "...", "description": "...", "origin": "...",
     *   "emoji": "🍵", "status": 1, "isNew": true, "isHot": false,
     *   "specs": [ {"specName":"标准装 100g","price":198,"originalPrice":258,
     *               "stock":100,"isDefault":true} ],
     *   "images": ["/static/xxx.jpg"],
     *   "themeIds": [1,2]
     * }
     * </pre>
     */
    @PostMapping("/product-create")
    @Transactional
    public Map<String, Object> createProduct(@RequestBody Map<String, Object> body) {
        String name = str(body.get("name"));
        if (name.isBlank()) return bad("商品名称不能为空");
        if (name.length() > 200) return bad("商品名称超长（上限 200 字）");

        Integer categoryId = intOrNull(body.get("categoryId"));
        Integer shopId = intOrNull(body.get("shopId"));
        if (categoryId == null) return bad("必须选择分类");
        if (shopId == null) return bad("必须选择店铺");

        // 分类与店铺必须真实存在，否则外键报错信息对使用者不友好
        if (exists("SELECT COUNT(*) FROM " + DB + "category WHERE id = ?", categoryId) == 0)
            return bad("分类不存在: " + categoryId);
        if (exists("SELECT COUNT(*) FROM " + DB + "shop WHERE id = ?", shopId) == 0)
            return bad("店铺不存在: " + shopId);

        List<Map<String, Object>> specs = mapList(body.get("specs"));
        if (specs.isEmpty()) return bad("至少需要一个规格");
        for (Map<String, Object> s : specs) {
            String sn = str(s.get("specName"));
            if (sn.isBlank()) return bad("规格名称不能为空");
            Double p = dblOrNull(s.get("price"));
            if (p == null || p < 0) return bad("规格「" + sn + "」价格非法");
            Integer st = intOrNull(s.get("stock"));
            if (st != null && st < 0) return bad("规格「" + sn + "」库存不能为负");
        }

        // 默认规格：优先 isDefault=true，否则第一条
        Map<String, Object> def = specs.stream()
                .filter(s -> Boolean.TRUE.equals(s.get("isDefault")))
                .findFirst().orElse(specs.get(0));
        double defPrice = dblOrNull(def.get("price"));
        int defStock = intOrNull(def.get("stock")) == null ? 0 : intOrNull(def.get("stock"));

        // ---- 1. product ----
        KeyHolder kh = new GeneratedKeyHolder();
        jdbc.update(con -> {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO " + DB + "product "
                            + "(category_id, shop_id, name, subtitle, description, origin, origin_detail, "
                            + " year, craft, spec, price, original_price, stock, sales, rating, emoji, "
                            + " is_new, is_hot, status, created_at, updated_at) "
                            + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,0,5.0,?,?,?,?,NOW(),NOW())",
                    Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, categoryId);
            ps.setInt(2, shopId);
            ps.setString(3, name);
            ps.setString(4, str(body.get("subtitle")));
            ps.setString(5, str(body.get("description")));
            ps.setString(6, str(body.get("origin")));
            ps.setString(7, str(body.get("originDetail")));
            ps.setString(8, str(body.get("year")));
            ps.setString(9, str(body.get("craft")));
            ps.setString(10, str(def.get("specName")));
            ps.setDouble(11, defPrice);
            Double op = dblOrNull(def.get("originalPrice"));
            if (op == null) ps.setNull(12, java.sql.Types.DECIMAL); else ps.setDouble(12, op);
            ps.setInt(13, defStock);
            ps.setString(14, str(body.get("emoji")));
            ps.setInt(15, Boolean.TRUE.equals(body.get("isNew")) ? 1 : 0);
            ps.setInt(16, Boolean.TRUE.equals(body.get("isHot")) ? 1 : 0);
            ps.setInt(17, intOrNull(body.get("status")) == null ? 1 : intOrNull(body.get("status")));
            return ps;
        }, kh);

        long productId = kh.getKey() == null ? 0 : kh.getKey().longValue();
        if (productId == 0) return bad("商品创建失败，未取到主键");

        // ---- 2. product_spec ----
        int order = 0;
        for (Map<String, Object> s : specs) {
            jdbc.update("INSERT INTO " + DB + "product_spec "
                            + "(product_id, spec_name, price, original_price, stock, sales, is_default, sort_order) "
                            + "VALUES (?,?,?,?,?,0,?,?)",
                    productId, str(s.get("specName")), dblOrNull(s.get("price")),
                    dblOrNull(s.get("originalPrice")),
                    intOrNull(s.get("stock")) == null ? 0 : intOrNull(s.get("stock")),
                    Boolean.TRUE.equals(s.get("isDefault")) ? 1 : 0,
                    order++);
        }

        // ---- 3. product_image ----
        List<Object> images = body.get("images") instanceof List<?> l ? new ArrayList<>(l) : List.of();
        int imgIdx = 0;
        for (Object img : images) {
            String url = str(img);
            if (url.isBlank()) continue;
            jdbc.update("INSERT INTO " + DB + "product_image (product_id, image_url, sort_order, is_main) "
                    + "VALUES (?,?,?,?)", productId, url, imgIdx, imgIdx == 0 ? 1 : 0);
            imgIdx++;
        }

        // ---- 4. shop_theme 关联 ----
        List<Object> themeIds = body.get("themeIds") instanceof List<?> l2 ? new ArrayList<>(l2) : List.of();
        int tIdx = 0;
        for (Object t : themeIds) {
            Integer tid = intOrNull(t);
            if (tid == null) continue;
            if (exists("SELECT COUNT(*) FROM " + DB + "theme WHERE id = ?", tid) == 0) continue;
            jdbc.update("INSERT INTO " + DB + "shop_theme (shop_id, theme_id, sort_order) VALUES (?,?,?)",
                    shopId, tid, tIdx++);
        }

        log.info("后台新建商品: id={} name={} 规格数={} 图片数={}",
                productId, name, specs.size(), imgIdx);
        return Map.of("ok", true, "id", productId,
                "specCount", specs.size(), "imageCount", imgIdx);
    }

    /**
     * 编辑商品基础信息（不含规格与图片，它们在各自接口里改）。
     */
    @PostMapping("/product-update")
    public Map<String, Object> updateProduct(@RequestBody Map<String, Object> body) {
        Long id = longOrNull(body.get("id"));
        if (id == null) return bad("缺少商品 ID");
        if (exists("SELECT COUNT(*) FROM " + DB + "product WHERE id = ?", id) == 0)
            return bad("商品不存在: " + id);

        List<String> sets = new ArrayList<>();
        List<Object> args = new ArrayList<>();
        putIfPresent(sets, args, "name", body.get("name"));
        putIfPresent(sets, args, "subtitle", body.get("subtitle"));
        putIfPresent(sets, args, "description", body.get("description"));
        putIfPresent(sets, args, "origin", body.get("origin"));
        putIfPresent(sets, args, "emoji", body.get("emoji"));
        if (body.get("categoryId") != null) { sets.add("category_id = ?"); args.add(intOrNull(body.get("categoryId"))); }
        if (body.get("shopId") != null) { sets.add("shop_id = ?"); args.add(intOrNull(body.get("shopId"))); }
        if (body.get("status") != null) { sets.add("status = ?"); args.add(intOrNull(body.get("status"))); }
        if (body.get("isNew") != null) { sets.add("is_new = ?"); args.add(Boolean.TRUE.equals(body.get("isNew")) ? 1 : 0); }
        if (body.get("isHot") != null) { sets.add("is_hot = ?"); args.add(Boolean.TRUE.equals(body.get("isHot")) ? 1 : 0); }

        if (sets.isEmpty()) return bad("没有要修改的字段");
        sets.add("updated_at = NOW()");
        args.add(id);

        jdbc.update("UPDATE " + DB + "product SET " + String.join(", ", sets) + " WHERE id = ?", args.toArray());
        log.info("后台编辑商品: id={} 字段={}", id, sets.size() - 1);
        return Map.of("ok", true, "updated", sets.size() - 1);
    }

    /**
     * 新增规格。
     */
    @PostMapping("/spec-create")
    public Map<String, Object> createSpec(@RequestBody Map<String, Object> body) {
        Long productId = longOrNull(body.get("productId"));
        if (productId == null) return bad("缺少商品 ID");
        if (exists("SELECT COUNT(*) FROM " + DB + "product WHERE id = ?", productId) == 0)
            return bad("商品不存在: " + productId);

        String specName = str(body.get("specName"));
        if (specName.isBlank()) return bad("规格名称不能为空");
        Double price = dblOrNull(body.get("price"));
        if (price == null || price < 0) return bad("价格非法");
        Integer stock = intOrNull(body.get("stock"));
        if (stock != null && stock < 0) return bad("库存不能为负");

        KeyHolder kh = new GeneratedKeyHolder();
        jdbc.update(con -> {
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO " + DB + "product_spec "
                            + "(product_id, spec_name, price, original_price, stock, sales, is_default, sort_order) "
                            + "VALUES (?,?,?,?,?,0,?,?)", Statement.RETURN_GENERATED_KEYS);
            ps.setLong(1, productId);
            ps.setString(2, specName);
            ps.setDouble(3, price);
            Double op = dblOrNull(body.get("originalPrice"));
            if (op == null) ps.setNull(4, java.sql.Types.DECIMAL); else ps.setDouble(4, op);
            ps.setInt(5, stock == null ? 0 : stock);
            ps.setInt(6, Boolean.TRUE.equals(body.get("isDefault")) ? 1 : 0);
            ps.setInt(7, intOrNull(body.get("sortOrder")) == null ? 0 : intOrNull(body.get("sortOrder")));
            return ps;
        }, kh);

        long newId = kh.getKey() == null ? 0 : kh.getKey().longValue();
        syncProductDefault(productId);
        return Map.of("ok", true, "id", newId);
    }

    /** 删除规格。至少保留一个，否则商品在详情页会无规格可选。 */
    @PostMapping("/spec-delete")
    public Map<String, Object> deleteSpec(@RequestBody Map<String, Object> body) {
        Long specId = longOrNull(body.get("specId"));
        if (specId == null) return bad("缺少规格 ID");

        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT product_id FROM " + DB + "product_spec WHERE id = ?", specId);
        if (rows.isEmpty()) return bad("规格不存在: " + specId);
        long productId = ((Number) rows.get(0).get("product_id")).longValue();

        Integer cnt = jdbc.queryForObject(
                "SELECT COUNT(*) FROM " + DB + "product_spec WHERE product_id = ?", Integer.class, productId);
        if (cnt != null && cnt <= 1) return bad("这是最后一个规格，不能删除（否则商品无法下单）");

        jdbc.update("DELETE FROM " + DB + "product_spec WHERE id = ?", specId);
        syncProductDefault(productId);
        return Map.of("ok", true);
    }

    /** 图片列表与增删。 */
    @PostMapping("/product-image-add")
    public Map<String, Object> addImage(@RequestBody Map<String, Object> body) {
        Long productId = longOrNull(body.get("productId"));
        String url = str(body.get("imageUrl"));
        if (productId == null || url.isBlank()) return bad("缺少商品 ID 或图片地址");
        if (url.length() > 255) return bad("图片地址超长（上限 255 字符）");

        Integer cnt = jdbc.queryForObject(
                "SELECT COUNT(*) FROM " + DB + "product_image WHERE product_id = ?", Integer.class, productId);
        boolean first = cnt == null || cnt == 0;
        jdbc.update("INSERT INTO " + DB + "product_image (product_id, image_url, sort_order, is_main) "
                + "VALUES (?,?,?,?)", productId, url, cnt == null ? 0 : cnt, first ? 1 : 0);
        return Map.of("ok", true, "isMain", first);
    }

    @PostMapping("/product-image-delete")
    public Map<String, Object> deleteImage(@RequestBody Map<String, Object> body) {
        Long imageId = longOrNull(body.get("imageId"));
        if (imageId == null) return bad("缺少图片 ID");
        int n = jdbc.update("DELETE FROM " + DB + "product_image WHERE id = ?", imageId);
        return n > 0 ? Map.of("ok", true) : bad("图片不存在: " + imageId);
    }

    /** 主题/专题关联：全量覆盖式设置（前端传完整列表）。 */
    @PostMapping("/product-themes")
    public Map<String, Object> setThemes(@RequestBody Map<String, Object> body) {
        Long productId = longOrNull(body.get("productId"));
        if (productId == null) return bad("缺少商品 ID");

        List<Map<String, Object>> prod = jdbc.queryForList(
                "SELECT shop_id FROM " + DB + "product WHERE id = ?", productId);
        if (prod.isEmpty()) return bad("商品不存在: " + productId);
        int shopId = ((Number) prod.get(0).get("shop_id")).intValue();

        // shop_theme 是店铺与主题的关联表，且带 spec_id；
        // 按 shop+theme 删除会误伤同店铺其它商品，所以这里只做「新增缺失的关联」，不删。
        List<Object> themeIds = body.get("themeIds") instanceof List<?> l ? new ArrayList<>(l) : List.of();
        int added = 0;
        for (Object t : themeIds) {
            Integer tid = intOrNull(t);
            if (tid == null) continue;
            Integer exist = jdbc.queryForObject(
                    "SELECT COUNT(*) FROM " + DB + "shop_theme WHERE shop_id = ? AND theme_id = ?",
                    Integer.class, shopId, tid);
            if (exist != null && exist > 0) continue;
            jdbc.update("INSERT INTO " + DB + "shop_theme (shop_id, theme_id, sort_order) VALUES (?,?,?)",
                    shopId, tid, 0);
            added++;
        }
        return Map.of("ok", true, "added", added);
    }

    // ==================== 内部工具 ====================

    /**
     * 把默认规格的价格与库存回写到 product 表。
     *
     * product.price/stock 是展示副本，规格才是真相源。
     * 每次规格变动后同步一次，保证列表页价格与详情页一致。
     */
    private void syncProductDefault(long productId) {
        try {
            List<Map<String, Object>> rows = jdbc.queryForList(
                    "SELECT price, stock FROM " + DB + "product_spec WHERE product_id = ? "
                            + "ORDER BY is_default DESC, sort_order, id LIMIT 1", productId);
            if (rows.isEmpty()) return;
            jdbc.update("UPDATE " + DB + "product SET price = ?, stock = ?, updated_at = NOW() WHERE id = ?",
                    rows.get(0).get("price"), rows.get(0).get("stock"), productId);
        } catch (Exception e) {
            log.warn("同步商品默认规格失败 productId={}: {}", productId, e.getMessage());
        }
    }

    private void putIfPresent(List<String> sets, List<Object> args, String col, Object v) {
        if (v == null) return;
        sets.add(col + " = ?");
        args.add(String.valueOf(v));
    }

    private int exists(String sql, Object... args) {
        Integer n = jdbc.queryForObject(sql, Integer.class, args);
        return n == null ? 0 : n;
    }

    private Map<String, Object> bad(String msg) {
        return Map.of("ok", false, "error", msg);
    }

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

    @SuppressWarnings("unchecked")
    private List<Map<String, Object>> mapList(Object o) {
        if (o instanceof List<?> l) {
            List<Map<String, Object>> out = new ArrayList<>();
            for (Object e : l) if (e instanceof Map) out.add((Map<String, Object>) e);
            return out;
        }
        return List.of();
    }

    // ==================== 查询：编辑页需要的下拉与详情 ====================

    /** 新建/编辑商品页的下拉数据。 */
    @GetMapping("/product-form-options")
    public Map<String, Object> formOptions() {
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("shops", jdbc.queryForList("SELECT id, name FROM " + DB + "shop ORDER BY id"));
        out.put("categories", jdbc.queryForList("SELECT id, name FROM " + DB + "category ORDER BY id"));
        out.put("themes", jdbc.queryForList("SELECT id, name FROM " + DB + "theme ORDER BY id"));
        return out;
    }

    /** 商品完整信息：基础 + 规格 + 图片 + 主题。 */
    @GetMapping("/product-full")
    public Map<String, Object> productFull(@RequestParam long id) {
        List<Map<String, Object>> p = jdbc.queryForList(
                "SELECT p.*, s.name AS shop_name, c.name AS category_name FROM " + DB + "product p "
                        + "LEFT JOIN " + DB + "shop s ON s.id = p.shop_id "
                        + "LEFT JOIN " + DB + "category c ON c.id = p.category_id WHERE p.id = ?", id);
        if (p.isEmpty()) return Map.of("error", "商品不存在: " + id);

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("product", p.get(0));
        out.put("specs", jdbc.queryForList(
                "SELECT id, spec_name, price, original_price, stock, sales, is_default, sort_order "
                        + "FROM " + DB + "product_spec WHERE product_id = ? ORDER BY is_default DESC, sort_order, id", id));
        out.put("images", jdbc.queryForList(
                "SELECT id, image_url, sort_order, is_main FROM " + DB + "product_image "
                        + "WHERE product_id = ? ORDER BY sort_order, id", id));
        return out;
    }
}
