$ErrorActionPreference = 'Stop';

$packageName= 'filebeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.12.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.12.0-windows-x86_64.zip'

$installationPath = $toolsDir

$folder = if(Get-ProcessorBits 64) { [io.path]::GetFileNameWithoutExtension($url64) } else { [io.path]::GetFileNameWithoutExtension($url) }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '601ffbea2ca8d462a80708e5bc79905701d4e39e9831176bdcb1fbf3384c4bc2e87fd5110c1d313a0c405a87c5d4cf78e3b54e6062b4d0296f9cb779bba15d0f'
  checksumType  = 'sha512'
  checksum64    = '4723a3745daea8a0c7ccb807a290d8362a7b320cd68fc6ce2cec93616b7977047247e3814f50363c0f783686c33c6524889a2569f52da1855ed85e25b3015ded'
  checksumType64= 'sha512'
  specificFolder = $folder
}

Install-ChocolateyZipPackage @packageArgs

# Move everything from the subfolder to the main tools directory
$subFolder = Join-Path $installationPath (Get-ChildItem $installationPath $folder | ?{ $_.PSIsContainer })
Get-ChildItem $subFolder -Recurse | ?{$_.PSIsContainer } | Move-Item -Destination $installationPath
Get-ChildItem $subFolder | ?{$_.PSIsContainer -eq $false } | Move-Item -Destination $installationPath
Remove-Item "$subFolder"

Invoke-Expression $(Join-Path $installationPath "install-service-$($packageName).ps1")
