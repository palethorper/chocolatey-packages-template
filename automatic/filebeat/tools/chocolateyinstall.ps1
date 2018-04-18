$ErrorActionPreference = 'Stop';

$packageName= 'filebeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.4-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.4-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'e589008db1e109d946b6d08513842228e66b28d5a015c061c0a3f6e6cfaaca728981444ff8b74a136924518e51e87437d399bb642f2c6b51d56b401f3dcc6cb0'
  checksumType  = 'sha512'
  checksum64    = 'a96f8cb94d79fb80f052ae8a940de1dc0ed4664c4b10b5e80bfcc1aabfc0d6594163e354df9773e5e86c77d26e8096081dbb68a93ed0d6dca718a2b31821b1db'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
