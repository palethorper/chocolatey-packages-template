$ErrorActionPreference = 'Stop';

$packageName= 'packetbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.2.4-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.2.4-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '93f58f1e3c3e682855ffa3ecfb556d001ac091c6802f05c889f02a1b5c34f555203744ae52f7217a652283935791bfd6b9f39ba5d824ea96a465d39d6d9b0f77'
  checksumType  = 'sha512'
  checksum64    = '1e6bd3c0f6ee244a97b29f2e221b0211771cd1163c9c7d87fbe8c137656239bba1c14af10406cab4d36e01b38d37ac5650cedc6880afb1c5320fc9a622249955'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
