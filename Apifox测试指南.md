# 医院信息化系统 - Apifox 测试配置指南
# Hospital Information System - Apifox Testing Guide

## 📋 接口基本信息
**项目名称**: 医院信息化系统用户登录
**基础URL**: 
- 直接访问用户服务: `http://localhost:8081`
- 通过API网关: `http://localhost:8080`

## 🔧 Apifox 详细配置

### 1. 创建环境变量
在Apifox中创建以下环境变量：

```
变量名: base_url_user
变量值: http://localhost:8081

变量名: base_url_gateway  
变量值: http://localhost:8080

变量名: access_token
变量值: (测试时自动获取)
```

### 2. 登录接口配置

#### 接口基本信息
- **接口名称**: 用户登录
- **请求方法**: POST
- **接口URL**: `{{base_url_user}}/api/auth/login`
- **接口描述**: 医院信息化系统用户登录认证

#### 请求配置

**请求头 (Headers)**:
```
Content-Type: application/json
Accept: application/json
```

**请求体 (Body)** - 选择 JSON 格式:
```json
{
  "username": "admin",
  "password": "123456"
}
```

#### 响应示例

**成功响应 (200 OK)**:
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTY5ODc0NzI0MCwiZXhwIjoxNjk4ODMzNjQwfQ.example_token",
  "type": "Bearer"
}
```

**失败响应 (401 Unauthorized)**:
```json
{
  "timestamp": "2025-08-28T13:00:00",
  "status": 401,
  "error": "Unauthorized", 
  "message": "Bad credentials",
  "path": "/api/auth/login"
}
```

### 3. 测试脚本配置

#### 前置脚本 (Pre-request Script)
```javascript
// 设置请求时间戳
pm.globals.set("request_timestamp", new Date().toISOString());
console.log("开始登录测试: " + pm.globals.get("request_timestamp"));

// 清除之前的token
pm.environment.unset("access_token");
```

#### 后置脚本 (Tests)
```javascript
// 基本响应验证
pm.test("状态码为200", function () {
    pm.response.to.have.status(200);
});

pm.test("响应时间小于2000ms", function () {
    pm.expect(pm.response.responseTime).to.be.below(2000);
});

pm.test("响应包含必要字段", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData).to.have.property('token');
    pm.expect(jsonData).to.have.property('type');
});

pm.test("Token类型为Bearer", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.type).to.eql('Bearer');
});

pm.test("Token格式验证", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData.token).to.be.a('string');
    pm.expect(jsonData.token.length).to.be.above(50); // JWT通常很长
    pm.expect(jsonData.token).to.match(/^[\w-]+\.[\w-]+\.[\w-]+$/); // JWT格式
});

// 成功时保存token
if (pm.response.code === 200) {
    var jsonData = pm.response.json();
    pm.environment.set("access_token", jsonData.token);
    console.log("Token已保存到环境变量");
    console.log("Token预览: " + jsonData.token.substring(0, 20) + "...");
}

// 记录测试结果
pm.test("登录功能测试完成", function () {
    console.log("测试完成时间: " + new Date().toISOString());
});
```

### 4. 测试用例集合

#### 用例1: 正常登录
```json
{
  "username": "admin",
  "password": "123456"
}
```

#### 用例2: 错误密码
```json
{
  "username": "admin", 
  "password": "wrongpassword"
}
```
**预期**: 401状态码

#### 用例3: 不存在的用户
```json
{
  "username": "nonexistuser",
  "password": "123456"
}
```
**预期**: 401状态码

#### 用例4: 空用户名
```json
{
  "username": "",
  "password": "123456"
}
```
**预期**: 400或401状态码

#### 用例5: 空密码
```json
{
  "username": "admin",
  "password": ""
}
```
**预期**: 400或401状态码

### 5. 通过网关测试

创建另一个接口用于测试网关路由：
- **接口URL**: `{{base_url_gateway}}/api/auth/login`
- 其他配置与直接访问相同

### 6. 受保护接口测试

创建需要认证的接口测试：

#### 接口配置
- **接口名称**: 获取用户信息
- **请求方法**: GET  
- **接口URL**: `{{base_url_user}}/api/user/current`

#### 请求头
```
Authorization: Bearer {{access_token}}
Content-Type: application/json
```

#### 测试脚本
```javascript
pm.test("认证成功", function () {
    pm.response.to.have.status(200);
});

pm.test("返回用户信息", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData).to.have.property('username');
});
```

## 🚀 执行测试

### 手动测试步骤
1. 确保服务已启动 (Nacos, MySQL, Redis, 用户服务)
2. 在Apifox中导入上述配置
3. 执行登录接口测试
4. 检查响应和token保存
5. 使用token测试受保护接口

### 自动化测试
1. 创建测试集合包含所有测试用例
2. 设置测试数据和环境变量
3. 配置测试流程 (登录 → 获取token → 测试受保护接口)
4. 运行完整测试套件

## 🔍 故障排除

### 常见错误及解决方案

**403 Forbidden**:
- 检查Spring Security配置
- 确认CSRF是否正确处理
- 验证请求头格式

**503 Service Unavailable**:
- 检查数据库连接
- 确认Redis服务状态
- 查看应用启动日志

**401 Unauthorized**:
- 验证用户名密码正确性
- 检查数据库中用户数据
- 确认密码加密方式匹配

**连接超时**:
- 确认服务端口正确
- 检查防火墙设置
- 验证服务运行状态

## 📊 测试报告模板

测试完成后应包含以下信息：
- 测试环境信息
- 执行的测试用例
- 成功/失败统计
- 性能数据 (响应时间)
- 发现的问题和建议

---
**注意**: 测试前请确保所有依赖服务 (MySQL, Redis, Nacos) 都已正常启动。