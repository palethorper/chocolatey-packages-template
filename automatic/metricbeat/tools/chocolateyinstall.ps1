$ErrorActionPreference = 'Stop';

$packageName= 'metricbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.6.4-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.6.4-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '5e7c460aa95ad00190161fffcad2c9e6b1a3b84002876ee4179a33f62013745ef9df687d00a12a1f1e20adb1bf610acfeabe7166dc7c8a2288e387689261b4c3'
  checksumType  = 'sha512'
  checksum64    = 'd9f7b2e3c0689f6fc6fa46f1ff6f73f1038b2bb5ada32bf56c098dd364f862dd777c8c00fd1db231df8233d0307e72dca06f25dc4b84be4a5f03812926a154d7'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
