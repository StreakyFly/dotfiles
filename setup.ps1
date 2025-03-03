# Set the path for the dotfiles directory
$dotfilesPath = "$env:USERPROFILE\dotfiles"

# Check if the symlink already exists, remove it if it does
if (Test-Path "$env:USERPROFILE\.ideavimrc") {
    Remove-Item "$env:USERPROFILE\.ideavimrc"
}

# Create the symlink
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.ideavimrc" -Target "$dotfilesPath\.ideavimrc"

Write-Host "Symlink created successfully (unless you see errors...)!"

Read-Host -Prompt "Press Enter to exit"
