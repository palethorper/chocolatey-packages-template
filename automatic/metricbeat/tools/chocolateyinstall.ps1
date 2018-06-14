$ErrorActionPreference = 'Stop';

$packageName= 'metricbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.3.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.3.0-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '0c8805695435b955f471209b6323aee18ffba71fd686bd1bc12548dd607b9cdfda6557f0d342fdab62e22d344c630aeaf904b3215266cfa1477b5b8500c3603a'
  checksumType  = 'sha512'
  checksum64    = '2bc3c83c53e05a640f5a064c571cf2b145ef6d83c858151da050c4fbaa7fad89364dd3c4a793cabd3f4d5023bf9a5a51e4cfeb573e360edbe2c144a0b875d6b7'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
