$links = @{
    bepInEx = 'https://github.com/BepInEx/BepInEx/releases/download/v5.4.19/BepInEx_x64_5.4.19.0.zip'
    kino = 'https://github.com/trbflxr/kino/releases/download/v3.6.0/release_360.zip'
}

$directory = Read-Host 'Enter CarX Drift Racing Online directory'

# Validate directory
while (-not (Test-Path $directory)) {
    Write-Host 'Invalid directory' -ForegroundColor Red
    $directory = Read-Host 'Please enter a valid directory'
}

Set-Location -Path $directory

# Download files
Start-BitsTransfer -Source $links.bepInEx, $links.kino -Destination .\BepInEx_x64_5.4.19.0.zip, .\release_360.zip

# Extract files
Expand-Archive -Path BepInEx_x64_5.4.19.0.zip -DestinationPath BepInEx_x64_5.4.19.0
Expand-Archive -Path release_360.zip -DestinationPath release_360

# Move files
Move-Item -Path .\BepInEx_x64_5.4.19.0\* -Destination .
New-Item -Path .\BepInEx -Name 'plugins' -ItemType 'directory'
Move-Item -Path .\release_360\* -Destination .\BepInEx\plugins

# Cleanup
Remove-Item -Path .\BepInEx_x64_5.4.19.0, .\BepInEx_x64_5.4.19.0.zip, .\release_360, .\release_360.zip -Recurse
Remove-Item -Path .\changelog.txt
