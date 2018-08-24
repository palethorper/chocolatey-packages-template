$ErrorActionPreference = 'Stop';

$packageName= 'packetbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.4.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.4.0-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'bf5ff78d4cfb59ccecf513c56a6efbef2b373d6bbff52b86530d991296bcbc72394c07627522cbafeb49e8d894531039f34da0a91edd3096329e0dfc927a2069'
  checksumType  = 'sha512'
  checksum64    = 'f66ce4d52b4b5e5132c69eb28f024de72db76d3599410011add498ded35bc2bca09d4c5de8b5e1be7137db209689b53d12d0cce32ada3fface1f67b430c34097'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
