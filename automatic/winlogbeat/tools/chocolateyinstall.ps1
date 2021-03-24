$ErrorActionPreference = 'Stop';

$packageName= 'winlogbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-7.12.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-7.12.0-windows-x86_64.zip'

$installationPath = $toolsDir

$folder = if(Get-ProcessorBits 64) { [io.path]::GetFileNameWithoutExtension($url64) } else { [io.path]::GetFileNameWithoutExtension($url) }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'b389b998868f2113c8585cc151ce3a3986cba25cec64e64ad8231b7a1859c0acb0f4f8de4d29f955d8c23af2062da423f2313c0734ee0f1c7f3f92c172090fd9'
  checksumType  = 'sha512'
  checksum64    = 'af7750d4c84dc3b160f49d5a81acdc12963cbe1cfaa25229df9c47867c0c6b136a5c0a953bbadebb19339156acb905bd5129ab0d8ad81b44c71f5dc48adf4095'
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
