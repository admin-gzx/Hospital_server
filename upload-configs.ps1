# Upload hospital-patient.yml to Nacos
$patientConfig = @"
server:
  port: 8082

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/hospital_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai
    username: root
    password: root
    driver-class-name: com.mysql.cj.jdbc.Driver
  redis:
    host: localhost
    port: 6379
    database: 0

mybatis-plus:
  mapper-locations: classpath*:/mapper/**/*.xml
  type-aliases-package: com.hospital.patient.entity
  configuration:
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl

logging:
  level:
    com.hospital.patient.mapper: debug
"@

Invoke-WebRequest -Uri "http://localhost:8848/nacos/v1/cs/configs?dataId=hospital-patient.yml&group=DEFAULT_GROUP&content=$patientConfig" -Method POST

# Upload hospital-registration.yml to Nacos
$registrationConfig = @"
server:
  port: 8083

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/hospital_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai
    username: root
    password: root
    driver-class-name: com.mysql.cj.jdbc.Driver
  redis:
    host: localhost
    port: 6379
    database: 0

mybatis-plus:
  mapper-locations: classpath*:/mapper/**/*.xml
  type-aliases-package: com.hospital.registration.entity
  configuration:
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl

logging:
  level:
    com.hospital.registration.mapper: debug
"@

Invoke-WebRequest -Uri "http://localhost:8848/nacos/v1/cs/configs?dataId=hospital-registration.yml&group=DEFAULT_GROUP&content=$registrationConfig" -Method POST