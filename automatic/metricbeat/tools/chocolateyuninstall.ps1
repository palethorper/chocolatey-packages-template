$packageName= 'metricbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$nupkgFile = (Get-Item $(Join-Path $toolsDir "..\*.nupkg")).FullName
$zipManifest = Get-Content $(Join-Path $toolsDir "..\*.zip.txt")
$installPath = $zipManifest | select -First 1

$uninstallScript = $zipManifest | where { $_ -imatch 'uninstall.*\.ps1' }

Invoke-Expression $uninstallScript
Uninstall-ChocolateyZipPackage $packageName "$($nupkgFile)"
