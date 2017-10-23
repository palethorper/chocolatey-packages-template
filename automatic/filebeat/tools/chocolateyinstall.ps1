$ErrorActionPreference = 'Stop';

$packageName= 'filebeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.6.3-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.6.3-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '6e997bcd1af31bf90bb2cf3c8e1b9fc07e08fe90430527c1feba60e13fbb959795f6c35b39cc1d59cc118dc4514a0bd8064cdd279796e3b727b292c79d3c3893'
  checksumType  = 'sha512'
  checksum64    = '4d7c22a2a474a3a62ff9ed26a7cc078c7c39f819191f89ce28523ea51853ad126b591eeaaac02de65c831e8afb19f5c7f2d6faa7289a00ba72e9aa1006fbfcbd'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
