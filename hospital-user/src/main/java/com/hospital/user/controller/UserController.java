package com.hospital.user.controller;

import com.hospital.user.entity.User;
import com.hospital.user.service.UserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 用户控制器
 * 处理用户相关的HTTP请求
 * 提供RESTful API接口
 */
@RestController
@RequestMapping("/api/user")
public class UserController {

    /**
     * 用户服务
     * 用于处理业务逻辑
     */
    @Resource
    private UserService userService;

    /**
     * 获取所有用户
     * @return 用户列表
     */
    @GetMapping
    public List<User> getAllUsers() {
        return userService.list();
    }

    /**
     * 根据ID获取用户
     * @param id 用户ID
     * @return 用户对象，如果不存在则返回null
     */
    @GetMapping("/{id}")
    public User getUserById(@PathVariable Long id) {
        return userService.getById(id);
    }

    /**
     * 根据用户名获取用户
     * @param username 用户名
     * @return 用户对象，如果不存在则返回null
     */
    @GetMapping("/username/{username}")
    public User getUserByUsername(@PathVariable String username) {
        return userService.getUserByUsername(username);
    }

    /**
     * 创建新用户
     * @param user 用户对象
     * @return 是否创建成功
     */
    @PostMapping
    public boolean createUser(@RequestBody User user) {
        return userService.save(user);
    }

    /**
     * 更新用户信息
     * @param user 用户对象（包含更新后的信息）
     * @return 是否更新成功
     */
    @PutMapping
    public boolean updateUser(@RequestBody User user) {
        return userService.updateById(user);
    }

    /**
     * 更新用户状态
     * @param id 用户ID
     * @param status 状态(0:禁用,1:启用)
     * @return 是否更新成功
     */
    @PutMapping("/status/{id}/{status}")
    public boolean updateUserStatus(@PathVariable Long id, @PathVariable Integer status) {
        return userService.updateUserStatus(id, status);
    }

    /**
     * 删除用户
     * @param id 用户ID
     * @return 是否删除成功
     */
    @DeleteMapping("/{id}")
    public boolean deleteUser(@PathVariable Long id) {
        return userService.removeById(id);
    }
}