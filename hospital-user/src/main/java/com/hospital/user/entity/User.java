package com.hospital.user.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 用户实体类
 * 映射到数据库表 sys_user
 * 用于存储医院工作人员的基本信息
 */
@Data
@TableName("sys_user")
public class User implements Serializable {
    /**
     * 主键ID
     * 使用自增策略
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 用户名
     * 唯一标识一个用户
     */
    private String username;

    /**
     * 密码
     * 存储用户的登录密码（通常经过加密处理）
     */
    private String password;

    /**
     * 真实姓名
     * 用户的真实姓名
     */
    private String realName;

    /**
     * 部门
     * 用户所属的部门
     */
    private String department;

    /**
     * 职位
     * 用户的职位
     */
    private String position;

    /**
     * 电话
     * 用户的联系电话
     */
    private String phone;

    /**
     * 邮箱
     * 用户的电子邮箱
     */
    private String email;

    /**
     * 状态
     * 0:禁用, 1:启用
     */
    private Integer status;

    /**
     * 角色ID
     * 关联到角色表的主键
     */
    private Long roleId;

    /**
     * 角色信息
     * 非数据库字段，用于存储关联的角色信息
     */
    @TableField(exist = false)
    private Role role;

    /**
     * 创建时间
     * 记录用户创建的时间
     */
    private LocalDateTime createTime;

    /**
     * 更新时间
     * 记录用户信息最后更新的时间
     */
    private LocalDateTime updateTime;
}