$packageName= 'filebeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$nupkgFile = (Get-Item $(Join-Path $toolsDir "..\*.nupkg")).FullName

$oZipManifestFile = (Get-Item $(Join-Path $toolsDir "..\*.zip.txt"))

$zipManifest = Get-Content $oZipManifestFile.FullName
$uninstallScript = $zipManifest | where { $_ -imatch 'uninstall.*\.ps1' }

Invoke-Expression $uninstallScript
Uninstall-ChocolateyZipPackage $packageName "$([RegEx]::Replace($oZipManifestFile.Name, "\.zip.*", ".zip"))"
