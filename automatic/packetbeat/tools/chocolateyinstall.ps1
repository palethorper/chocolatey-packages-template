$ErrorActionPreference = 'Stop';

$packageName= 'packetbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.2.2-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.2.2-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'a6e065d8715944bbd23b0f43c884ef2a3eb9604f6998a94a36c65809654de33e3e2502732508cd91b846ac387892cc1d92a3b7bb0e4241a85d3fd0adfac428c9'
  checksumType  = 'sha512'
  checksum64    = 'b2dcf8de5fecdd697fe73af952b1150ca5f82ea964a4b8fb07a31513aec7265392504e12e0a846169430bdd22f1c589b47983dd16a64a4c11523d2ef0cfea50d'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
