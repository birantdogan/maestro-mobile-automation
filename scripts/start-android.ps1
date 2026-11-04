
$ErrorActionPreference = "Stop"

$SdkPath = Join-Path $env:LOCALAPPDATA "Android\Sdk"
$AdbPath = Join-Path $SdkPath "platform-tools\adb.exe"
$EmulatorPath = Join-Path $SdkPath "emulator\emulator.exe"
$AvdName = "Medium_Phone_API_37.0"

if (-not (Test-Path $AdbPath) -or -not (Test-Path $EmulatorPath)) {
    Write-Error "Android SDK tools not found."
    exit 1
}

# Check whether the ADB server is already listening
$AdbListener = Get-NetTCPConnection -LocalPort 5037 -State Listen -ErrorAction SilentlyContinue |
    Where-Object { $_.LocalAddress -eq "0.0.0.0" }

if ($AdbListener) {
    Write-Host "ADB server is already running and accessible from WSL."
} else {
    Write-Host "Starting ADB server for WSL..."

    # Stop any existing ADB server using the wrong address
    & $AdbPath kill-server

    # Start ADB on all network interfaces
    & $AdbPath -a start-server

    Start-Sleep -Seconds 2

    # Verify that ADB is listening on the correct address
    $AdbListener = Get-NetTCPConnection -LocalPort 5037 -State Listen -ErrorAction SilentlyContinue |
        Where-Object { $_.LocalAddress -eq "0.0.0.0" }

    if (-not $AdbListener) {
        Write-Error "ADB failed to start on 0.0.0.0:5037."
        exit 1
    }
}

# Start emulator only if no emulator is connected
$Devices = & $AdbPath devices

if (-not ($Devices -match "emulator-\d+\s+device")) {
    Start-Process -FilePath $EmulatorPath `
        -ArgumentList "-avd", $AvdName `
        -WorkingDirectory (Split-Path $EmulatorPath -Parent) `
        -WindowStyle Hidden
    Write-Host "Android emulator starting..."
} else {
    Write-Host "Android emulator already running."
}

Write-Host "Windows Android environment started."

# Start WSL ADB forwarding
wsl.exe -d Ubuntu -- bash /home/biran/maestro-mobile-automation/scripts/start-adb-background.sh

# Verify ADB connectivity from WSL
$WslDevices = wsl.exe -d Ubuntu -- adb devices

if ($LASTEXITCODE -ne 0 -or -not ($WslDevices -match "emulator-\d+\s+device")) {
    Write-Error "WSL cannot access the Android emulator through ADB."
    exit 1
}

Write-Host "WSL ADB connection verified."
