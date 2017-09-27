$ErrorActionPreference = 'Stop';

$packageName= 'packetbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-5.6.2-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-5.6.2-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'c8f17ada840073d65745eec92ff262eb31ff13424d7c82a874d3b434ccdaaa67ea25e178a1c4b87d5fb85cd880c178a6e9f4d31342533f8380d3b6b9154f869f'
  checksumType  = 'sha512'
  checksum64    = '5e2456a8f5442f4bfd9e813270ddbce27723c2b5e721ab5993e6deb824eb691e8afdb2b589d4b13850b54204eb7b851a83c42078c0b2f98a34fcc67c7369bd0c'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
