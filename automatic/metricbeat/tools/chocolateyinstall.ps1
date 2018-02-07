$ErrorActionPreference = 'Stop';

$packageName= 'metricbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.2.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.2.0-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '52e2f333329712696ddf1ecc97f3eb5427f6803efc63761948af47d401539e9b0ade63026181624d19ddcb9aeabb7e2f24598b21e6b02d95068b1a60b35175f0'
  checksumType  = 'sha512'
  checksum64    = '2e5c491154bb1936cd97097d57737bac5728e1c8cbbea38023c1fcf1a9ed8a6bd17e30015365360565ef35d2bfc07f52c40e097c758196d4f66609ace067d182'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
