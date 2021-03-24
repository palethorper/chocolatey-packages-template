$ErrorActionPreference = 'Stop';

$packageName= 'auditbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-7.12.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-7.12.0-windows-x86_64.zip'

$installationPath = $toolsDir

$folder = if(Get-ProcessorBits 64) { [io.path]::GetFileNameWithoutExtension($url64) } else { [io.path]::GetFileNameWithoutExtension($url) }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '0f3384a772e2a7d0d6b337adde9fe973f32035d10c4f856bbe3ccfb3bbed4cfc4a414ebc4266d674f08f50300f39f3fa04a439e8e56a8cf78535b6847d9724aa'
  checksumType  = 'sha512'
  checksum64    = '507b8c1065f6b2ada2c2799c61f45028987c162bd1dccff58e7955daf3dc302cf242a243d620053eed8ceb9fb35e7e397ab7ab7a9fe10c7b74042d973c42bfa9'
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
