$ErrorActionPreference = 'Stop';

$packageName= 'winlogbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.2.1-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.2.1-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '99c82bbe6b02adb166e438c3b0beafc0f25432c90af4c900a760474de4d5d9caebd5e86fba8a960a5daa7ac14463684ce939f4b9a4c68c83aef294a4367d81da'
  checksumType  = 'sha512'
  checksum64    = '7bfa75b689cbb0c2139494c7d5039bd70acc67bb71d080ebb70c0d858cf15894eeaf9fec5173dba2f831c924cbd94489235fa92569d4633a96ad1487194d53f4'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
