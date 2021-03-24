$ErrorActionPreference = 'Stop';

$packageName= 'packetbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-7.12.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-7.12.0-windows-x86_64.zip'

$installationPath = $toolsDir

$folder = if(Get-ProcessorBits 64) { [io.path]::GetFileNameWithoutExtension($url64) } else { [io.path]::GetFileNameWithoutExtension($url) }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '8fc55ed4e839e8136d20c112c0249f2c1cc1df60b23d87f2ec55bb03065ed5c412ae9ecda03291bc796b411988f8983849aec81a8af36de3a987f9ea5b927868'
  checksumType  = 'sha512'
  checksum64    = '3055d9b8671895c1546ead2a49cd641a36cc8c292be3f61b0ecb1a79c34eb9defc0f971c5973121ca2c03f97de241ded5c382e53557477aff1850f5437818f46'
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
