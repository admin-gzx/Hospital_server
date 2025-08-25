# 测试登录接口的PowerShell脚本

# 测试用户服务直接登录
Write-Host "测试用户服务直接登录..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri 'http://localhost:8081/api/auth/login' -Method POST -ContentType 'application/json' -Body '{"username":"admin","password":"123456"}'
    Write-Host "登录成功！" -ForegroundColor Green
    Write-Host "Token: $($response.token)"
} catch {
    Write-Host "用户服务登录失败: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "状态码: $($_.Exception.Response.StatusCode.value__)"
}

# 测试通过网关登录
Write-Host "`n测试通过网关登录..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri 'http://localhost:8080/api/auth/login' -Method POST -ContentType 'application/json' -Body '{"username":"admin","password":"123456"}'
    Write-Host "网关登录成功！" -ForegroundColor Green
    Write-Host "Token: $($response.token)"
} catch {
    Write-Host "网关登录失败: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "状态码: $($_.Exception.Response.StatusCode.value__)"
}

# 测试健康检查
Write-Host "`n测试用户服务健康检查..." -ForegroundColor Yellow
try {
    $health = Invoke-RestMethod -Uri 'http://localhost:8081/actuator/health'
    Write-Host "用户服务健康状态: $($health.status)" -ForegroundColor Green
} catch {
    Write-Host "健康检查失败: $($_.Exception.Message)" -ForegroundColor Red
}