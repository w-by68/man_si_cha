package com.guchen.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 用户表
 * @TableName user
 */
@TableName(value ="user")
@Data
public class User {
    /**
     * 用户ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 用户名
     */
    @TableField(value = "username")
    private String username;

    /**
     * 手机号
     */
    @TableField(value = "phone")
    private String phone;

    /**
     * 邮箱
     */
    @TableField(value = "email")
    private String email;

    /**
     * 密码
     */
    @TableField(value = "password")
    private String password;

    /**
     * 昵称
     */
    @TableField(value = "nickname")
    private String nickname;

    /**
     * 头像URL
     */
    @TableField(value = "avatar")
    private String avatar;

    /**
     * 头像表情
     */
    @TableField(value = "avatar_emoji")
    private String avatarEmoji;

    /**
     * 性别 0-未知 1-男 2-女
     */
    @TableField(value = "gender")
    private Integer gender;

    /**
     * 生日
     */
    @TableField(value = "birthday")
    private String birthday;

    /**
     * 会员等级 0-普通 1-青铜 2-白银 3-黄金
     */
    @TableField(value = "vip_level")
    private Integer vipLevel;

    /**
     * 茶龄(天)
     */
    @TableField(value = "tea_age")
    private Integer teaAge;

    /**
     * 总积分
     */
    @TableField(value = "total_points")
    private Integer totalPoints;

    /**
     * 状态 0-禁用 1-正常
     */
    @TableField(value = "status")
    private Integer status;

    /**
     * 最后登录时间
     */
    @TableField(value = "last_login_time")
    private Date lastLoginTime;

    /**
     * 最后登录IP
     */
    @TableField(value = "last_login_ip")
    private String lastLoginIp;

    /**
     * 创建时间
     */
    @TableField(value = "created_at")
    private Date createdAt;

    /**
     * 更新时间
     */
    @TableField(value = "updated_at")
    private Date updatedAt;

    /**
     * 个性标签
     */
    @TableField(value = "signature")
    private String signature;

    // ==================== 登录时的验证码入参（非数据库字段） ====================
    //
    // 【2026-10-23 修复】原实现把验证码存在 UserServiceImpl 的单例实例字段里
    // （yzmcode/yzmuid/yzmcodinfo），导致两个严重问题：
    //   1. 全局共享 —— A 用户请求验证码会覆盖 B 用户的，并发下互相串号；
    //   2. 永不过期 —— login() 只比较字段、从不回查 Redis、也从不置空，
    //      同一验证码可被无限次复用。
    // 现在改为随登录请求带上 uuid + 用户输入的验证码，服务端直接查 Redis 并原子删除。
    // exist = false：MyBatis-Plus 不把它们当成表字段。

    @TableField(exist = false)
    private String useruid;

    @TableField(exist = false)
    private String useryzm;
}