package com.guchen.controller;

import com.guchen.pojo.Teaware;
import com.guchen.pojo.VProductShopFull;
import com.guchen.pojo.VThemeProductCategory;
import com.guchen.service.ProductService;
import com.guchen.service.TeawareService;
import com.guchen.service.VProductShopFullService;
import com.guchen.service.VThemeProductCategoryService;
import com.guchen.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("product")
@CrossOrigin
public class productController {

    @Autowired
    VProductShopFullService vProductShopFullService;

    @Autowired
    VThemeProductCategoryService vThemeProductCategoryService;

    @Autowired
    ProductService productService;

    @Autowired
    TeawareService teawareService;

    @PostMapping("selectSingle")
    public Result selectSingle(@RequestBody VProductShopFull vProductShopFull) {
        Result result = vProductShopFullService.selectVProductShopFullById(vProductShopFull);
        return result;
    }

    @PostMapping("ThemeSingle")
    public Result ThemeSingle(@RequestBody VThemeProductCategory vThemeProductCategory) {
        Result result = vThemeProductCategoryService.selectProductTheme(vThemeProductCategory);
        return result;
    }

    @GetMapping("shopSpecList")
    public Result shopSpecList() {
        Result result = productService.selectShopSpecList();
        return result;
    }

    @GetMapping("teaware")
    public Result teaware() {
        Result result = teawareService.selectTeawareId();
        return result;
    }

    // ==================== 库存扣减 / 回补（2026-10-23 新增） ====================
    //
    // 背景：本项目原先没有任何库存扣减逻辑，下单只校验不扣减，等于无限超卖。
    // 把扣减放在老项目侧（数据属主），agent-service 通过 Feign 调用，
    // 避免新模块直接写 db_tear（跨库写会绕过老项目的全部业务校验）。
    //
    // 鉴权：这两个接口是写操作，**不在** WebConfig 的公开白名单里，
    // 因此必须携带有效 token —— agent-service 调用时会透传用户 token。

    @PostMapping("deductStock")
    public Result deductStock(@RequestBody java.util.Map<String, Object> body) {
        Long specId = toLong(body.get("specId"));
        Integer qty = toInt(body.get("qty"));
        return productService.deductStock(specId, qty);
    }

    @PostMapping("restoreStock")
    public Result restoreStock(@RequestBody java.util.Map<String, Object> body) {
        Long specId = toLong(body.get("specId"));
        Integer qty = toInt(body.get("qty"));
        return productService.restoreStock(specId, qty);
    }

    private static Long toLong(Object v) {
        if (v == null) return null;
        try {
            return Long.valueOf(String.valueOf(v).trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private static Integer toInt(Object v) {
        if (v == null) return null;
        try {
            return Integer.valueOf(String.valueOf(v).trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
