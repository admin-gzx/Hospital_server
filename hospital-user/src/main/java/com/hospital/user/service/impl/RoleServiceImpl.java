package com.hospital.user.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hospital.user.entity.Role;
import com.hospital.user.mapper.RoleMapper;
import com.hospital.user.service.RoleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 角色Service实现类
 * 实现角色管理的业务逻辑方法
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    @Resource
    private RoleMapper roleMapper;

    /**
     * 获取所有角色
     */
    @Override
    public List<Role> getAllRoles() {
        return roleMapper.selectList(null);
    }

    /**
     * 根据ID获取角色
     */
    @Override
    public Role getRoleById(Long id) {
        return roleMapper.selectById(id);
    }

    /**
     * 创建角色
     */
    @Override
    public boolean createRole(Role role) {
        role.setCreateTime(LocalDateTime.now());
        role.setUpdateTime(LocalDateTime.now());
        return roleMapper.insert(role) > 0;
    }

    /**
     * 更新角色
     */
    @Override
    public boolean updateRole(Role role) {
        role.setUpdateTime(LocalDateTime.now());
        return roleMapper.updateById(role) > 0;
    }

    /**
     * 删除角色
     */
    @Override
    public boolean deleteRole(Long id) {
        return roleMapper.deleteById(id) > 0;
    }

    /**
     * 更新角色状态
     */
    @Override
    public boolean updateRoleStatus(Long id, Integer status) {
        Role role = new Role();
        role.setId(id);
        role.setStatus(status);
        role.setUpdateTime(LocalDateTime.now());
        return roleMapper.updateById(role) > 0;
    }
}