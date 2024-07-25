$BackupLocationsFilePath="C:\Users\zahid\Desktop\Powershell Backup\Directories.txt"
$BackupLocations=Get-Content -Path $BackupLocationsFilePath

$StorageLocation= "C:\Users\Public"
$BackupName= "Backup# $(Get-Date -Format "yy-MM-dd hh-mm")"

foreach($Location in $BackupLocations){
    Write-Output "Backuping up $($Location)"
    if(-not (Test-Path "$StorageLocation\$BackupName"){
        New-Item -Path "$StorageLocation\$BackupName" -ItemType Directory
    }
    Get-ChildItem -Path $Location | Copy-Item "$StorageLocation\$BackupName" Container -Recurse
}
