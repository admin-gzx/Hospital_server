package com.hospital.user.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hospital.user.entity.User;
import com.hospital.user.mapper.UserMapper;
import com.hospital.user.service.RedisService;
import com.hospital.user.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.concurrent.TimeUnit;

/**
 * 用户服务实现类
 * 继承自MyBatis-Plus的ServiceImpl
 * 实现UserService接口定义的业务逻辑
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    // 日志记录器
    private static final Logger log = LoggerFactory.getLogger(UserServiceImpl.class);

    /**
     * 用户Mapper
     * 用于数据库操作
     */
    @Resource
    private UserMapper userMapper;

    @Resource
    private RedisService redisService;

    // 用户信息缓存前缀
    private static final String USER_CACHE_PREFIX = "user:";

    /**
     * 根据用户名查询用户
     * @param username 用户名
     * @return 用户对象，如果不存在则返回null
     */
    @Override
    public User getUserByUsername(String username) {
        // 先从缓存中获取
        String cacheKey = USER_CACHE_PREFIX + username;
        Object cachedUser = redisService.get(cacheKey);
        if (cachedUser != null) {
            return (User) cachedUser;
        }

        // 缓存未命中，从数据库查询
        User user = lambdaQuery().eq(User::getUsername, username).one();

        // 存入缓存，有效期1小时
        if (user != null) {
            redisService.set(cacheKey, user, 1, TimeUnit.HOURS);
        }

        return user;
    }

    /**
     * 更新用户状态
     * @param id 用户ID
     * @param status 状态(0:禁用,1:启用)
     * @return 是否更新成功
     */
    @Override
    public boolean updateUserStatus(Long id, Integer status) {
        boolean result = lambdaUpdate()
                .eq(User::getId, id)
                .set(User::getStatus, status)
                .update();

        // 更新成功后，清除缓存
        if (result) {
            User user = lambdaQuery().eq(User::getId, id).one();
            if (user != null) {
                redisService.delete(USER_CACHE_PREFIX + user.getUsername());
            }
        }

        return result;
    }

    /**
     * 重写父类方法，添加缓存逻辑
     */
    @Override
    public boolean save(User user) {
        boolean result = super.save(user);
        // 保存成功后，清除缓存
        if (result) {
            redisService.delete(USER_CACHE_PREFIX + user.getUsername());
        }
        return result;
    }

    /**
     * 重写父类方法，添加缓存逻辑
     */
    @Override
    public boolean updateById(User user) {
        boolean result = super.updateById(user);
        // 更新成功后，清除缓存
        if (result) {
            redisService.delete(USER_CACHE_PREFIX + user.getUsername());
        }
        return result;
    }

    /**
     * 重写父类方法，添加缓存逻辑
     */
    @Override
    public boolean removeById(Serializable id) {
        // 先查询用户，以便后续清除缓存
        User user = lambdaQuery().eq(User::getId, id).one();
        if (user == null) {
            // 用户不存在，直接返回false
            return false;
        }
        
        // 执行删除操作
        boolean result = super.removeById(id);
        
        // 删除成功后，清除缓存
        if (result) {
            try {
                redisService.delete(USER_CACHE_PREFIX + user.getUsername());
            } catch (Exception e) {
                // 记录缓存删除失败的日志
                log.error("Failed to delete user cache for username: {}", user.getUsername(), e);
            }
        }
        
        return result;
    }
}