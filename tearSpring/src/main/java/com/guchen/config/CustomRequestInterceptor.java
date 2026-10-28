package com.guchen.config;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.stereotype.Component;
import com.guchen.pojo.User;
import com.guchen.pojo.ThreadLocalUtil;
import com.guchen.utils.JwtHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.servlet.HandlerInterceptor;
import com.guchen.service.impl.UserServiceImpl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 自定义拦截器
 * */
@Component
public class CustomRequestInterceptor implements HandlerInterceptor {

    @Autowired
    JwtHelper jwtHelper;

    @Autowired
    UserServiceImpl userServiceImpl;

    @Autowired
    StringRedisTemplate stringRedisTemplate;

    // 1.请求处理执行（核心，用于权限校验、日志记录等）
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 示例：获取请求路径并打印日志
        String requestURI = request.getRequestURI();
        System.out.println("【preHandle】请求路径：" + requestURI + "，请求方式：" + request.getMethod());
        // 查询请求发出前的OPTIONS请求是检查服务器是否支持跨域请求的，它并没有带上headers中的token信息，所以后台在接到OPTIONS请求后获取不到token信息，直接返回了。所以前端也出现跨域情况。
        String method = request.getMethod();
        if ("OPTIONS".equals(method)) {//放行options请求
            return true;
        }
        // 令牌验证
        try {
            String token = request.getHeader("token");
            // 【2026-10-23 修复】原实现把完整 token 打到 stdout（"令牌访问：" + token），
            // token 等于会话口令，落盘即等于凭据泄露。这里只保留长度特征，便于排查。
            System.out.println("=====来自拦截器===== token=" + (token == null ? "null" : "***(" + token.length() + ")"));
            if(!jwtHelper.isExpiration(token)) {
                String userId = String.valueOf(jwtHelper.getUserId(token));
                System.out.println("userId:" + userId);
                LambdaQueryWrapper<User> lambdaQueryWrapper = new LambdaQueryWrapper<>();
                lambdaQueryWrapper.select(User::getId, User::getUsername).eq(User::getId, userId);
                User user = userServiceImpl.getOne(lambdaQueryWrapper);
                // 【2026-10-23 修复】原来直接 user.toString()：
                //   1) user 为 null 时抛 NPE，被外层 catch 吞掉后统一判 401，排查时看不到真因；
                //   2) 完整 User 实体（含手机号、邮箱）被逐请求打印，日志里全是明文 PII。
                if (user == null) {
                    System.out.println("令牌对应的用户不存在，拒绝访问");
                    response.setStatus(401);
                    return false;
                }
                System.out.println("user: id=" + user.getId() + ", username=" + user.getUsername());
                String rediaToken = this.stringRedisTemplate.opsForValue().get(user.getUsername());
                if(rediaToken == null || !rediaToken.equals(token)) {
                    System.out.println("令牌二次校验未通过");
                    response.setStatus(401);
                    return false;
                }
                System.out.println("令牌校验通过!");
                ThreadLocalUtil.set(user);
                return true;
            }else {
                System.out.println("=============" + jwtHelper.isExpiration(token));
                System.out.println("令牌校验未通过");
                response.setStatus(401);
                return false;
            }
        }catch (Exception e) {
            System.out.println("异常，拒绝访问");
            response.setStatus(401);
            return false;
        }
    }
}
