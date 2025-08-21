package com.hospital.user.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hospital.user.entity.User;
import com.hospital.user.mapper.UserMapper;
import com.hospital.user.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 用户服务实现类
 * 继承自MyBatis-Plus的ServiceImpl
 * 实现UserService接口定义的业务逻辑
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    /**
     * 用户Mapper
     * 用于数据库操作
     */
    @Resource
    private UserMapper userMapper;

    /**
     * 根据用户名查询用户
     * @param username 用户名
     * @return 用户对象，如果不存在则返回null
     */
    @Override
    public User getUserByUsername(String username) {
        // 使用lambdaQuery构建查询条件
        // eq表示等于，查询用户名等于传入参数的用户
        // one()表示返回单个结果
        return lambdaQuery().eq(User::getUsername, username).one();
    }

    /**
     * 更新用户状态
     * @param id 用户ID
     * @param status 状态(0:禁用,1:启用)
     * @return 是否更新成功
     */
    @Override
    public boolean updateUserStatus(Long id, Integer status) {
        // 使用lambdaUpdate构建更新条件
        // eq表示条件，set表示要更新的字段
        // update()执行更新操作并返回是否成功
        return lambdaUpdate()
                .eq(User::getId, id)
                .set(User::getStatus, status)
                .update();
    }
}