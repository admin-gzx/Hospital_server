package com.hospital.user.config;

import com.hospital.user.entity.User;
import com.hospital.user.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.time.LocalDateTime;

/**
 * 数据初始化器
 * 用于在应用启动时创建初始数据
 */
@Component
public class DataInitializer implements CommandLineRunner {
    
    private static final Logger log = LoggerFactory.getLogger(DataInitializer.class);
    
    @Resource
    private UserService userService;
    
    @Resource
    private PasswordEncoder passwordEncoder;
    
    @Override
    public void run(String... args) throws Exception {
        // 检查是否已存在管理员用户
        User existingAdmin = userService.getUserByUsername("admin");
        if (existingAdmin == null) {
            // 创建管理员用户
            User admin = new User();
            admin.setUsername("admin");
            admin.setPassword(passwordEncoder.encode("123456"));
log.info("加密后的管理员密码: {}", admin.getPassword());
            admin.setRealName("管理员");
            admin.setDepartment("IT");
            admin.setPosition("系统管理员");
            admin.setPhone("13800138000");
            admin.setEmail("admin@hospital.com");
            admin.setStatus(1);
            admin.setRoleId(1L);
            admin.setCreateTime(LocalDateTime.now());
            admin.setUpdateTime(LocalDateTime.now());
            
            userService.save(admin);
            log.info("管理员用户创建成功，用户名: admin, 密码: 123456");
        } else {
            log.info("管理员用户已存在，跳过创建");
        }
    }
}