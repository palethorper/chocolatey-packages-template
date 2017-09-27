$ErrorActionPreference = 'Stop';

$packageName= 'filebeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.6.2-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.6.2-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '72d45fbd97dc9329cb0cea847d60ff62bc119503733ddc9a3db53a11abbbe80a9e474a5fa05bea176f41732e970e9db77ae957858d84939c5750954b7727e38a'
  checksumType  = 'sha512'
  checksum64    = 'fbe5b32b7b948065eb3fb70bdb6d3cb9fa192bc346c8d7e06049249e853f8196ee8d9a8ec51e03603dbf4c2395dcc78101a9284b2ef17c901fe0f014a0ba89f8'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
