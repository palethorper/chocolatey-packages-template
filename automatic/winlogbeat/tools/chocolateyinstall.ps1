$ErrorActionPreference = 'Stop';

$packageName= 'winlogbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "https://artifacts.elastic.co/downloads/beats/$($packageName)/$($packageName)-{{PackageVersion}}-windows-x86.zip"
$url64      = "https://artifacts.elastic.co/downloads/beats/$($packageName)/$($packageName)-{{PackageVersion}}-windows-x86_64.zip"

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'fa74dc6599f9fe74419fd4d6ad5812aaca70c34d'
  checksumType  = 'sha1'
  checksum64    = 'c93a99237d1c3e9612fde4ea095e106c8a14794c'
  checksumType64= 'sha1'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
