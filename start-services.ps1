# Hospital Information System Startup Script for PowerShell
# This script handles Chinese path names properly

Write-Host "============================================" -ForegroundColor Green
Write-Host "Hospital Information System Startup Script" -ForegroundColor Green  
Write-Host "============================================" -ForegroundColor Green
Write-Host ""

# Get current script directory (handles Chinese paths)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectHome = $ScriptDir
$NacosHome = "D:\software\nacos\nacos\bin"

Write-Host "Project Path: $ProjectHome" -ForegroundColor Cyan
Write-Host "Nacos Path: $NacosHome" -ForegroundColor Cyan
Write-Host ""

# Check if key paths exist
if (!(Test-Path $NacosHome)) {
    Write-Host "Error: Nacos installation not found at $NacosHome" -ForegroundColor Red
    Write-Host "Please install Nacos or modify the NacosHome variable in this script" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

if (!(Test-Path $ProjectHome)) {
    Write-Host "Error: Project directory not found at $ProjectHome" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if Nacos server is already running
Write-Host "Checking Nacos server status..." -ForegroundColor Yellow
$nacosRunning = Get-NetTCPConnection -LocalPort 8848 -ErrorAction SilentlyContinue
if ($nacosRunning) {
    Write-Host "Nacos server is already running on port 8848" -ForegroundColor Green
} else {
    Write-Host "Nacos server is not running, starting..." -ForegroundColor Yellow
    Start-Process -FilePath "cmd" -ArgumentList "/k", "cd /d `"$NacosHome`" && startup.cmd -m standalone" -WindowStyle Normal
    Write-Host "Waiting for Nacos server to start..." -ForegroundColor Yellow
    Start-Sleep -Seconds 15
}

# Verify Nacos server connectivity
Write-Host "Verifying Nacos server connection..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8848/nacos/v1/console/health/readiness" -UseBasicParsing -TimeoutSec 10
    Write-Host "Nacos server connection successful" -ForegroundColor Green
} catch {
    Write-Host "Nacos server connection failed, please check Nacos installation and startup" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "Starting microservices in correct order..." -ForegroundColor Yellow
Write-Host ""

# Function to start a service
function Start-Service($serviceName, $serviceDir) {
    $fullPath = Join-Path $ProjectHome $serviceDir
    if (Test-Path $fullPath) {
        Write-Host "Starting $serviceName service..." -ForegroundColor Cyan
        Start-Process -FilePath "cmd" -ArgumentList "/k", "cd /d `"$fullPath`" && mvn spring-boot:run" -WindowStyle Normal
        return $true
    } else {
        Write-Host "Warning: $serviceDir directory not found, skipping..." -ForegroundColor Yellow
        return $false
    }
}

# Start services in correct order
$services = @(
    @{Name="hospital-registry"; Dir="hospital-registry"; Wait=15},
    @{Name="hospital-config"; Dir="hospital-config"; Wait=12},
    @{Name="hospital-gateway"; Dir="hospital-gateway"; Wait=12},
    @{Name="hospital-user"; Dir="hospital-user"; Wait=12}
)

foreach ($service in $services) {
    if (Start-Service $service.Name $service.Dir) {
        Write-Host "Waiting $($service.Wait) seconds for $($service.Name) to start..." -ForegroundColor Gray
        Start-Sleep -Seconds $service.Wait
    }
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "All services have been started!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Please wait 1-2 minutes for all services to fully start up." -ForegroundColor Yellow
Write-Host ""
Write-Host "Service URLs:" -ForegroundColor Cyan
Write-Host "- Nacos Console: http://localhost:8848/nacos (nacos/nacos)" -ForegroundColor White
Write-Host "- API Gateway: http://localhost:8080" -ForegroundColor White
Write-Host "- User Service: http://localhost:8081" -ForegroundColor White
Write-Host "- Config Service: http://localhost:8888" -ForegroundColor White
Write-Host ""
Write-Host "To verify services are registered:" -ForegroundColor Cyan
Write-Host "1. Visit: http://localhost:8848/nacos" -ForegroundColor White
Write-Host "2. Login with: nacos/nacos" -ForegroundColor White
Write-Host "3. Go to Service Management -> Service List" -ForegroundColor White
Write-Host "4. Check if all services are listed" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter to continue"