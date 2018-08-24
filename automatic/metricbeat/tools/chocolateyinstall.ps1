$ErrorActionPreference = 'Stop';

$packageName= 'metricbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.4.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.4.0-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '03c99f2c0e09c4a652f5436554a9b3ebb563c6406fdd5fcf4a548a326cb03e994231304f255a8bf0c680afad424756cb9d000a8f109d87f252b73ef20df74f3d'
  checksumType  = 'sha512'
  checksum64    = 'a9f9a5fd771d399a24f4f2a87a53596ff5b49093698a8288f1c19a48363001d2fc03900a00152fe9803cd9fb1bdc909823a4252160b5a61b793a4ba17cddc9a0'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
