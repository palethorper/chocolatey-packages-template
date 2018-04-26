$packageName= 'packetbeat'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$uninstallScript = Join-Path $toolsDir "uninstall-service-filebeat.ps1"
Invoke-Expression $uninstallScript
