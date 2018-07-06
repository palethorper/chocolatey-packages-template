$ErrorActionPreference = 'Stop';

$packageName= 'metricbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.3.1-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.3.1-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '883395d9eb1ec951efcad02f3b89929496a527e30f87ccc723b10861e8619c0064382e8f8fb3cd225c4abaf8d41922553180a59db26839a8b16e8d9e1a14bbc6'
  checksumType  = 'sha512'
  checksum64    = '9b070869945e7b7cefc4a4e8d6c19673f171ae37881199a76272c075d31d966894d83dcf764e80464444b5c4c0a1a7eb573deab2d194cefe431b421676193a55'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
