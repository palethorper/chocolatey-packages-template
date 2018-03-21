$ErrorActionPreference = 'Stop';

$packageName= 'metricbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.2.3-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.2.3-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '6f5464642c243ae57d61a51fe22cba445d17932b6f64030c2db79f622d1469e393e6ce2e099725542327e808b2b869e3401f0f6d86e0f13f6bbeb735797e1093'
  checksumType  = 'sha512'
  checksum64    = '87fdd478f2d18886c1afdff4c0a6c3715d659ee544c7664e42d188763f97d0f0a8bcdf87f3916eccbd9b69d5e8e176a31046388bc9162efa6106bd15e62ed2f7'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
