$ErrorActionPreference = 'Stop';

$packageName= 'filebeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.4.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.4.0-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'c3b67a8608cbe49be74ded9209b929893db57b51ea8e516f5f4287a8b7b0817e708a3bab5cf4c2169932721c3a6f5c8dd9395723c9119578d7552d27f149bfea'
  checksumType  = 'sha512'
  checksum64    = '468eb242e612b1fde561460ac327e39a29c8bd1aae165e3b900384e8de7f2bd5e60a0d6ebdd869b2b7d6640caea1af92a2cb35af6ee6cc2c224bdad5eaa6dd3c'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
