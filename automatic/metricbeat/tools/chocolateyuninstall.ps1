$packageName= 'metricbeat'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$uninstallScript = Join-Path $toolsDir "uninstall-service-metricbeat.ps1"
Invoke-Expression $uninstallScript
