# Upload hospital-user.yml to Nacos
$userConfig = @"
server:
  port: 8081

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/hospital_user?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=GMT%2B8
    username: root
    password: 123456
    driver-class-name: com.mysql.cj.jdbc.Driver
  redis:
    host: localhost
    port: 6379
    password: your_redis_password
    database: 0

mybatis-plus:
  mapper-locations: classpath:mapper/*.xml
  type-aliases-package: com.hospital.user.entity
  configuration:
    map-underscore-to-camel-case: true

logging:
  level:
    com.hospital.user.mapper: debug

app:
  jwtSecret: Y2xpZW50X2tleV9zaG9ydF9zZWNyZXQ=
  jwtExpirationInMs: 86400000
"@

Invoke-WebRequest -Uri "http://localhost:8848/nacos/v1/cs/configs?dataId=hospital-user.yml&group=DEFAULT_GROUP&content=$userConfig" -Method POST