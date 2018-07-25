$ErrorActionPreference = 'Stop';

$packageName= 'packetbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.3.2-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.3.2-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'ca523c021da496b9054a34d49435ab0d5d26e9b9b1d3d88dfddd0f36a604c32f92e7c09eb67a34be49e1e7e1888a9be867a64f0639c5af59fe9f58a23cb224be'
  checksumType  = 'sha512'
  checksum64    = '4de33a8e3bfb86df1c51ec501ee3bc20a4e362463970d8b3ca60f7d7d654b92a2ecd81dff8362f4522f760a4be16163af1d42e417cb484a7514b6bd7e94ae716'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
