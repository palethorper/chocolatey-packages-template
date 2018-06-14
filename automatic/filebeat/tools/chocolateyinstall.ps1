$ErrorActionPreference = 'Stop';

$packageName= 'filebeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.3.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.3.0-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '178bf277d32c92a083e0141fe1ab7d5b41808d39289e05c057ff973ddc2f00c2258238fe96bc18be7bf5359466dcb308ea51c2d07291ed4debd34f7f9803d83d'
  checksumType  = 'sha512'
  checksum64    = '3f71df90f368820e34393c2c0e24e0f0e7ff6782de9e6e39be2669ed6506f63ff9075fdd43e56af2abf8432ffa4341461475c6ce4c9c0e26fcda7338f531e3c7'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
