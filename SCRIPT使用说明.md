# Nacos服务器和项目服务启动脚本使用说明

## 脚本概述
`start-nacos-and-services.bat`是一个Windows批处理脚本，用于一键启动Nacos服务器和医院信息化系统的各个服务模块。脚本会按照正确的顺序启动服务，并提供简单的状态验证。

## 脚本功能
1. 检查Nacos服务器是否已启动
2. 如未启动，则自动启动Nacos服务器（单机模式）
3. 验证Nacos服务器连接状态
4. 按顺序启动项目服务：
   - hospital-registry（服务注册中心客户端）
   - hospital-config（配置中心）
   - hospital-gateway（网关）
   - hospital-user（用户服务）
5. 提供服务启动状态验证指南

## 使用方法
1. **前提条件**：
   - 已安装JDK 1.8+（推荐JDK 11）
   - 已安装Maven 3.6+并配置环境变量
   - 已下载并解压Nacos服务器（默认路径：`D:\nacos`）
   - 已安装curl命令行工具（Windows 10+ 内置，或从https://curl.se/download.html下载）

2. **修改脚本配置**（如需要）：
   - 如果Nacos安装路径不是`D:\nacos`，请修改脚本中的`NACOS_HOME`变量
   - 如果项目路径不是`D:\github项目\Hospital_server`，请修改脚本中的`PROJECT_HOME`变量

3. **运行脚本**：
   - 双击`start-nacos-and-services.bat`文件
   - 或在命令提示符中执行：`start-nacos-and-services.bat`

## 注意事项
1. 首次运行时，脚本会启动多个命令窗口，请不要关闭这些窗口
2. 脚本中的等待时间（timeout）可能需要根据您的系统性能进行调整
3. 如果Nacos服务器启动失败，请检查Nacos安装是否正确，端口是否被占用
4. 如果服务启动失败，请查看对应的命令窗口中的错误信息
5. 停止服务时，请依次关闭各个命令窗口
6. 如需修改Nacos端口，需同步修改：
   - Nacos安装目录下的`conf\application.properties`文件
   - 项目各模块中的`application.yml`或`bootstrap.yml`文件
   - 本脚本中的Nacos相关配置

## 常见问题排查
1. **Nacos服务器启动失败**
   - 检查端口8848是否被占用（可使用`netstat -ano | findstr :8848`命令）
   - 检查Nacos安装目录是否正确
   - 尝试手动启动Nacos：`cd D:\nacos\bin && startup.cmd -m standalone`

2. **服务注册失败**
   - 检查Nacos服务器是否正常运行
   - 检查项目中Nacos配置是否正确
   - 检查网络连接是否正常

3. **Maven命令无法执行**
   - 检查Maven是否已正确安装并配置环境变量
   - 尝试在命令行中执行`mvn -v`验证Maven安装

4. **服务启动缓慢**
   - 考虑增加脚本中的等待时间（例如：将`timeout /t 10`改为`timeout /t 15`）

## 服务验证
1. 打开浏览器访问Nacos控制台：http://localhost:8848/nacos
2. 使用默认用户名/密码登录：nacos/nacos
3. 在左侧菜单选择"服务管理"->"服务列表"
4. 确认所有服务（hospital-registry、hospital-config、hospital-gateway、hospital-user）都已注册

## 停止服务
1. 关闭所有由脚本启动的命令窗口
2. 如需停止Nacos服务器，在Nacos的bin目录执行：`shutdown.cmd`

如果您在使用过程中遇到其他问题，请参考项目文档或联系技术支持。