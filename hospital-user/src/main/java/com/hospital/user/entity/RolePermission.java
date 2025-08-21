package com.hospital.user.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 角色权限关联实体类
 * 映射到数据库表 sys_role_permission
 * 用于存储角色和权限的多对多关系
 * 通过该关联表实现RBAC（基于角色的访问控制）模型
 */
@Data
@TableName("sys_role_permission")
public class RolePermission {
    /**
     * 主键ID
     * 使用自增策略
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 角色ID
     * 关联到角色表的主键
     */
    private Long roleId;

    /**
     * 权限ID
     * 关联到权限表的主键
     */
    private Long permissionId;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;
}