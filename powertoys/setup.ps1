$dotfilesPath = "$env:USERPROFILE\dotfiles"
$powertoysBackupPath = "$env:USERPROFILE\Documents\PowerToys\Backup"
$settingsFilename = "settings_999999999999999999.ptb"
$settingsFile = "$dotfilesPath\powertoys\$settingsFilename"

# Check if the settings file exists and symlink it to the PowerToys backup folder
if (Test-Path $settingsFile) {
    # Remove existing symlink if it exists
    if (Test-Path "$powertoysBackupPath\$settingsFilename") {
        Write-Host "Removing existing symlink..."
        Remove-Item "$powertoysBackupPath\$settingsFilename"
    }
    
    # Create the symlink
    New-Item -ItemType SymbolicLink -Path "$powertoysBackupPath\$settingsFilename" -Target $settingsFile
    Write-Host "Symlink created successfully for PowerToys settings!"

    # Launch PowerToys application
    Write-Host "Launching PowerToys..."
    Start-Process "C:\Program Files\PowerToys\PowerToys.exe"

    # Remind to restore settings with color
    Write-Host "Remember to click the 'Restore' button under 'Back up & restore' in PowerToys > General, to apply the settings backup." -ForegroundColor Yellow
} else {
    Write-Host "Settings file not found at $settingsFile. Please ensure the file is in the correct location."
}


Write-Host "Press Enter to exit"
Read-Host
