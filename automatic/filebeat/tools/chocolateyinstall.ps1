$ErrorActionPreference = 'Stop';

$packageName= 'filebeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.1.1-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.1.1-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '32a7ec83f8431a8fe409f9c388c3f8d1919b6deb9cdc4a29b112b5f878b0d633f70b1219e16385d40ccb29f17e7d06e80c4bc01a9fbf75a7851c583911f0917c'
  checksumType  = 'sha512'
  checksum64    = 'f607a904137a99c47b33833d79dc4e04217556032da9648ff94b8383c4ef3d5e471737ec2a8cd329cee8e5ea5756372e53c4d0dd6caddab4d9a44030345404d9'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
