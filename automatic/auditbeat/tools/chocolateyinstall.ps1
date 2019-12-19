$ErrorActionPreference = 'Stop';

$packageName= 'auditbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-7.5.1-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-7.5.1-windows-x86_64.zip'

$installationPath = $toolsDir

$folder = if(Get-ProcessorBits 64) { [io.path]::GetFileNameWithoutExtension($url64) } else { [io.path]::GetFileNameWithoutExtension($url) }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'dc6007fc3d1ec370f0bd1b221775f7846a0ec745e3cb4f039f9ffac2a5cf2a2c59a5557249844acfab00363ca3a2968ade72a4d3754b11446b63c0018bf00e51'
  checksumType  = 'sha512'
  checksum64    = '731e074b7edd3ad91f0ab65d52f3bd6e7ac2082e8ff5305043f7965321e46d13337781dc25e0f2cb27799b49f597619f6787aa03e0453410846b52f31df82670'
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
