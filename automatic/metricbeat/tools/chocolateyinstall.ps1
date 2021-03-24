$ErrorActionPreference = 'Stop';

$packageName= 'metricbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.12.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.12.0-windows-x86_64.zip'

$installationPath = $toolsDir

$folder = if(Get-ProcessorBits 64) { [io.path]::GetFileNameWithoutExtension($url64) } else { [io.path]::GetFileNameWithoutExtension($url) }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '003322b35cbb92d560e08c4156703edba805b00b63771986a68a407833210e45c5f8437766eef670f583ee6818fedfd848682e2bde3798cffe154374c323f443'
  checksumType  = 'sha512'
  checksum64    = '17d4ec7e5634e2f851f345c038a3330f522b94195d6d61a831003b479466aa02d2b52fe3fa48ce93a6ff93035099b632a5a6cae4e531375f45194c2a0ca53cfb'
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
