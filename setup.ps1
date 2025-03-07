Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "       setup.ps1, the Father of all setup.ps1s has arrived!      " -ForegroundColor Green
Write-Host "  Awakening the ancient dotfiles and summoning the config gods..." -ForegroundColor DarkGreen
Write-Host "            Prepare for a legendary setup experience!            " -ForegroundColor DarkGreen
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host ""
Write-Host ""

$dotfilesPath = "$env:USERPROFILE\dotfiles"

# Get all subdirectories in the dotfiles directory
$subDirectories = Get-ChildItem -Path $dotfilesPath -Directory

foreach ($dir in $subDirectories) {
    $setupScript = "$dir\setup.ps1"
    
    # Check if the setup.ps1 script exists in the directory
    if (Test-Path $setupScript) {
        Write-Host "Running setup for: $($dir.Name)" -ForegroundColor Cyan
        Write-Host ""
        
        # Read the script content as a single string
        $scriptContent = Get-Content $setupScript -Raw
        
        # Split into lines
        $scriptLines = $scriptContent -split "`n"

        # Remove trailing empty lines
        while($scriptLines.Count -gt 0 -and $scriptLines[-1].Trim() -eq ""){
            $scriptLines = $scriptLines[0..($scriptLines.Count - 2)]
        }
        
        # If there are at least two non-empty lines, check if they ask the user to press enter before ending the script - we don't want that for each script
        if ($scriptLines.Count -ge 2) {
            $lastLine = $scriptLines[-1].Trim()
            $secondLastLine = $scriptLines[-2].Trim()
            
            # Check if the second-to-last line contains Write-Host with "Press Enter" and the last line starts with Read-Host
            if (($secondLastLine -match 'Write-Host' -and $secondLastLine -match 'Press Enter') -and ($lastLine -match '^Read-Host')) {
                # Remove the last two lines
                $scriptLines = $scriptLines[0..($scriptLines.Count - 3)]
            }
        }
        
        # Reassemble the script and execute
        $modifiedScript = $scriptLines -join "`n"
        Invoke-Expression $modifiedScript

        Write-Host ""
        Write-Host "Did $($dir.Name)'s setup work? Who knows?" -ForegroundColor Magenta
        Write-Host ""
        Write-Host ""
        Write-Host ""
    }
    else {
        Write-Host "No setup.ps1 found in $($dir.Name), skipping..."
    }
}
Write-Host "All done, maybe?" -ForegroundColor DarkGreen
Write-Host "Some scripts were, like, 'Yeah, let's just wait for the human to do it.'" -ForegroundColor Green

Write-Host "Press Enter to exit"
Read-Host
