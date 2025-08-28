package com.hospital.user.test;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordTest {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        
        // 数据库中的密码哈希
        String storedHash = "$2a$10$6NjSfZlB.5bQZ7bq5VvC3eRjB2dXbLW7cWgYHdz0JjKb1mYf7Q9QK";
        
        // 测试不同的密码
        String[] testPasswords = {"123456", "admin123", "password", "admin", "hospital"};
        
        for (String password : testPasswords) {
            if (encoder.matches(password, storedHash)) {
                System.out.println("✓ 正确密码: " + password);
            } else {
                System.out.println("✗ 错误密码: " + password);
            }
        }
        
        // 生成123456的正确哈希
        String correctHash = encoder.encode("123456");
        System.out.println("123456的正确哈希: " + correctHash);
    }
}