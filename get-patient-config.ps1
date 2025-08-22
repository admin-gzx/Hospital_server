$response = Invoke-WebRequest -Uri "http://localhost:8848/nacos/v1/cs/configs?dataId=hospital-patient.yml&group=DEFAULT_GROUP" -Method GET
Write-Output $response.Content