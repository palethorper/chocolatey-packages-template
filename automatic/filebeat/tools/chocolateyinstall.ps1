$ErrorActionPreference = 'Stop';

$packageName= 'filebeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.6.0-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.6.0-windows-x86_64.zip'

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
  checksum      = 'f99ca1d88ac76f2d283d9a03886b396fd825f34935ecb924c55c34d6440883e67c77b49b8139150794ded5b5fe5eb60a3e87a06d1ff438a681197a1c29aa467a'
  checksumType  = 'sha512'
  checksum64    = '6107fa476c81b46a40938fdd7560c4de8be28fa33b9346bf3e91dd9dbdbaf0bf740e45903f9d866eab4525bdd48d5d1876cf3be0e19b55d7aab08b0dd5753f87'
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
