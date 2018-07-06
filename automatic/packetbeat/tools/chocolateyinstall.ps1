$ErrorActionPreference = 'Stop';

$packageName= 'packetbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.3.1-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.3.1-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'cc0febfb23e1b2da06aa1d538c32bb753a93fa7753d124468fc33b9e3a0bc42a4fa24d0e93b92fd86cb98442a7872fdc7c3006dfe05777b074ace445dee37a70'
  checksumType  = 'sha512'
  checksum64    = '9776e77646e75f591809f16c0d6d436a5f9d27e6c76f91935621ab211f8b6da81e16a025ebbc46be013a62d4f428621e0407bc7c8a9d600d13392f7a34b534e7'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
