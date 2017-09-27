$ErrorActionPreference = 'Stop';

$packageName= 'metricbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.6.2-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.6.2-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '01cee9e58fbe7467be0ab4fcbd79e915d9ecdf55ce52ce78ab285e09cea0eaf941676167094312ddf2b1f012178f912f52b70ca9e26b6dfa6fb04b321d765bf6'
  checksumType  = 'sha512'
  checksum64    = '7d5bdbc916411a48ab6db265ff56f84fafe983bab4037966ba7a5693334caae8e0fd168d744f31ec5fa3dfc261d062ce52b61e50e297e52874214d3d9e227e7b'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
