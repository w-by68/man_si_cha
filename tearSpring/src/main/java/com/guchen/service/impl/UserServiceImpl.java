package com.guchen.service.impl;

import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.guchen.mapper.CartMapper;
import com.guchen.mapper.VUserProductMapper;
import com.guchen.pojo.Cart;
import com.guchen.pojo.VUserProduct;
import com.guchen.utils.Captchayzm;
import com.guchen.utils.JwtHelper;
import com.guchen.utils.MD5Util;
import com.guchen.utils.Result;
import com.wf.captcha.SpecCaptcha;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import com.guchen.pojo.User;
import com.guchen.service.UserService;
import com.guchen.mapper.UserMapper;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
* @author Administrator
* @description 针对表【user(用户表)】的数据库操作Service实现
* @createDate 2026-03-05 19:26:05
*/
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User>
    implements UserService{

    @Autowired
    UserMapper userMapper;

    @Autowired
    JwtHelper jwtHelper;

    @Autowired
    StringRedisTemplate stringRedisTemplate;

    @Autowired
    HttpServletRequest request;

    @Autowired
    CartMapper cartMapper;

    /** 验证码校验通过后的短时标记前缀（一次性，登录成功即删）。 */
    private static final String CAPTCHA_OK_PREFIX = "captcha:ok:";

    @Override
    public Result login(User user) {
        // ===== 【2026-10-23 修复】验证码校验改为「查 Redis + 原子消费」=====
        //
        // 原实现的问题：
        //   1. yzmcode / yzmcodinfo 是单例 @Service 的**实例字段** → 全局共享，
        //      并发请求互相覆盖（A 的验证码盖掉 B 的）；
        //   2. login() 只比较字段、从不删除、从不置空 → 同一验证码可无限复用；
        //   3. /user/captcha 直接把正确验证码放进响应体 → 脚本读一下就能过。
        // 现在：验证码只存在于 Redis（uuid → code，2 分钟），校验成功即删除；
        //      uuid 与用户输入从登录请求体带入（User.useruid / User.useryzm）。
        String uuid = user.getUseruid();
        String input = user.getUseryzm();
        if (uuid == null || uuid.trim().isEmpty() || input == null || input.trim().isEmpty()) {
            return Result.error("请先获取并填写验证码");
        }
        boolean captchaOk;
        try {
            String cached = stringRedisTemplate.opsForValue().get(uuid);
            captchaOk = cached != null && cached.equalsIgnoreCase(input.trim());
            // 无论对错都删掉 uuid 键：错一次即作废，防止暴力枚举
            stringRedisTemplate.delete(uuid);
            if (!captchaOk) {
                // 兼容「先 yzmcap 校验、再 login」的两步流程：yzmcap 已消费 uuid 并留下一次性标记
                String marker = stringRedisTemplate.opsForValue().get(CAPTCHA_OK_PREFIX + uuid);
                if (marker != null) {
                    stringRedisTemplate.delete(CAPTCHA_OK_PREFIX + uuid);
                    captchaOk = true;
                }
            }
        } catch (Exception e) {
            return Result.error("验证码服务暂不可用，请稍后重试");
        }
        if (!captchaOk) {
            return Result.error("验证码不正确或已失效");
        }

        // 根据账号查询用户
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getPhone, user.getPhone());
        User user1 = baseMapper.selectOne(wrapper);
        // 判断账号是否存在
        if (user1 == null) return Result.error("账号错误");
        // 判断密码
        if (user.getPassword() != null && user1.getPassword().equals(MD5Util.encrypt(user.getPassword()))) {
            // 根据用户生成token
            String token = jwtHelper.createToken(Long.valueOf(user1.getId()));
            // 把token存入redis并设置过期时间2小时
            this.stringRedisTemplate.opsForValue().set(user1.getUsername(), token, 120*60, TimeUnit.SECONDS);
            // 【2026-10-23 修复】原实现 System.out.println("token = " + token) 把会话凭据写进日志，
            // 任何能读日志的人都能直接冒用该用户身份。
            System.out.println("登录成功 userId=" + user1.getId());
            Result result = Result.ok("用户登录成功");
            result.put("token", token);
            // 【2026-10-23 修复】绝不把密码哈希回传给前端。
            // 原实现 result.put("user", user1) 会把 MD5 哈希、上次登录 IP 一起吐出去，
            // 任何人打开浏览器控制台就能拿到可离线爆破的口令摘要。
            user1.setPassword(null);
            user1.setLastLoginIp(null);
            result.put("user", user1);
            return result;
        }
        return Result.error("密码错误");
    }

    @Override
    public Result regist(User user) {
        // 根据账号查询用户
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getUsername, user.getUsername());
        Long count = userMapper.selectCount(queryWrapper);
        // 判断是否存在
        if (count > 0) return Result.error("用户已存在");
        // 加密用户密码
        user.setPassword(MD5Util.encrypt(user.getPassword()));
        // 插入用户
        int rows = userMapper.insert(user);
        // 插入购物车
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getUsername, user.getUsername());
        User user1 = baseMapper.selectOne(wrapper);
        Cart cart = new Cart();
        cart.setUserId(user1.getId());
        cart.setCreatedAt(new Date());
        cart.setUpdatedAt(new Date());
        cartMapper.insert(cart);
        return Result.ok("用户注册成功");
    }

    @Override
    public Result userInfo(String token) {
        System.out.println("验证token: " + token);
        // 1.判断是否有效
        if (token == null || jwtHelper.isExpiration(token)) {
            // true 过期，直接返回
            return Result.error("身份已过期");
        }
        // 2.获取token对于的用户
        int userId = jwtHelper.getUserId(token).intValue();
        // 3.查询数据
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getId, userId);
        User user = userMapper.selectOne(queryWrapper);
        if (user != null) {
            user.setPassword(null);
            return (Result) Result.ok("获取用户数据成功").put("user", user);
        }
        return Result.error("身份错误");
    }

    @Override
    public Result captcha() {
        SpecCaptcha specCaptcha = new SpecCaptcha(130, 48, 4);
        String code = specCaptcha.text().toLowerCase();
        String uuid = IdUtil.simpleUUID();

        // 存入redis并设置过期时间为2分钟
        this.stringRedisTemplate.opsForValue().set(uuid, code, 120, TimeUnit.SECONDS);
        Map<String, String> map = new HashMap<>(2);
        map.put("uuid", uuid);
        // 【2026-10-23 修复】原来这里还会 map.put("code", code) 把正确答案一起下发，
        // 验证码等于形同虚设（脚本直接读 code 就能登录）。现在只回图片与 uuid。
        map.put("captcha", specCaptcha.toBase64());
        return (Result) Result.ok("验证码生成成功").put("yzm", map);
    }

    @Override
    public Result yzmcap(Captchayzm captchayzm) {
        // 【2026-10-23 修复】不再写入任何实例字段（原来是单例字段，全局串号且永不失效）。
        // 这里做一次「预校验」，成功后写下 2 分钟的一次性标记，
        // login() 见到标记即放行；也兼容前端跳过本接口、直接在 login 里带 uuid+code 的调用。
        if (captchayzm == null || captchayzm.getUseruid() == null || captchayzm.getUseryzm() == null) {
            return Result.error("验证码参数不完整");
        }
        String uuid = captchayzm.getUseruid();
        String input = captchayzm.getUseryzm().trim();
        String cached = this.stringRedisTemplate.opsForValue().get(uuid);
        if (cached == null) {
            return Result.error("验证码已失效，请重新获取");
        }
        if (!cached.equalsIgnoreCase(input)) {
            // 输错一次即作废，防枚举
            this.stringRedisTemplate.delete(uuid);
            return Result.error("验证码不正确");
        }
        this.stringRedisTemplate.delete(uuid);
        this.stringRedisTemplate.opsForValue().set(CAPTCHA_OK_PREFIX + uuid, "1", 120, TimeUnit.SECONDS);
        return Result.ok("成功接收验证码");
    }

    @Override
    public Result selectUserData() {
        String token = request.getHeader("token");
        Long userId = jwtHelper.getUserId(token);
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getId, userId);
        User userData = userMapper.selectOne(wrapper);
        Result result = Result.ok("获取用户数据成功！");
        // 【2026-10-23 修复】与 userInfo() 保持一致：密码哈希永不下发
        if (userData != null) {
            userData.setPassword(null);
            userData.setLastLoginIp(null);
        }
        result.put("userData", userData);
        return result;
    }

    @Override
    public Result userDataUpdate(User user) {
        Long userId = jwtHelper.getUserId(request.getHeader("token"));
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getId, userId);
        User userData = userMapper.selectOne(wrapper);
        if(userData != null) {
            userData.setAvatarEmoji(user.getAvatarEmoji());
            userData.setBirthday(user.getBirthday());
            userData.setGender(user.getGender());
            userData.setNickname(user.getNickname());
            userData.setSignature(user.getSignature());
            userData.setTeaAge(user.getTeaAge() * 365);
            userData.setUpdatedAt(new Date());
            userMapper.updateById(userData);
        }
        return Result.ok("用户数据更新成功");
    }
}




