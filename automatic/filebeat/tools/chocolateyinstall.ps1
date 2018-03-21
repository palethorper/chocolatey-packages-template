$ErrorActionPreference = 'Stop';

$packageName= 'filebeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.3-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.3-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '2a2aebf61e3ca1d383cc73e32ae03b9203e533e4c35508f0f775714c3d23fff6541adc83c8a983a2c6741e26cd2871490a44443b220acbc45b20ad8498016979'
  checksumType  = 'sha512'
  checksum64    = 'cc25125497b8f5c427f54e0398b45e75721676aba7102de24e4a1e8aa71ba53ae68c24c774ea44298dfdccccc204c1e0e7074e07b5f88d4b735c76ff2c349f22'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
