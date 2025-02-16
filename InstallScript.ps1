function Write-LabsLogs {
    param (
        [string]$Message
    )
    
    $logFile = "C:\Labs\Install.log"
    $currentDateTime = Get-Date -Format "MM-dd-yy-THH:mm:ss"
    $logMessage = "$currentDateTime - Log: $Message"

    if (-not (Test-Path -Path $logFile)) {
        New-Item -Path $logFile -ItemType File -Force | Out-Null
    }

    Add-Content -Path $logFile -Value $logMessage
}

Write-LabsLogs "Installing chocolatey"
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-LabsLogs "Chocolatey not found, installing..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; 
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

if (Test-Path -Path "C:\ProgramData\chocolatey") {
    
    Write-LabsLogs "Installed chocolatey"
    $chocoSuccess = $true
}

if ($chocoSuccess) {
    
    # Install Notepad++
    Write-LabsLogs -Message "Starting Notepad++ installation..."
    choco install notepadplusplus.install --force -y 2>&1  # Capturing standard and error output
    $chocoOutput | ForEach-Object { Write-LabsLogs $_ }
    Write-LabsLogs -Message "Completed Notepad++ installation attempt..."

    Start-sleep -Seconds 10

    if (Test-Path -Path "C:\Program Files\Notepad++") {
        Write-LabsLogs -Message "Notepad++ detected at C:\Program Files\Notepad++..."
        Write-LabsLogs -Message "Notepad++ installed successfully..."
    }
}
Write-LabsLogs -Message "Exiting..."
exit 0