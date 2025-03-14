param(
    [string]$registrationToken
)

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



Install-WindowsFeature -Name RDS-RD-Server

$uris = @(
    "https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv"
    "https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrxrH"
)

$installers = @()
foreach ($uri in $uris) {
    $download = Invoke-WebRequest -Uri $uri -UseBasicParsing

$fileName = ($download.Headers.'Content-Disposition').Split('=')[1].Replace('"','')
    $output = [System.IO.FileStream]::new("$pwd\$fileName", [System.IO.FileMode]::Create)
    $output.write($download.Content, 0, $download.RawContentLength)
    $output.close()
    $installers += $output.Name
}

foreach ($installer in $installers) {
    Unblock-File -Path "$installer"
}

msiexec /i Microsoft.RDInfra.RDAgent.Installer-x64-1.0.9103.3700.msi /quiet REGISTRATIONTOKEN=$registrationToken

msiexec /i Microsoft.RDInfra.RDAgentBootLoader.Installer-x64.msi /quiet

# 3-13-2025
# Microsoft.RDInfra.RDAgent.Installer-x64-1.0.9103.3700.msi