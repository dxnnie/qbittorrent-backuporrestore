# Define base paths
$userProfile = "C:\Users\danni"
$desktopPath = "E:\Daniel\OneDrive\Desktop"
$localAppPath = Join-Path $userProfile "AppData\Local\qBittorrent"
$roamingAppPath = Join-Path $userProfile "AppData\Roaming\qBittorrent"

# Get current date in yyyy-mm-dd format
$currentDate = (Get-Date).ToString("yyyy-MM-dd")

# Define ZIP file paths with date
$localZip = Join-Path $desktopPath "$currentDate-localqbittorrent.zip"
$roamingZip = Join-Path $desktopPath "$currentDate-roamingqbittorrent.zip"

# Function to backup directories
function Backup-Directories {
    Write-Host "Backing up $localAppPath to $localZip..."
    Compress-Archive -Path $localAppPath -DestinationPath $localZip -Force

    Write-Host "Backing up $roamingAppPath to $roamingZip..."
    Compress-Archive -Path $roamingAppPath -DestinationPath $roamingZip -Force

    Write-Host "Backup completed successfully. ZIP files have been copied to the Desktop."
}

# Function to restore directories
function Restore-Directories {
    Write-Host "Restoring from $localZip to $localAppPath..."
    if (Test-Path $localAppPath) {
        Remove-Item -Recurse -Force $localAppPath -ErrorAction Stop
    }
    Expand-Archive -Path $localZip -DestinationPath (Split-Path $localAppPath) -Force

    Write-Host "Restoring from $roamingZip to $roamingAppPath..."
    if (Test-Path $roamingAppPath) {
        Remove-Item -Recurse -Force $roamingAppPath -ErrorAction Stop
    }
    Expand-Archive -Path $roamingZip -DestinationPath (Split-Path $roamingAppPath) -Force

    Write-Host "Restoration completed successfully."

    # Launch qBittorrent after restoration
    $qbittorrentPath = "C:\Program Files\qBittorrent\qbittorrent.exe"
    if (Test-Path $qbittorrentPath) {
        Start-Process $qbittorrentPath
        Write-Host "qBittorrent has been launched."
    } else {
        Write-Host "qBittorrent executable not found."
    }
}

# Main script logic
$process = Get-Process -Name "qbittorrent" -ErrorAction SilentlyContinue

if ($process) {
    Write-Host "'qbittorrent.exe' is running."
    $response = Read-Host "Do you want to close the process? (Y/N)"
    
    if ($response -eq "Y") {
        Stop-Process -Name "qbittorrent" -Force
        Write-Host "Process terminated."
    } else {
        Write-Host "The script will exit as the process is running."
        exit
    }
} else {
    Write-Host "'qbittorrent.exe' is not running."
}

# Offer to backup or restore
$action = Read-Host "Do you want to (B)ackup or (R)estore the qBittorrent settings?"

switch ($action.ToUpper()) {
    "B" { Backup-Directories }
    "R" { Restore-Directories }
    default { Write-Host "Invalid option. The script will exit."; exit }
}
