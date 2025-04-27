# qBittorrent Backup or Restore

This is a **PowerShell** script to **backup** or **restore** your qBittorrent settings, configuration, and torrents data easily.

## Features
- Backup qBittorrent configuration files.
- Restore qBittorrent settings from a backup.
- Simple and interactive PowerShell prompts.

## Usage

### Requirements
- Windows with PowerShell.
- qBittorrent installed.

### Download
You can download the latest script version directly:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/dxnnie/qbittorrent-backuporrestore/main/qBittorrent-BackuporRestore.ps1" -OutFile "qBittorrent-BackuporRestore.ps1"
```

### Running the Script
Run the script from PowerShell:

```powershell
.\qBittorrent-BackuporRestore.ps1
```

Follow the prompts to either **backup** or **restore** your qBittorrent data.

> ⚠️ **Important:**  
> Run PowerShell as **Administrator** to avoid permission issues.

## What It Backs Up
- `BT_backup` folder (torrents and resume data)
- `qBittorrent.ini` (settings)
- Other configuration files located under:
  - `%APPDATA%\qBittorrent\`
  - `%LOCALAPPDATA%\qBittorrent\` (if applicable)

## Notes
- Always close qBittorrent before running the script to prevent file conflicts.
- Ensure you have enough space when creating backups.

## License
This project is released under the [MIT License](LICENSE).
