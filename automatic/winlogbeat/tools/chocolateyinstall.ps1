$ErrorActionPreference = 'Stop';

$packageName= 'winlogbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.1.2-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.1.2-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'aeef2955cf6ae21ac7593991b7aaa8bd8e360aae40f9a2757c0625e872fc958ffc535aee06381162e1eecf788270cb9fe42ef4d41b12e6162f5766512d17e9cc'
  checksumType  = 'sha512'
  checksum64    = '27aabddeb1d460bccfcc2098a0955f94674d827b2afe6911cbd06583ba5b7ce63085747b4dafd586f0e92869ffafb918e688ea2034483fec74673c1b4b762c03'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
