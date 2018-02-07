$ErrorActionPreference = 'Stop';

$packageName= 'packetbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.2.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.2.0-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'cea1c39b0389671f48962ef22ed9ef036dfc40aff898b2e0ba25c9d0ebcfe534390c9edc7f3f1fd8e927ca4c785610461962282c13cab37b18503d122d5ef453'
  checksumType  = 'sha512'
  checksum64    = '9ee8222c34fccbad379948bfc3cb7a8dde815982ca57f90b19b5233e7f5ff796c7803b2a0f3cd6a164ef9fe3a99bbf21d53a7f9ed39b7554e8255031a9bcadce'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
