package com.guchen.agent.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * 声明式调用老项目 tearSpring 的接口（SpringCloud OpenFeign + LoadBalancer）。
 *
 * 老项目只需在 application.yaml 里加：
 *   spring.application.name=tearSpring
 *   spring.cloud.nacos.discovery.server-addr=127.0.0.1:8848
 * 即可被发现，无需改任何业务代码。
 *
 * 注意：老项目是 Spring Boot 2.6.13，返回体是 com.guchen.utils.Result，
 * 这里统一用 String/Map 接收，避免跨版本反序列化耦合。
 */
/**
 * ⚠️ 为什么同时保留 url 与 name：
 *
 * 只写 name 时 Feign 走 Nacos 服务发现，用注册的实例 IP 连接。
 * 但本机开发环境 IP 会变（换 WiFi / VPN 重连 / DHCP 续租），
 * Nacos 里存的是旧 IP，于是所有 Feign 调用全部超时 ——
 * 表现为「用户信息、商品、订单查询突然全挂」，而日志里只有一行 Connect timed out。
 *
 * 配置 services.tear-spring.url 后直连该地址，绕开服务发现；
 * 留空则退回 Nacos 服务发现（生产环境多实例时用）。
 * 本地默认填 127.0.0.1:8080，不受本机 IP 变化影响。
 */
@FeignClient(
        name = "${services.tear-spring.service-name}",
        url = "${services.tear-spring.url:}",
        path = "",
        configuration = FeignAuthConfig.class,
        fallbackFactory = TearSpringClientFallback.class
)
public interface TearSpringClient {

    // ==================== 商品 ====================

    @PostMapping("/product/selectSingle")
    String productDetail(@RequestBody Map<String, Object> body);

    @GetMapping("/product/shopSpecList")
    String shopSpecList();

    @GetMapping("/product/teaware")
    String teawareList();

    // ==================== 主题 / 分类 ====================

    @GetMapping("/theme/lists")
    String themeList();

    @GetMapping("/theme/themeProductList")
    String themeProductList();

    @GetMapping("/category/lists")
    String categoryList();

    // ==================== 店铺 ====================

    @PostMapping("/shop/SingleOne")
    String shopDetail(@RequestBody Map<String, Object> body);

    @PostMapping("/shop/productList")
    String shopProducts(@RequestBody Map<String, Object> body);

    // ==================== 购物车 ====================

    @GetMapping("/cart/VCartDetail")
    String cartDetail();

    @PostMapping("/cart/insertCartItem")
    String addToCart(@RequestBody com.fasterxml.jackson.databind.JsonNode body);

    @DeleteMapping("/cart/delCartItem")
    String removeFromCart(@RequestBody Map<String, Object> body);

    // ==================== 订单 ====================

    @GetMapping("/order/VOrderData")
    String orderData();

    @GetMapping("/order/VOrderItemDetail")
    String orderItemDetail();

    @PostMapping("/order/OrderData")
    String createOrder(@RequestBody com.fasterxml.jackson.databind.JsonNode body);

    @PostMapping("/order/OrderItemData")
    String createOrderItems(@RequestBody com.fasterxml.jackson.databind.JsonNode body);

    // ==================== 优惠券 ====================

    @PostMapping("/coupon/codeNo")
    String redeemCoupon(@RequestBody com.fasterxml.jackson.databind.JsonNode body);

    @GetMapping("/coupon/selectCUListId")
    String couponList();

    @GetMapping("/coupon/selectCouponUserVOList")
    String couponUserList();

    // ==================== 用户 ====================

    @GetMapping("/user/userData")
    String userData();

    @GetMapping("/user/addressI")
    String addressList();

    /** 新增/更新收货地址（老项目按 id 是否存在自动区分插入与更新） */
    @PostMapping("/user/addressUpdateInsert")
    String addressUpsert(@RequestBody com.fasterxml.jackson.databind.JsonNode body);

    @GetMapping("/user/noteI")
    String noteList();

    // ==================== 茶友圈 ====================

    @GetMapping("/moment/list")
    String momentList();

    /**
     * 关键词搜索：老项目没有专门的搜索接口，
     * 这里先用全量商品列表 + 本地过滤兜底；后续可在老项目加 /product/search。
     */
    @GetMapping("/product/shopSpecList")
    String searchProductRaw();

    // ==================== 库存扣减 / 回补（2026-10-23 新增） ====================
    //
    // 原项目全仓没有任何库存扣减代码，下单只校验不扣减 → 库存永远不减、可无限超卖。
    // 扣减动作放在数据属主（老项目）侧执行，agent-service 只发起调用，
    // 避免新模块直接写 db_tear 绕过老项目的业务校验。

    @PostMapping("/product/deductStock")
    String deductStock(@RequestBody Map<String, Object> body);

    @PostMapping("/product/restoreStock")
    String restoreStock(@RequestBody Map<String, Object> body);

    default String searchProduct(String keyword) {
        return searchProductRaw();
    }
}
