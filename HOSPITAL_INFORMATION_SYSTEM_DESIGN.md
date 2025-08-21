# 医院信息化系统设计文档

## 1. 项目概述

### 1.1 项目背景
随着医疗行业的不断发展，医院信息化建设已成为提升医疗服务质量、优化医疗流程、提高医院管理水平的重要手段。本项目旨在构建一个基于Spring Cloud的医院信息化系统，实现医院核心业务的数字化管理。

### 1.2 项目目标
- 实现医院核心业务的信息化管理
- 提供便捷的医疗服务体验
- 提高医院管理效率和决策水平
- 确保数据安全和隐私保护

### 1.3 技术栈
- **前端**：Vue.js/React
- **后端**：Spring Boot, Spring Cloud
- **数据库**：MySQL
- **缓存**：Redis
- **消息队列**：RabbitMQ/Kafka
- **服务注册与发现**：Eureka/Nacos
- **配置中心**：Spring Cloud Config/Nacos
- **API网关**：Spring Cloud Gateway
- **负载均衡**：Ribbon
- **熔断降级**：Hystrix/Sentinel
- **分布式事务**：Seata

## 2. 系统架构设计

### 2.1 总体架构
![系统架构图](https://example.com/system_architecture.png)（注：实际项目中应提供架构图）

### 2.2 微服务架构
系统采用微服务架构，主要包含以下服务：
- **认证授权服务(auth-service)**：负责用户认证、授权和会话管理
- **用户服务(user-service)**：管理医院工作人员信息
- **患者服务(patient-service)**：管理患者信息和病历
- **挂号服务(registration-service)**：处理挂号预约业务
- **诊疗服务(doctor-service)**：管理医生信息、排班和诊疗记录
- **药品服务(medicine-service)**：管理药品信息和药品库存
- **收费服务(billing-service)**：处理收费和账单业务
- **系统管理服务(system-service)**：处理系统配置和日志管理
- **API网关(gateway-service)**：提供API路由和过滤功能
- **服务注册与发现(registry-service)**：管理服务注册和发现
- **配置中心(config-service)**：管理配置信息

### 2.3 数据存储架构
- **关系型数据库**：MySQL用于存储结构化数据
- **缓存**：Redis用于缓存热点数据和会话信息
- **搜索引擎**：Elasticsearch用于日志和全文检索

## 3. 功能模块设计

### 3.1 用户认证与授权模块
- 用户登录/登出
- 角色管理（医生、护士、管理员等）
- 权限管理
- 会话管理

### 3.2 患者管理模块
- 患者信息登记与查询
- 电子病历管理
- 患者就诊记录查询
- 患者预约管理

### 3.3 挂号预约模块
- 科室信息查询
- 医生排班查询
- 挂号预约
- 预约取消与改签

### 3.4 医生管理模块
- 医生信息管理
- 医生排班管理
- 诊疗记录管理
- 处方管理

### 3.5 药品管理模块
- 药品信息管理
- 药品库存管理
- 药品采购管理
- 药品发放记录

### 3.6 收费管理模块
- 费用项目管理
- 收费记录管理
- 账单查询
- 医保结算接口

### 3.7 系统管理模块
- 数据字典管理
- 系统参数配置
- 日志管理
- 备份恢复管理

## 4. 数据库设计

### 4.1 主要数据表
- **用户表(sys_user)**
- **角色表(sys_role)**
- **权限表(sys_permission)**
- **用户角色关联表(sys_user_role)**
- **角色权限关联表(sys_role_permission)**
- **患者表(patient)**
- **病历表(medical_record)**
- **挂号记录表(registration)**
- **医生表(doctor)**
- **科室表(department)**
- **排班表(schedule)**
- **诊疗记录表(doctor_visit_record)**
- **处方表(prescription)**
- **药品表(medicine)**
- **药品库存表(medicine_inventory)**
- **收费项目表(charge_item)**
- **收费记录表(charge_record)**

### 4.2 核心表结构设计

#### 4.2.1 用户表(sys_user)
```sql
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `real_name` varchar(50) DEFAULT NULL COMMENT '真实姓名',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';
```

#### 4.2.2 患者表(patient)
```sql
CREATE TABLE `patient` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `patient_no` varchar(30) NOT NULL COMMENT '患者编号',
  `name` varchar(50) NOT NULL COMMENT '姓名',
  `gender` tinyint(4) DEFAULT NULL COMMENT '性别(1:男,2:女,0:未知)',
  `birth_date` date DEFAULT NULL COMMENT '出生日期',
  `id_card` varchar(20) DEFAULT NULL COMMENT '身份证号',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `blood_type` varchar(10) DEFAULT NULL COMMENT '血型',
  `allergies` varchar(255) DEFAULT NULL COMMENT '过敏史',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_patient_no` (`patient_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='患者表';
```

#### 4.2.3 医生表(doctor)
```sql
CREATE TABLE `doctor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `doctor_no` varchar(30) NOT NULL COMMENT '医生编号',
  `name` varchar(50) NOT NULL COMMENT '姓名',
  `gender` tinyint(4) DEFAULT NULL COMMENT '性别(1:男,2:女)',
  `birth_date` date DEFAULT NULL COMMENT '出生日期',
  `dept_id` bigint(20) NOT NULL COMMENT '科室ID',
  `title` varchar(50) DEFAULT NULL COMMENT '职称',
  `specialty` varchar(100) DEFAULT NULL COMMENT '专长',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_doctor_no` (`doctor_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='医生表';
```

#### 4.2.4 挂号记录表(registration)
```sql
CREATE TABLE `registration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `reg_no` varchar(30) NOT NULL COMMENT '挂号编号',
  `patient_id` bigint(20) NOT NULL COMMENT '患者ID',
  `dept_id` bigint(20) NOT NULL COMMENT '科室ID',
  `doctor_id` bigint(20) NOT NULL COMMENT '医生ID',
  `reg_date` date NOT NULL COMMENT '挂号日期',
  `reg_time` varchar(20) DEFAULT NULL COMMENT '挂号时间段',
  `reg_type` tinyint(4) DEFAULT NULL COMMENT '挂号类型(1:普通,2:专家)',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态(1:预约,2:已就诊,3:已取消)',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '挂号金额',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_reg_no` (`reg_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='挂号记录表';
```

#### 4.2.5 处方表(prescription)
```sql
CREATE TABLE `prescription` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `prescription_no` varchar(30) NOT NULL COMMENT '处方编号',
  `visit_id` bigint(20) NOT NULL COMMENT '就诊记录ID',
  `patient_id` bigint(20) NOT NULL COMMENT '患者ID',
  `doctor_id` bigint(20) NOT NULL COMMENT '医生ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态(1:未执行,2:已执行,3:已取消)',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '总金额',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_prescription_no` (`prescription_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='处方表';
```

## 5. API接口设计

### 5.1 接口规范
- 采用RESTful风格
- 请求/响应格式：JSON
- 身份认证：JWT
- 接口版本控制：URL路径中包含版本信息

### 5.2 核心API接口

#### 5.2.1 认证授权接口
- `POST /api/v1/auth/login` - 用户登录
- `POST /api/v1/auth/logout` - 用户登出
- `GET /api/v1/auth/user-info` - 获取当前用户信息

#### 5.2.2 患者管理接口
- `POST /api/v1/patients` - 创建患者
- `GET /api/v1/patients/{id}` - 获取患者详情
- `GET /api/v1/patients` - 分页查询患者列表
- `PUT /api/v1/patients/{id}` - 更新患者信息
- `GET /api/v1/patients/{id}/medical-records` - 获取患者病历

#### 5.2.3 挂号预约接口
- `POST /api/v1/registrations` - 创建挂号预约
- `GET /api/v1/registrations/{id}` - 获取挂号详情
- `GET /api/v1/registrations` - 分页查询挂号列表
- `PUT /api/v1/registrations/{id}/cancel` - 取消挂号
- `GET /api/v1/schedules/doctor/{doctorId}/date/{date}` - 查询医生某天排班

#### 5.2.4 医生管理接口
- `GET /api/v1/doctors` - 分页查询医生列表
- `GET /api/v1/doctors/{id}` - 获取医生详情
- `GET /api/v1/doctors/{id}/schedules` - 查询医生排班
- `GET /api/v1/departments` - 查询科室列表

#### 5.2.5 诊疗管理接口
- `POST /api/v1/visit-records` - 创建就诊记录
- `GET /api/v1/visit-records/{id}` - 获取就诊记录详情
- `POST /api/v1/prescriptions` - 创建处方
- `GET /api/v1/prescriptions/{id}` - 获取处方详情

#### 5.2.6 药品管理接口
- `GET /api/v1/medicines` - 分页查询药品列表
- `GET /api/v1/medicines/{id}` - 获取药品详情
- `GET /api/v1/medicines/inventory` - 查询药品库存

#### 5.2.7 收费管理接口
- `POST /api/v1/charge-records` - 创建收费记录
- `GET /api/v1/charge-records/{id}` - 获取收费记录详情
- `GET /api/v1/charge-records/patient/{patientId}` - 查询患者收费记录
- `POST /api/v1/charge-records/pay` - 支付费用

## 6. 技术实现要点

### 6.1 微服务通信
- 同步通信：使用FeignClient
- 异步通信：使用RabbitMQ/Kafka

### 6.2 服务治理
- 服务注册与发现：Nacos
- 配置中心：Nacos
- API网关：Spring Cloud Gateway
- 负载均衡：Ribbon
- 熔断降级：Sentinel

### 6.3 数据一致性
- 分布式事务：Seata
- 缓存一致性：采用失效模式和更新模式结合

### 6.4 安全机制
- 身份认证：JWT
- 权限控制：Spring Security
- 数据加密：敏感数据加密存储
- 防SQL注入、XSS攻击等

### 6.5 性能优化
- 缓存策略：Redis缓存热点数据
- 数据库索引优化
- 分页查询优化
- 异步处理：耗时操作异步化

## 7. 部署方案

### 7.1 开发环境
- 本地开发：Docker容器化
- 集成测试：Jenkins自动化构建

### 7.2 生产环境
- 服务器：Linux服务器
- 容器编排：Kubernetes
- 服务监控：Spring Boot Admin + Prometheus + Grafana
- 日志管理：ELK Stack

## 8. 项目实施计划

### 8.1 阶段划分
- 阶段一：需求分析与架构设计
- 阶段二：核心功能开发
- 阶段三：集成测试与优化
- 阶段四：部署上线与运维

### 8.2 里程碑
- 需求分析完成
- 架构设计完成
- 核心功能开发完成
- 系统测试完成
- 系统上线

## 9. 附录

### 9.1 术语表
- 电子病历(EMR)：Electronic Medical Record
- 医院信息系统(HIS)：Hospital Information System
- 临床信息系统(CIS)：Clinical Information System

### 9.2 参考资料
- 《医院信息系统建设规范》
- 《医疗行业数据安全标准》
- Spring Cloud官方文档
- MySQL官方文档
- Redis官方文档