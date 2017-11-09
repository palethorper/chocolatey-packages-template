$ErrorActionPreference = 'Stop';

$packageName= 'filebeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.6.4-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.6.4-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '3914fca43e9a91584491e654f3300ba5ea125d7ee63f26e83a8e85f7b7b55649453439ece357f2423c54289249e385e3271549b546c056332cf5df6fc672488d'
  checksumType  = 'sha512'
  checksum64    = '2f2a529e0ce6218e5cb4bab3e2cf8f2ec15a0a264019a8681882be57d03cb848a8b75d6772b58eb8d85459586818a40fdb1a72cc0e4a3d43145012a5d794705f'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
