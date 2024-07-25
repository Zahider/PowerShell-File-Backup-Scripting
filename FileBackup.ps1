# Path to the file containing the list of directories to be backed up
$BackupLocationsFilePath = "C:\Users\zahid\Desktop\Powershell Backup\Directories.txt"

# Read the backup locations from the file
$BackupLocations = Get-Content -Path $BackupLocationsFilePath

# Location where backups will be stored
$StorageLocation = "C:\Users\Public"

# Name of the backup directory with a timestamp
$BackupName = "Project Backup $(Get-Date -Format "yy-MM-dd hh-mm")"

# Loop through each location in the backup locations
foreach ($Location in $BackupLocations) {
    # Output the location being backed up
    Write-Output "Backing up $($Location)"
    
    # Check if the backup directory does not exist, then create it
    if (-not (Test-Path "$StorageLocation\$BackupName")) {
        New-Item -Path "$StorageLocation\$BackupName" -ItemType Directory
    }
    
    # Copy all items from the current location to the backup directory, including subdirectories
    Get-ChildItem -Path $Location | Copy-Item -Destination "$StorageLocation\$BackupName" -Container -Recurse
}

# Compress the backup directory into a zip file
Compress-Archive -Path "$StorageLocation\$BackupName" -DestinationPath "$StorageLocation\$BackupName.zip" -CompressionLevel Fastest
