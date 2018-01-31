$ErrorActionPreference = 'Stop';

$packageName= 'winlogbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.1.3-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.1.3-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '0020a0af8ba445401a888c2fe597c6b57bd6fc53acb3c3446b831a698af8542b5dea7cb01eb0037107379b20245963b0c28ddb4b97d35811b57f3be092e31b8d'
  checksumType  = 'sha512'
  checksum64    = 'ba3cb2a7060f4c4ddcee0a1f1bb03aa1a64025a02ab750b96a18bde40cc06b22d722d7d606fe40e660d6d72458c189fd3b1e4195e6bb19ba5220bf99a9c30586'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
