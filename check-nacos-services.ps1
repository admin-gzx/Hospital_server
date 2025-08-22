# Check services registered in Nacos
$response = Invoke-WebRequest -Uri "http://localhost:8848/nacos/v1/ns/service/list?pageNo=1&pageSize=20" -Method GET
Write-Output $response.Content