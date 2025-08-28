package com.hospital.user.test;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class BCryptFormatTest {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        
        // 生成一个测试密码
        String rawPassword = "123456";
        String encodedPassword = encoder.encode(rawPassword);
        
        System.out.println("原始密码: " + rawPassword);
        System.out.println("BCrypt加密后的密码: " + encodedPassword);
        System.out.println("BCrypt密码格式特征:");
        System.out.println("1. 以$2a$开头");
        System.out.println("2. 后跟两位数字表示成本因子(如10)");
        System.out.println("3. 后跟$符号");
        System.out.println("4. 后跟22个字符的盐值");
        System.out.println("5. 后跟$符号");
        System.out.println("6. 后跟31个字符的哈希值");
        
        // 验证密码格式
        if (encodedPassword.startsWith("$2a$") || encodedPassword.startsWith("$2y$")) {
            System.out.println("\n✓ 密码格式正确，使用了BCrypt加密");
        } else {
            System.out.println("\n✗ 密码格式不正确，未使用BCrypt加密");
        }
        
        // 验证用户提供的BCrypt哈希值
        String userHash = "$2a$10$7JB720yOZir6d1IRUKY7C.oyqyP6RAxZJ3.Ggzr5W8wrwCskF59e";
        String testPassword = "123456";
        
        System.out.println("\n验证用户提供的BCrypt哈希值:");
        System.out.println("哈希值: " + userHash);
        System.out.println("测试密码: " + testPassword);
        
        if (encoder.matches(testPassword, userHash)) {
            System.out.println("\n✓ 哈希值匹配，原始密码是: " + testPassword);
        } else {
            System.out.println("\n✗ 哈希值不匹配");
        }
    }
}