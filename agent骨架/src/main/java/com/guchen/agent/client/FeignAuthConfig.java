package com.guchen.agent.client;

import feign.RequestInterceptor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * Feign 调用老项目时透传 token。
 *
 * 老项目的 CustomRequestInterceptor 要求请求头带 token，
 * 且会用 Redis 做二次校验（token 必须与 Redis 中该用户的 token 一致）。
 * 因此 Agent 侧不能伪造 token，只能把用户的原始 token 透传下去。
 */
@Slf4j
@Configuration
public class FeignAuthConfig {

    private static final ThreadLocal<String> TOKEN_HOLDER = new ThreadLocal<>();

    public static void setToken(String token) { TOKEN_HOLDER.set(token); }
    public static void clear() { TOKEN_HOLDER.remove(); }

    /**
     * 取当前线程正在透传的 token。
     *
     * 用途：交易工具需要知道「这单是谁下的」（确认令牌必须绑定发起人），
     * 而 ToolRegistry.execute(name, json) 的签名里没有 token 参数，
     * 只能从这条透传链路取回。
     */
    public static String getToken() { return TOKEN_HOLDER.get(); }

    @Bean
    public RequestInterceptor authForwardInterceptor() {
        return template -> {
            // 优先取显式设置的（异步线程 / MQ 消费线程场景）
            String token = TOKEN_HOLDER.get();
            if (token == null) {
                // 兜底：从当前 HTTP 请求上下文取
                ServletRequestAttributes attrs =
                        (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
                if (attrs != null) {
                    token = attrs.getRequest().getHeader("token");
                }
            }
            if (token != null && !token.isBlank()) {
                template.header("token", token);
            } else {
                log.debug("Feign 调用未携带 token，老项目将返回 401");
            }
        };
    }
}
