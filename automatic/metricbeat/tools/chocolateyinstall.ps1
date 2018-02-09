$ErrorActionPreference = 'Stop';

$packageName= 'metricbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.2.1-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.2.1-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '7d37ac5f3d633bcd3b5a6e462a8e9ce942da7c888666eed722fa713a0b9d442376fe22a1e5bab58f4463848814b560bf43a992d098c28515805065ef8761cf31'
  checksumType  = 'sha512'
  checksum64    = '71a6be4d614a31fc92728317cd7eb3b187ff36226c6c1424a3abb035697996d1a7ee7fa6619560db59174568f6bd820d4d5a946f65a80b1844069dbd1c0f6832'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
