$ErrorActionPreference = 'Stop';

$packageName= 'winlogbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.1.1-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.1.1-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '421cc5b253215315435cc4013afba8876f96aaa9fefcab6afad9b67aaeabea745d7431a642e8622e75b9d7fd7e64929678c0ab03209d8e18cebe295d1bd769eb'
  checksumType  = 'sha512'
  checksum64    = '3a3c541a2e8ab3e4f3c981eaf2a7108fc206d5c6b509914527ed821408ec50792890d22908ba7e86cef6ee46baaddc9e1ff62eed0d6d40f6ba75f9805d4ff798'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
