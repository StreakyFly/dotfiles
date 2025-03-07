$dotfilesPath = "$env:USERPROFILE\dotfiles"

# Check if the symlink already exists and remove it if it does
if (Test-Path "$env:USERPROFILE\.ideavimrc") {
    Write-Host "Removing existing symlink..."
    Remove-Item "$env:USERPROFILE\.ideavimrc"
}

# Create the symlink
try {
    New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.ideavimrc" -Target "$dotfilesPath\ideavim\.ideavimrc"
    Write-Host "Symlink created successfully! (unless you see big red errors...)"
} catch {
    Write-Host "Error creating symlink: $_"
}


Write-Host "Press Enter to exit"
Read-Host
