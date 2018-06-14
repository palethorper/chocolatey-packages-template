$ErrorActionPreference = 'Stop';

$packageName= 'packetbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.3.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.3.0-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'efe82bf60544a550ed8685a5f5ccdb8b2e485d8007b3268dbf5d9285ef460bb25c30ce7009ab3f95995ddad59df45de8341f876c7d22dc9569fc126eaa51811a'
  checksumType  = 'sha512'
  checksum64    = 'b68a6ca900c8c0e59ae9a1ed7fe51c8ae99af473358a3c262bad73b88d7ca63d59e4a6681c7759f5a36154afaeb9109cf6587112f135914cc22bf82d915d71af'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
