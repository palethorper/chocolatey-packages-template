$ErrorActionPreference = 'Stop';

$packageName= 'winlogbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.3.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.3.0-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'e0186af212b31ebbd25d44f0c60e43af58704f22a81c46aa67242f46ea407dd7ef8e6194a948c440dbc3a1243cd564f570a51737c41894761502b035c1d9e724'
  checksumType  = 'sha512'
  checksum64    = '530890530eb7fcc34b08b666bf42ab6d6c27aa7a1173c550a7b6b7de0034a8d8db593a8db2ae80e8c72becfcd6406f78f7f6d2adba217a99cb3774e712795dae'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
