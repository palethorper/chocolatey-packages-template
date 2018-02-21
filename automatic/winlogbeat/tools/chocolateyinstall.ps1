$ErrorActionPreference = 'Stop';

$packageName= 'winlogbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.2.2-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.2.2-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '7a8f4748b790f608c7374e19544ba912b9022f33d2bc0f8fa41442f53aa417a71bb14c2110c9da734959cc551cbc5b8871a7a15867814f9d773cf32f35fd9c39'
  checksumType  = 'sha512'
  checksum64    = '8e43543628659a075e85c5f6b2400579fd4c93a487893179ebc169b2eedbf5eafedd1395eadbfbd9cf31e1f274929956e5360f0a1543325ebe7f6b867d9f6b1f'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
