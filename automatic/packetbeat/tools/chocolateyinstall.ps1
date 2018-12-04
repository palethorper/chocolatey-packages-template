$ErrorActionPreference = 'Stop';

$packageName= 'packetbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.5.1-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.5.1-windows-x86_64.zip'

$installationPath = $toolsDir

# Chocolatey seems to copy the old lib folder in case of upgrade. Uninstall first.
$zipContentGlob=dir "$($installationPath)/.." "packetbeat-*.zip.txt"
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
  checksum      = 'eeb5dc8c80f773a5b98f5a8bd06310bd4201c60f6e449aa728a72998a15b24a638e4d535c88822f1bb140a81e3fd3f790dc73cc73c6471c2dd8cff2b960934ce'
  checksumType  = 'sha512'
  checksum64    = 'c9dcd51ed9c63d5921cedaf997d9ab3db1862a60fc9fae4583df43f1f3dd40a89ed0af01ac8e27f24e47bdc71b57edb3b884d4102e35d9e0e708d2075ebd84a6'
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
