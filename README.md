# 医院信息化系统

## 项目概述
这是一个基于Spring Cloud的医院信息化系统，采用前后端分离架构，实现医院核心业务的数字化管理。

## 技术栈
- **后端**：Spring Boot, Spring Cloud, Spring Security
- **数据库**：MySQL
- **缓存**：Redis
- **服务注册与发现**：Nacos
- **配置中心**：Nacos
- **API网关**：Spring Cloud Gateway
- **ORM框架**：MyBatis-Plus
- **消息队列**：RabbitMQ (后续可扩展)
- **分布式事务**：Seata (后续可扩展)
- **熔断降级**：Sentinel (后续可扩展)

## 项目结构
```
Hospital_server/
├── hospital-parent/           # 父项目
├── hospital-common/           # 通用模块
├── hospital-registry/         # 服务注册与发现
├── hospital-config/           # 配置中心
├── hospital-gateway/          # API网关
├── hospital-auth/             # 认证授权服务
├── hospital-user/             # 用户服务
├── hospital-patient/          # 患者服务
├── hospital-registration/     # 挂号服务
├── hospital-doctor/           # 医生服务
├── hospital-medicine/         # 药品服务
├── hospital-billing/          # 收费服务
├── hospital-system/           # 系统管理服务
└── README.md                  # 项目说明
```

## 核心模块说明

### 1. 服务注册与发现 (hospital-registry)
基于Nacos实现服务注册与发现，管理所有微服务实例。

### 2. 配置中心 (hospital-config)
基于Nacos实现配置中心，集中管理所有微服务的配置文件。

### 3. API网关 (hospital-gateway)
- 请求路由
- 负载均衡
- 认证授权
- 限流熔断
- 请求过滤

### 4. 通用模块 (hospital-common)
- 工具类
- 实体类
- 异常处理
- 全局配置

### 5. 业务服务
- **用户服务 (hospital-user)**：管理医院工作人员信息
- **患者服务 (hospital-patient)**：管理患者信息和病历
- **挂号服务 (hospital-registration)**：处理挂号预约业务
- **医生服务 (hospital-doctor)**：管理医生信息、排班和诊疗记录
- **药品服务 (hospital-medicine)**：管理药品信息和药品库存
- **收费服务 (hospital-billing)**：处理收费和账单业务
- **系统管理服务 (hospital-system)**：处理系统配置和日志管理

## 启动顺序
1. **hospital-registry** (端口: 8848)
2. **hospital-config** (端口: 8888)
3. **hospital-gateway** (端口: 8080)
4. 其他业务服务 (端口: 8081+)

## 数据库配置
1. 创建数据库 `hospital_db`
2. 导入初始化SQL脚本 (后续提供)

## 开发环境配置
1. 安装JDK 1.8+
2. 安装Maven 3.6+
3. 安装MySQL 8.0+
4. 安装Redis 6.0+
5. 安装Nacos 2.1.2+

## 部署说明
### 开发环境
- 直接运行各模块的Application类

### 生产环境
- 构建Docker镜像 (后续提供Dockerfile)
- 使用Kubernetes编排 (后续提供部署脚本)

## 接口文档
API接口文档将通过Swagger自动生成，访问地址：
- 网关聚合文档: http://localhost:8080/swagger-ui.html
- 各服务文档: http://localhost:{port}/swagger-ui.html

## 后续规划
1. 完善各业务模块功能
2. 实现分布式事务处理
3. 添加服务熔断和降级机制
4. 实现日志集中管理
5. 开发前端界面

## 联系方式
如有问题，请联系: 3105216868@qq.com

© 2025 医院信息化系统 版权所有