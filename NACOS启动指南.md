# Nacos服务器启动指南

## 1. 下载Nacos服务器
1. 访问Nacos官方下载地址：https://github.com/alibaba/nacos/releases
2. 选择合适的版本（建议2.1.2+），下载zip或tar.gz文件
3. 解压到本地目录，例如：`D:\nacos`

## 2. 启动Nacos服务器
### Windows系统
1. 打开命令提示符（CMD）或PowerShell
2. 进入Nacos的bin目录：`cd D:\nacos\bin`
3. 执行启动命令：
   ```
   startup.cmd -m standalone
   ```
   > 注意：`-m standalone`表示以单机模式启动，适合开发环境

### Linux/Mac系统
1. 打开终端
2. 进入Nacos的bin目录：`cd /path/to/nacos/bin`
3. 执行启动命令：
   ```
   sh startup.sh -m standalone
   ```

## 3. 验证Nacos服务器是否启动成功
1. 打开浏览器，访问：http://localhost:8848/nacos
2. 输入默认用户名和密码：nacos/nacos
3. 若能成功登录Nacos控制台，则表示服务器启动成功

## 4. 配置Nacos服务器
### 端口配置
如果需要修改Nacos服务器的默认端口（8848）：
1. 进入Nacos的conf目录：`D:\nacos\conf`
2. 编辑`application.properties`文件
3. 修改以下配置项：
   ```properties
   server.port=你的自定义端口
   ```
4. 保存文件并重启Nacos服务器

### 数据库配置（可选）
默认情况下，Nacos使用嵌入式数据库。若要使用外部MySQL数据库：
1. 进入Nacos的conf目录
2. 编辑`application.properties`文件
3. 取消注释并修改以下配置项：
   ```properties
   spring.datasource.platform=mysql
   db.num=1
   db.url.0=jdbc:mysql://localhost:3306/nacos?characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true&useUnicode=true&useSSL=false&serverTimezone=UTC
   db.user.0=root
   db.password.0=你的数据库密码
   ```
4. 执行`conf/nacos-mysql.sql`脚本创建数据库表
5. 保存文件并重启Nacos服务器

## 5. 关闭Nacos服务器
### Windows系统
在Nacos的bin目录下执行：
```
shutdown.cmd
```

### Linux/Mac系统
在Nacos的bin目录下执行：
```
sh shutdown.sh
```

## 6. 常见问题
### 端口冲突
- 错误信息：`Address already in use: bind`
- 解决方法：修改Nacos服务器的端口配置（见第4节）

### 数据库连接失败
- 错误信息：`Could not create connection to database server`
- 解决方法：检查MySQL服务是否启动，数据库配置是否正确

### 访问控制台失败
- 错误信息：`无法访问此网站`
- 解决方法：检查Nacos服务器是否启动，端口是否正确

## 7. 项目模块配置修改
如果修改了Nacos服务器的端口，需要同步修改项目中各模块的配置文件：
1. 找到各模块的`application.yml`或`bootstrap.yml`文件
2. 修改`spring.cloud.nacos.discovery.server-addr`和`spring.cloud.nacos.config.server-addr`配置项
3. 保存文件并重启模块

完成以上步骤后，你可以按照《医院信息化系统启动指南》中的顺序启动项目各模块。