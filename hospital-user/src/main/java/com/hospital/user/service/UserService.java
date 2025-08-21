package com.hospital.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hospital.user.entity.User;

/**
 * 用户服务接口
 * 继承自MyBatis-Plus的IService
 * 定义用户相关的业务逻辑操作
 */
public interface UserService extends IService<User> {
    /**
     * 根据用户名查询用户
     * @param username 用户名
     * @return 用户对象
     */
    User getUserByUsername(String username);

    /**
     * 更新用户状态
     * @param id 用户ID
     * @param status 状态(0:禁用,1:启用)
     * @return 是否更新成功
     */
    boolean updateUserStatus(Long id, Integer status);
}