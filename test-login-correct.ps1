# 测试用户服务登录接口
try {
    $body = @{
        username = "admin"
        password = "123456"
    } | ConvertTo-Json

    Write-Host "测试用户服务直接登录..."
    $response = Invoke-RestMethod -Uri "http://localhost:8081/api/auth/login" -Method POST -ContentType "application/json" -Body $body
    Write-Host "登录成功!"
    Write-Host "响应:" $response
} catch {
    Write-Host "登录失败: $($_.Exception.Message)"
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $reader.BaseStream.Position = 0
        $reader.DiscardBufferedData()
        $responseBody = $reader.ReadToEnd()
        Write-Host "错误响应:" $responseBody
    }
}