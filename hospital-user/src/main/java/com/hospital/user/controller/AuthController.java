package com.hospital.user.controller;

import com.hospital.user.util.JwtTokenProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * 认证控制器
 * 处理用户登录请求
 */
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private static final Logger log = LoggerFactory.getLogger(AuthController.class);

    @Resource
    private AuthenticationManager authenticationManager;

    @Resource
    private JwtTokenProvider tokenProvider;

    /**
     * 用户登录
     */
    @PostMapping("/login")
    public ResponseEntity<?> authenticateUser(@RequestBody LoginRequest loginRequest) {
        log.info("收到登录请求，用户名: {}", loginRequest != null ? loginRequest.getUsername() : "null");
        
        try {
            // 验证请求参数
            if (loginRequest == null) {
                log.error("登录请求体为空");
                return ResponseEntity.badRequest().body(Map.of("error", "请求体不能为空"));
            }
            
            if (loginRequest.getUsername() == null || loginRequest.getUsername().trim().isEmpty()) {
                log.error("用户名为空");
                return ResponseEntity.badRequest().body(Map.of("error", "用户名不能为空"));
            }
            
            if (loginRequest.getPassword() == null || loginRequest.getPassword().trim().isEmpty()) {
                log.error("密码为空");
                return ResponseEntity.badRequest().body(Map.of("error", "密码不能为空"));
            }

            // 认证用户
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            loginRequest.getUsername().trim(),
                            loginRequest.getPassword().trim()
                    )
            );

            // 设置认证上下文
            SecurityContextHolder.getContext().setAuthentication(authentication);

            // 生成JWT令牌
            String jwt = tokenProvider.generateToken(authentication);
            log.info("用户 {} 登录成功", loginRequest.getUsername());

            // 构建响应
            Map<String, String> response = new HashMap<>();
            response.put("token", jwt);
            response.put("type", "Bearer");
            response.put("username", loginRequest.getUsername());

            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            log.error("登录失败，用户名: {}, 错误: {}", loginRequest.getUsername(), e.getMessage());
            return ResponseEntity.badRequest().body(Map.of("error", "登录失败: " + e.getMessage()));
        }
    }

    /**
     * 登录请求参数
     */
    public static class LoginRequest {
        private String username;
        private String password;

        // 默认构造函数（JSON反序列化必需）
        public LoginRequest() {}

        public LoginRequest(String username, String password) {
            this.username = username;
            this.password = password;
        }

        // getter and setter
        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        @Override
        public String toString() {
            return "LoginRequest{username='" + username + "', password='***'}";
        }
    }
}