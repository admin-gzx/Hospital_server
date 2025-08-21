package com.hospital.user.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 权限实体类
 * 映射到数据库表 sys_permission
 * 用于存储系统中的权限信息，支持细粒度的权限控制
 * 包括菜单级和按钮级权限，支持权限树结构
 */
@Data
@TableName("sys_permission")
public class Permission {
    /**
     * 主键ID
     * 使用自增策略
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 权限名称
     */
    private String name;

    /**
     * 权限描述
     */
    private String description;

    /**
     * 权限标识
     * 用于Spring Security的权限控制
     */
    private String permission;

    /**
     * 资源类型
     * menu:菜单, button:按钮
     */
    private String resourceType;

    /**
     * 资源路径
     * 如URL路径
     */
    private String resourcePath;

    /**
     * 父权限ID
     * 用于构建权限树
     */
    private Long parentId;

    /**
     * 排序
     */
    private Integer sort;

    /**
     * 状态
     * 0:禁用, 1:启用
     */
    private Integer status;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;
}