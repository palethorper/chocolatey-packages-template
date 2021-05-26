$ErrorActionPreference = 'Stop';

$packageName= 'auditbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-7.13.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-7.13.0-windows-x86_64.zip'

$installationPath = $toolsDir

$folder = if(Get-ProcessorBits 64) { [io.path]::GetFileNameWithoutExtension($url64) } else { [io.path]::GetFileNameWithoutExtension($url) }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'e57a280e1faf425dfd6282d1bf99eecf884db4fd21575b33bedd20ba95a542a0b792bb4f13ed48ef7934f196c0d7bfaeb0dc0a149904b9e5bf463a014b1f4600'
  checksumType  = 'sha512'
  checksum64    = '316841b2c1a113ea36acea53e38e68f2a39e5239d0c6953f9a5bc883155a2e5f3d87e02c65e914fa52e0049bb188e97cd23bba12e0f7fa65977f0ca801999df4'
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
