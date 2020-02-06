$packageName= 'winlogbeat'

Stop-Service $packageName
Start-Sleep -s 3

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$installationPath = $toolsDir

$uninstallScript = Join-Path $toolsDir "uninstall-service-$($packageName).ps1"
Invoke-Expression $uninstallScript

# Chocolatey seems to copy the old lib folder in case of upgrade. Uninstall first.
$zipContentGlob=Get-ChildItem "$($installationPath)/.." "$($packageName)-*.zip.txt"
$zipContentFile=$zipContentGlob.Name
$folder = ($zipContentFile -replace ".zip.txt","") + "\\"
if (($null -ne $zipContentGlob)) {
    $zipContentFile
    $zipContents=(get-content $zipContentGlob.FullName) -split [environment]::NewLine
    for ($i = $zipContents.Length; $i -gt 0; $i--) {
        $fileInZip = $zipContents[$i]
        if ($null -ne $fileInZip -and $fileInZip.Trim() -ne '') {
            $fileToRemove = $fileInZip -replace $folder,""
            Remove-Item -Path "$fileToRemove" -ErrorAction SilentlyContinue -Recurse -Force
        }
    }
    Remove-Item -Path $zipContentGlob.FullName -ErrorAction SilentlyContinue -Recurse -Force
}
