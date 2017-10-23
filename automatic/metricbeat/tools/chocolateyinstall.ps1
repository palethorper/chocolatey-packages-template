$ErrorActionPreference = 'Stop';

$packageName= 'metricbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.6.3-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.6.3-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'a1eedfe77dd0fac1596a893b6e682be00c5a25f3e1dd13ea1d1e1fa40448fd586dcf9dc329afc55b3e2b9c4bdfafd60c2587ebf1244b3bda58836e66d1ae05ce'
  checksumType  = 'sha512'
  checksum64    = '06c28cefee9e3ad5c823637c9f99b2109e58ccf9c3dc4ec61392d6c0a6cf6588b0497117e74016e83fcd046eda39cbb41249d6e8bf7c269d979f695c37080c82'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
