package com.guchen.agent.admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 后台登录接口。
 *
 * 这些路径由 AdminWebConfig 排除在拦截器之外（否则无法登录），
 * 校验逻辑在 AdminAuthInterceptor —— 放在那里而不是这里，
 * 是为了让「哪些路径需要什么权限」集中在一处，不会出现新加 Controller 忘加校验。
 */
@Slf4j
@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminAuthController {

    private final AdminAuthInterceptor auth;

    /** 登录页用来判断是否启用鉴权、以及当前令牌对应什么身份。 */
    @GetMapping("/auth-status")
    public Map<String, Object> status(@RequestHeader(value = "X-Admin-Token", required = false) String token) {
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("authEnabled", auth.authEnabled());
        Map<String, String> who = auth.whoami(token);
        out.put("loggedIn", !auth.authEnabled() || who != null);
        if (who != null) {
            out.put("username", who.get("username"));
            out.put("role", who.get("role"));
        }
        return out;
    }

    /**
     * 登录：校验账号口令，成功后返回令牌与角色。
     *
     * 失败统一返回「账号或口令错误」，不区分用户不存在与口令错 —— 区分越细越方便枚举。
     */
    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody Map<String, String> body) {
        if (body == null) {
            return Map.of("ok", false, "error", "请求格式错误");
        }
        String username = body.get("username");
        String password = body.get("password");

        // 兼容只传 password 的旧调用方式：默认用户名为 admin
        if ((username == null || username.isBlank()) && password != null) {
            username = "admin";
        }

        Map<String, Object> r = auth.login(username, password);
        if (r == null) {
            log.warn("后台登录失败: 用户名={}", username);
            return Map.of("ok", false, "error", "账号或口令错误");
        }
        r.put("authRequired", auth.authEnabled());
        return r;
    }

    /** 登出：删除 Redis 令牌，立即失效。 */
    @PostMapping("/logout")
    public Map<String, Object> logout(@RequestHeader(value = "X-Admin-Token", required = false) String token) {
        auth.logout(token);
        return Map.of("ok", true);
    }
}
