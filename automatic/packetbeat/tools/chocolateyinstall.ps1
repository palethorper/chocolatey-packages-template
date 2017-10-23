$ErrorActionPreference = 'Stop';

$packageName= 'packetbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-5.6.3-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-5.6.3-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '792b633b900e6e1a38a959400f7ad8454e3639f0f9fa4092789c02b64054a939a8f3dcca9fdc89f0c5cfa7191a003b8c1f5e8711e403bdacd8ec643aafcfdaf5'
  checksumType  = 'sha512'
  checksum64    = 'efd419be4f4f83fae79b5351b99fe37518d1075788ad3f40cb80d9d8d58ad721afbc2ae9b92888cd19692a0154689efb946f7c920e7a8a71a7f6117282d826b6'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
