# 测试用户模块API接口

# 设置基础URL
$baseUrl = "http://localhost:8080/api/user"

Write-Host "测试用户模块API接口" -ForegroundColor Green

# 1. 获取所有用户
Write-Host "1. 获取所有用户:" -ForegroundColor Yellow
$response = Invoke-WebRequest -Uri "$baseUrl" -Method GET
Write-Host "状态码: $($response.StatusCode)" -ForegroundColor Cyan
Write-Host "响应内容: $($response.Content)" -ForegroundColor White

# 2. 根据ID获取用户 (假设ID为1)
Write-Host "2. 根据ID获取用户 (ID=1):" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "$baseUrl/1" -Method GET
    Write-Host "状态码: $($response.StatusCode)" -ForegroundColor Cyan
    Write-Host "响应内容: $($response.Content)" -ForegroundColor White
} catch {
    Write-Host "请求失败: $($_.Exception.Message)" -ForegroundColor Red
}

# 3. 根据用户名获取用户 (假设用户名为admin)
Write-Host "3. 根据用户名获取用户 (username=admin):" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "$baseUrl/username/admin" -Method GET
    Write-Host "状态码: $($response.StatusCode)" -ForegroundColor Cyan
    Write-Host "响应内容: $($response.Content)" -ForegroundColor White
} catch {
    Write-Host "请求失败: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "API测试完成" -ForegroundColor Green