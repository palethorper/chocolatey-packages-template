$packageName= 'winlogbeat'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$uninstallScript = Join-Path $toolsDir "uninstall-service-winlogbeat.ps1"
Invoke-Expression $uninstallScript
