$ErrorActionPreference = 'Stop';

$packageName= 'winlogbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-5.1.2-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-5.1.2-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '1dfc19978870545d6f844415fd7cbb8f8734247a'
  checksumType  = 'sha1'
  checksum64    = '0e7ce78de544947edc19fbf3a08b4f3e77009b89'
  checksumType64= 'sha1'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
