@echo off

REM ==============================================
REM Nacos Server and Project Services Startup Script
REM ==============================================

SET NACOS_HOME=D:\software\nacos\nacos\bin
SET PROJECT_HOME=D:\github项目\Hospital_server

REM Check if Nacos server is already running
echo Checking Nacos server status...
netstat -ano | findstr :8848
if %ERRORLEVEL% EQU 0 (
    echo Nacos server is already running on port 8848
) else (
    echo Nacos server is not running, starting...
    start "Nacos Server" cmd /k "cd %NACOS_HOME% && startup.cmd -m standalone"
    echo Waiting for Nacos server to start...
    timeout /t 10 /nobreak >nul
)

REM Verify Nacos server connectivity
echo Verifying Nacos server connection...
curl -s http://localhost:8848/nacos/v1/console/health/readiness
if %ERRORLEVEL% EQU 0 (
    echo Nacos server connection successful
) else (
    echo Nacos server connection failed, please check Nacos installation and startup
    pause
    exit /b 1
)

REM Start project services
REM Note: Please start services in the correct order: registry -> config -> gateway -> user -> other business services

REM Start hospital-registry service
start "hospital-registry" cmd /k "cd %PROJECT_HOME%\hospital-registry && mvn spring-boot:run"

echo Waiting for hospital-registry service to start...
timeout /t 15 /nobreak >nul

REM Start hospital-config service
start "hospital-config" cmd /k "cd %PROJECT_HOME%\hospital-config && mvn spring-boot:run"

echo Waiting for hospital-config service to start...
timeout /t 10 /nobreak >nul

REM Start hospital-gateway service
start "hospital-gateway" cmd /k "cd %PROJECT_HOME%\hospital-gateway && mvn spring-boot:run"

echo Waiting for hospital-gateway service to start...
timeout /t 10 /nobreak >nul

REM Start hospital-user service
start "hospital-user" cmd /k "cd %PROJECT_HOME%\hospital-user && mvn spring-boot:run"

echo Waiting for hospital-user service to start...
timeout /t 10 /nobreak >nul

REM Start hospital-patient service
start "hospital-patient" cmd /k "cd %PROJECT_HOME%\hospital-patient && mvn spring-boot:run"

echo Waiting for hospital-patient service to start...
timeout /t 10 /nobreak >nul

REM Start hospital-registration service
start "hospital-registration" cmd /k "cd %PROJECT_HOME%\hospital-registration && mvn spring-boot:run"

echo Waiting for hospital-registration service to start...
timeout /t 10 /nobreak >nul

REM Display service startup completion message
echo All service startup commands have been executed, please check the startup status in each window

echo To verify services are registered in Nacos:
echo 1. Open browser and visit: http://localhost:8848/nacos
echo 2. Login (username/password: nacos/nacos)
echo 3. Select "Service Management" -> "Service List" in the left menu
echo 4. Check if services are registered

pause