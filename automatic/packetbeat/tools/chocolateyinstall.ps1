$ErrorActionPreference = 'Stop';

$packageName= 'packetbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.1.1-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.1.1-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '5b35da15b73f831f2c5af34fd7fd09ed94ac5ef4bb9141604ea814f47acd4c233e6ca3b0b28eaa0655de18f27dc9ba509e94880f471f360adbd8ef92206312d6'
  checksumType  = 'sha512'
  checksum64    = '62ed2af4f2dd9fbc5c3b283a7446b74eb1248d95ad063fbee0f5494815e1d324bc934047ad474fd259697139b1bc297dd7a777e26f44ff0a0e8fa1cd81e7ae70'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
