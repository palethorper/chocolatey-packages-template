$ErrorActionPreference = 'Stop';

$packageName= 'filebeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.0-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'fa089985f197d985d7f69ff8ef5cb98d2d84cbe54503480bd2b233b07f53c64016871da089ac779cfe0e9d513de99308ba7d85ea541f9e4d91ffc64dd1133971'
  checksumType  = 'sha512'
  checksum64    = 'b047f1e642214b04507a7dbc2fc002f1f420e87b3e5d9300610f2a33cb9e7f8a8b9c7d14a62a59274b729e7754f107d4cd8c22c3dd65b5d9687d526ad557597f'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
