$ErrorActionPreference = 'Stop';

$packageName= 'filebeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.1.2-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.1.2-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '2b69929fd5304e92a93625713f142760630c7ba0de16a458836f63ed979b63c2a89111354e339b1c3ea157f9d648bde8452a95aca39ceeff23d50b855fb4575c'
  checksumType  = 'sha512'
  checksum64    = '4ec29aa6b79ced00f3b23953739dcb2023b93c55d2fd6b31bef7f1f44d2744928e3fa6c4619d50091f58b737685d989fa1cffbfa519c05ca20db953740a23d73'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
