# Check if Chocolatey is installed, and install if not
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey not found, installing..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; 
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Update Chocolatey to make sure it's the latest version
choco upgrade chocolatey -y

# Install Google Chrome
choco install googlechrome -y

# Install Notepad++
choco install notepadplusplus.install -y

# Install Visual Studio Code
choco install vscode -y

# Install 7zip (popular file compression tool)
choco install 7zip.install -y

# Install VLC Media Player (for media playback)
choco install vlc -y

# Install Firefox (for an alternative browser)
choco install firefox -y

# Install Node.js (for JavaScript/TypeScript development)
choco install nodejs-lts -y

# Install LibreOffice (for office productivity suite)
choco install libreoffice-fresh -y

# Optionally, you can clear the cache after installations to save space
choco clean -y

Write-Host "All applications have been installed"
