function Write-LabsLogs {
    param (
        [string]$message
    )
    
    $logFile = "C:\Labs\Install.log"
    $currentDateTime = Get-Date -Format "MM-dd-yy-THH:mm:ss"
    $logMessage = "$currentDateTime - Log: $Message"
    Add-Content -Path $logFile -Value $logMessage
}


# Check if Chocolatey is installed, and install if not
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey not found, installing..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; 
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Update Chocolatey to make sure it's the latest version
choco upgrade chocolatey -y 2>&1  # Capturing standard and error output
$chocoOutput | ForEach-Object { Write-LabsLogs $_ }

# Install Google Chrome
choco install googlechrome -y 2>&1  # Capturing standard and error output
$chocoOutput | ForEach-Object { Write-LabsLogs $_ }

# Install Notepad++
choco install notepadplusplus.install -y 2>&1  # Capturing standard and error output
$chocoOutput | ForEach-Object { Write-LabsLogs $_ }

# Install Visual Studio Code
choco install vscode -y 2>&1  # Capturing standard and error output
$chocoOutput | ForEach-Object { Write-LabsLogs $_ }

# Install 7zip (popular file compression tool)
choco install 7zip.install -y 2>&1  # Capturing standard and error output
$chocoOutput | ForEach-Object { Write-LabsLogs $_ }

# Install VLC Media Player (for media playback)
choco install vlc -y 2>&1  # Capturing standard and error output
$chocoOutput | ForEach-Object { Write-LabsLogs $_ }

# Install Firefox (for an alternative browser)
choco install firefox -y 2>&1  # Capturing standard and error output
$chocoOutput | ForEach-Object { Write-LabsLogs $_ }

# Install Node.js (for JavaScript/TypeScript development)
choco install nodejs-lts -y 2>&1  # Capturing standard and error output
$chocoOutput | ForEach-Object { Write-LabsLogs $_ }

# Install LibreOffice (for office productivity suite)
choco install libreoffice-fresh -y 2>&1  # Capturing standard and error output
$chocoOutput | ForEach-Object { Write-LabsLogs $_ }

# Optionally, you can clear the cache after installations to save space
choco clean -y 2>&1  # Capturing standard and error output
$chocoOutput | ForEach-Object { Write-LabsLogs $_ }

Write-Host "All applications have been installed"
