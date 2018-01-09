$ErrorActionPreference = 'Stop';

$packageName= 'metricbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.1.1-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.1.1-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '6811f54bf2e63c9ba5d25d1fe33be7d9d05a7cef167471a09bbba9aa993d845264f1da9a2358324a3fc9eee35a23b2c18e080977d6ddca4ee26edd83d43ddf67  metricbeat-6.1.1-windows-x86.zip'
  checksumType  = 'sha512'
  checksum64    = 'cc30bf0c44f0499c11ef4bf1606f427085d89d9f506dbe468f43de766c588025423734766c8b85acbd49097a1150b937a23b8897d501127fa90ec598a4599d17  metricbeat-6.1.1-windows-x86_64.zip'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
