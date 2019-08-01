$packageName= 'metricbeat'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$uninstallScript = Join-Path $toolsDir "uninstall-service-$packageName.ps1"

if ($null -ne (get-item $uninstallScript -ErrorAction SilentlyContinue)) {
    Invoke-Expression $uninstallScript
}
