package com.hospital.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hospital.user.entity.Role;

import java.util.List;

/**
 * 角色Service接口
 * 定义角色管理的业务逻辑方法
 */
public interface RoleService extends IService<Role> {

    /**
     * 获取所有角色
     * @return 角色列表
     */
    List<Role> getAllRoles();

    /**
     * 根据ID获取角色
     * @param id 角色ID
     * @return 角色对象
     */
    Role getRoleById(Long id);

    /**
     * 创建角色
     * @param role 角色对象
     * @return 是否成功
     */
    boolean createRole(Role role);

    /**
     * 更新角色
     * @param role 角色对象
     * @return 是否成功
     */
    boolean updateRole(Role role);

    /**
     * 删除角色
     * @param id 角色ID
     * @return 是否成功
     */
    boolean deleteRole(Long id);

    /**
     * 更新角色状态
     * @param id 角色ID
     * @param status 角色状态
     * @return 是否成功
     */
    boolean updateRoleStatus(Long id, Integer status);
}