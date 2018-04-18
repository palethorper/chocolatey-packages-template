$ErrorActionPreference = 'Stop';

$packageName= 'winlogbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.2.4-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.2.4-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '6f356a1651ab7203f90088142c2535056959294cab56a6c52586761fa35c26f37891622a60d127be749fd03e5ad1cdd03bce21000fd0f22f1ed2bfca815ea99d'
  checksumType  = 'sha512'
  checksum64    = 'ed19c03868cad2975639772405003d3ad2fa217b72161ffac56c65ca16cd2f91aa0f474b5928318255c9b1204d67611052e379dafe9faab2de85c8f4c15de2bd'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
