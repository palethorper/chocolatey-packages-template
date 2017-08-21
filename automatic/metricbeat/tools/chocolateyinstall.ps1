$ErrorActionPreference = 'Stop';

$packageName= 'metricbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.5.2-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.5.2-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'cd04889d3dcd8d3a623cf6163650d7a8e4a30cd3'
  checksumType  = 'sha1'
  checksum64    = '5b1c1a1b8be38cfd790f44dbdd4e08fa6be2c2df'
  checksumType64= 'sha1'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
