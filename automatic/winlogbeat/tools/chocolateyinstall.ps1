$ErrorActionPreference = 'Stop';

$packageName= 'winlogbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.2.3-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.2.3-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '315f5d16137bd518994e0aa6ddaaa4ef433b56d393f3d7e0c9c1e4f0913ca91b21e94a21f2ac6d71e47f88ee24741e6e3fa504d186914e6b7e9367edab684837'
  checksumType  = 'sha512'
  checksum64    = 'f35fec1e29f7432abe869a5b7900f6cfe6fe698e2e75ef5d5c32117d11d433b57936c7cd50aec3d8e0acde92ca104235eccc1234c54700106f606380c7e884e2'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
