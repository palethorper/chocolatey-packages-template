$ErrorActionPreference = 'Stop';

$packageName= 'filebeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.5.2-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.5.2-windows-x86_64.zip'

$installationPath = $toolsDir

# Chocolatey seems to copy the old lib folder in case of upgrade. Uninstall first.
$zipContentGlob=dir "$($installationPath)/.." "filebeat-*.zip.txt"
$zipContentFile=$zipContentGlob.Name
$folder = ($zipContentFile -replace ".zip.txt","") + "\\"
if (($zipContentGlob -ne $null)) {
    $zipContentFile
    $zipContents=(get-content $zipContentGlob.FullName) -split [environment]::NewLine
    for ($i = $zipContents.Length; $i -gt 0; $i--) {
        $fileInZip = $zipContents[$i]
        if ($fileInZip -ne $null -and $fileInZip.Trim() -ne '') {
            $fileToRemove = $fileInZip -replace $folder,""
            Remove-Item -Path "$fileToRemove" -ErrorAction SilentlyContinue -Recurse -Force
        }
    }
    Remove-Item -Path $zipContentGlob.FullName -ErrorAction SilentlyContinue -Recurse -Force
}

$folder = if(Get-ProcessorBits 64) { [io.path]::GetFileNameWithoutExtension($url64) } else { [io.path]::GetFileNameWithoutExtension($url) }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '3a6ab1ed7f9921b826b9ec71ca62446eacdeb7ac5c4c3bac814cad30a41fa966d76975639e8b79f13f95cf948fee81362c4d0b0676ee51899e27428583a3e6de'
  checksumType  = 'sha512'
  checksum64    = '57923a69a5f6f5ef0bfc67e6152e94942f7e7a3bb838d52dfbd5d61d29fcbe2d35503f0886ecc352f3606a6401aa56f156caac9f3a6330ed14874ad3879f55c6'
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
