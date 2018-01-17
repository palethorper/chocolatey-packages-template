$ErrorActionPreference = 'Stop';

$packageName= 'packetbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.1.2-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.1.2-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'a970b4fa55a552157515d1f17f46ac3a776b91e3b817596a8d81a966c36a3351895280da5e9c5ba268f46d6128ce4fa729f83b0901cd2d9c3d1e0a53d5a89bd3'
  checksumType  = 'sha512'
  checksum64    = '359b97c5452ba28b98c5235a3f91d17b6640f244d736b2b94d723f9b1936ec3f73bdc864cfac91ff058d12f48069ffb5c11c116b41e48283525bf837591e14b2'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
