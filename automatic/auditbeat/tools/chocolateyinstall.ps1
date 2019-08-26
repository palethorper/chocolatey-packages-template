$ErrorActionPreference = 'Stop';

$packageName= 'auditbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-7.3.1-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-7.3.1-windows-x86_64.zip'

$installationPath = $toolsDir

$folder = if(Get-ProcessorBits 64) { [io.path]::GetFileNameWithoutExtension($url64) } else { [io.path]::GetFileNameWithoutExtension($url) }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = 'bc1f220ea39563e5cf2b6b9408b1979a753a4cefcc4d83c820bbd3663ba6859cc10fd56a07f53263c7454bd514933013c34697c0afb92d9778b8535a9e49af28'
  checksumType  = 'sha512'
  checksum64    = '88f5f826b1bd5627f3bbcaf97afa973487dd2a6585f155354a8eaa276f8e3635e7ea496182da97fea84d2d91295c6f0c1e2ae9e8495f7f68cbf5bf23c5267949'
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
