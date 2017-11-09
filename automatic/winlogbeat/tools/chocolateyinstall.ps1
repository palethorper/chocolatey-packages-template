$ErrorActionPreference = 'Stop';

$packageName= 'winlogbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-5.6.4-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-5.6.4-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '4aa061bdd355ed689f48b010841d5f631d30f729d3b0cf2207850dbbe784a94e569407ab4e67bc685227e6cc4b92130330d3bfd3a5489d6c863a8c003369501b'
  checksumType  = 'sha512'
  checksum64    = '3d1057e398a02ba603f5fb6c9c2b1638a82840752fe55147baa5ae605c1008818d1bb8a3640e6dd3958b28e332af6b49ded56c0af546b93af1c6284f9b1de98f'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
