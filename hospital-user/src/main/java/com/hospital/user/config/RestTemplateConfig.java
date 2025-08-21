package com.hospital.user.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

/**
 * REST模板配置类
 * 用于创建和配置RestTemplate实例，实现与其他微服务的通信
 */
@Configuration
public class RestTemplateConfig {

    /**
     * 创建RestTemplate实例
     * @return RestTemplate实例
     */
    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}