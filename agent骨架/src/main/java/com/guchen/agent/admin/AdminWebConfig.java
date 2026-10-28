package com.guchen.agent.admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 把后台鉴权拦截器挂到 /api/admin/** 上。
 *
 * 单独一个配置类而不是塞进 AdminAuthInterceptor 自己，
 * 是因为拦截器只该负责「怎么校验」，注册路径属于装配职责。
 * 这样将来要改作用范围（比如把 /api/agent/** 也纳入），只改这里。
 */
@Slf4j
@Configuration
@RequiredArgsConstructor
public class AdminWebConfig implements WebMvcConfigurer {

    private final AdminAuthInterceptor adminAuthInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(adminAuthInterceptor)
                // 只保护后台接口。业务接口（/api/agent/**）走 JWT，是另一套鉴权，不能混用
                .addPathPatterns("/api/admin/**")
                // 登录/登出/状态查询必须放行，否则无法登录
                .excludePathPatterns(
                        "/api/admin/login",
                        "/api/admin/logout",
                        "/api/admin/auth-status"
                        // C 端评价列表挂在 /api/admin/public/** 下，
                        // 但它由小程序直接调用、不带后台令牌，必须放行。
                        // 它只返回已审核通过的评价，且匿名信息在服务端擦除，
                        // 所以公开不构成数据泄露。
                        , "/api/admin/public/**"
                );
        log.info("后台鉴权拦截器已注册：/api/admin/**（登录相关路径除外）");
    }
}
