param (
    [string]$TargetPath = "$env:ProgramFiles\SharpNet"
)

# Get the base directory (directory of the script)
$baseDir = Split-Path -Parent $PSCommandPath

# Path to versions folder
$versionsDir = Join-Path $baseDir "versions"

# Create SharpNet directory in Program Files if it doesn't exist
if (-not (Test-Path $TargetPath)) {
    New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
    Write-Host "Created SharpNet directory at: $TargetPath"
}

# Check if versions directory exists
if (-not (Test-Path $versionsDir)) {
    Write-Error "Versions directory not found: $versionsDir"
    exit 1
}

# Get all subdirectories in versions that are numeric
$versionFolders = Get-ChildItem -Path $versionsDir -Directory | Where-Object { $_.Name -match '^\d+$' }

if ($versionFolders.Count -eq 0) {
    Write-Error "No version folders found."
    exit 1
}

# Find the latest version (highest number)
$latestVersion = ($versionFolders | Select-Object -ExpandProperty Name | Measure-Object -Maximum).Maximum
$latestVersionDir = Join-Path $versionsDir $latestVersion
$winDir = Join-Path $latestVersionDir "win"

if (-not (Test-Path $winDir)) {
    Write-Error "Win directory not found in latest version: $winDir"
    exit 1
}

# Copy all files from winDir to TargetPath
Get-ChildItem -Path $winDir -File | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $TargetPath -Force
    Write-Host "Copied: $($_.Name) to $TargetPath"
}

# Update system PATH to include SharpNet directory
$currentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
if ($currentPath -notlike "*$TargetPath*") {
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$TargetPath", [EnvironmentVariableTarget]::Machine)
    Write-Host "Added $TargetPath to system PATH"
}

Write-Host "Successfully deployed SharpNet version $latestVersion to $TargetPath"
Write-Host "You can now access the commands from cmd or PowerShell"