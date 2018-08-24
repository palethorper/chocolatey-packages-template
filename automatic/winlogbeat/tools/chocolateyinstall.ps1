$ErrorActionPreference = 'Stop';

$packageName= 'winlogbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.4.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.4.0-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '4adffad019476f7f8e5e8bc951289a06d13d13a18351390f7d915ba3f034068f9e4b3c30d556f80920c9cfbd7ef06e3cc6b28dbddbed7ec2f112662a17ccd206'
  checksumType  = 'sha512'
  checksum64    = '870993db078c7aec218f2dd2db639afb8676d4aaaa57c152ab3cdb525d0d7f73d0b42ce70dd9eeb1feb7689ced97175883ab982e97139c9bb0dc3acb2f392f81'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
