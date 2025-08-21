@echo off

REM ==============================================
REM Nacos服务器和项目服务启动脚本
REM ==============================================

SET NACOS_HOME=D:\nacos\bin
SET PROJECT_HOME=D:\github项目\Hospital_server

REM 检查Nacos服务器是否已启动
echo 检查Nacos服务器状态...
netstat -ano | findstr :8848
if %ERRORLEVEL% EQU 0 (
    echo Nacos服务器已在端口8848运行
) else (
    echo Nacos服务器未运行，正在启动...
    start "Nacos Server" cmd /k "cd %NACOS_HOME% && startup.cmd -m standalone"
    echo 等待Nacos服务器启动...
    timeout /t 10 /nobreak >nul
)

REM 验证Nacos服务器是否可访问
echo 验证Nacos服务器连接...
curl -s http://localhost:8848/nacos/v1/console/health/readiness
if %ERRORLEVEL% EQU 0 (
    echo Nacos服务器连接成功
) else (
    echo Nacos服务器连接失败，请检查Nacos安装和启动情况
    pause
    exit /b 1
)

REM 启动项目服务
REM 注意：请按照正确顺序启动服务: registry -> config -> gateway -> user -> 其他业务服务

REM 启动hospital-registry服务
start "hospital-registry" cmd /k "cd %PROJECT_HOME%\hospital-registry && mvn spring-boot:run"

echo 等待hospital-registry服务启动...
timeout /t 15 /nobreak >nul

REM 启动hospital-config服务
start "hospital-config" cmd /k "cd %PROJECT_HOME%\hospital-config && mvn spring-boot:run"

echo 等待hospital-config服务启动...
timeout /t 10 /nobreak >nul

REM 启动hospital-gateway服务
start "hospital-gateway" cmd /k "cd %PROJECT_HOME%\hospital-gateway && mvn spring-boot:run"

echo 等待hospital-gateway服务启动...
timeout /t 10 /nobreak >nul

REM 启动hospital-user服务
start "hospital-user" cmd /k "cd %PROJECT_HOME%\hospital-user && mvn spring-boot:run"

REM 显示服务启动完成信息
echo 所有服务启动命令已执行，请检查各窗口的启动状态

echo 验证服务是否注册到Nacos:
 echo 1. 打开浏览器访问: http://localhost:8848/nacos
 echo 2. 登录(用户名/密码: nacos/nacos)
 echo 3. 在左侧菜单选择"服务管理"->"服务列表"
 echo 4. 检查服务是否已注册

pause