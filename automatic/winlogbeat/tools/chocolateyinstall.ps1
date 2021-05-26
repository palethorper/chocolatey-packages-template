$ErrorActionPreference = 'Stop';

$packageName= 'winlogbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-7.13.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-7.13.0-windows-x86_64.zip'

$installationPath = $toolsDir

$folder = if(Get-ProcessorBits 64) { [io.path]::GetFileNameWithoutExtension($url64) } else { [io.path]::GetFileNameWithoutExtension($url) }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '43d2b544f66473389a7bb34862cbbd8840490377b458a4907ff2e5d1aca27983d87eeea494634b0eea10d3087926dcb7ff0adb7b3cc9315148972d1c3a883ebf'
  checksumType  = 'sha512'
  checksum64    = '040683ea34a172c7cb8912ac686091da610e72b1dbdd0ebf770a1b872cf8224eea08aa1f15dc427c068bf6e79e3e8c4ea041b8063f3c7ac9784989eadc58a353'
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
