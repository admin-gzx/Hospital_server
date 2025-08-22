# Test user module API interfaces (with authentication)

# Set base URLs
$baseUrl = "http://localhost:8080/api/user"
$authUrl = "http://localhost:8080/api/auth/login"

Write-Host "Testing user module API interfaces (with authentication)" -ForegroundColor Green

# 1. User login to get token
Write-Host "1. User login to get token:" -ForegroundColor Yellow
try {
    $loginBody = @{
        username = "admin"
        password = "admin"
    } | ConvertTo-Json
    
    $loginResponse = Invoke-WebRequest -Uri $authUrl -Method POST -Body $loginBody -ContentType "application/json"
    Write-Host "Login status code: $($loginResponse.StatusCode)" -ForegroundColor Cyan
    
    $loginContent = $loginResponse.Content | ConvertFrom-Json
    $token = $loginContent.token
    Write-Host "Obtained token: $token" -ForegroundColor White
    
    # Set authorization header
    $headers = @{
        Authorization = "Bearer $token"
    }
    
    # 2. Get all users
    Write-Host "2. Get all users:" -ForegroundColor Yellow
    $response = Invoke-WebRequest -Uri "$baseUrl" -Method GET -Headers $headers
    Write-Host "Status code: $($response.StatusCode)" -ForegroundColor Cyan
    Write-Host "Response content: $($response.Content)" -ForegroundColor White
    
    # 3. Get user by ID (assuming ID is 1)
    Write-Host "3. Get user by ID (ID=1):" -ForegroundColor Yellow
    try {
        $response = Invoke-WebRequest -Uri "$baseUrl/1" -Method GET -Headers $headers
        Write-Host "Status code: $($response.StatusCode)" -ForegroundColor Cyan
        Write-Host "Response content: $($response.Content)" -ForegroundColor White
    } catch {
        Write-Host "Request failed: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # 4. Get user by username (username=admin)
    Write-Host "4. Get user by username (username=admin):" -ForegroundColor Yellow
    try {
        $response = Invoke-WebRequest -Uri "$baseUrl/username/admin" -Method GET -Headers $headers
        Write-Host "Status code: $($response.StatusCode)" -ForegroundColor Cyan
        Write-Host "Response content: $($response.Content)" -ForegroundColor White
    } catch {
        Write-Host "Request failed: $($_.Exception.Message)" -ForegroundColor Red
    }
} catch {
    Write-Host "Login failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Response content: $($_.Exception.Response.Content.ReadAsStringAsync().Result)" -ForegroundColor Red
}

Write-Host "API testing completed" -ForegroundColor Green