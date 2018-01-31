$ErrorActionPreference = 'Stop';

$packageName= 'packetbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.1.3-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.1.3-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '15f596ef1c68998f7dafc8ff3a53e2f8a0e216a38a4472fc9a9d466de67596e6dda4fb88691146df3fd6260f9d555ac573aad10743bed5d498fd6a1cf89a2292'
  checksumType  = 'sha512'
  checksum64    = 'bcf54e0991f10d9a1a9b018ee730ca48d55e53fce38eb5a98498cde8ce4553d07ffe0b8f67227d3fa6085a9d3303a3f8c11e066ded72d6f6d418b766529372b4'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
