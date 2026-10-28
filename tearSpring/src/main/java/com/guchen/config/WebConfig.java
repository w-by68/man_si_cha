package com.guchen.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private CustomRequestInterceptor requestInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 注册拦截，并设置放行路径
        //
        // 【2026-10-23 修复】补充「公开只读接口」白名单。
        // 原实现只放行登录/注册/验证码，导致商品列表、商品详情、分类、主题、店铺
        // 等纯展示接口在未登录时全部 401 —— 小程序首屏对未登录用户直接空白，
        // agent-service 的「匿名访客 s{sessionId}」记忆域也因此成为死代码。
        // 这里只放行**只读**接口（不涉及下单/地址/购物车/优惠券/评价），
        // 写接口仍然必须携带有效 token。
        registry.addInterceptor(requestInterceptor).excludePathPatterns(
                // 账号相关
                "/user/login", "/user/regist", "/user/captcha", "/user/yzmcap",
                // 商品与目录（只读）
                "/product/shopSpecList", "/product/selectSingle", "/product/ThemeSingle",
                "/product/teaware",
                "/category/lists",
                "/theme/lists", "/theme/themeProductList",
                // 店铺与茶友圈（只读）
                "/shop/SingleOne", "/shop/productList",
                "/moment/list");
    }

}
