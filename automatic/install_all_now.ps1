cd $PSScriptRoot
Get-ChildItem -Recurse -Filter update.ps1 | % {
    cd $_.DirectoryName
    Write-Host "Updating package $($_.Name)" -ForegroundColor Yellow
    &".\$($_.Name)"

    Write-Host "Now Installing all package in current folder" -ForegroundColor Yellow
    Get-ChildItem -Filter *.nupkg | % {
       choco.exe install --allow-downgrade -fdvy ".\$($_.Name)"    
    }
}