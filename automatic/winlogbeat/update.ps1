import-module au

$url = 'https://www.elastic.co/downloads/beats/winlogbeat'
$packageName = 'winlogbeat'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^\s*[$]packageName\s*=\s*)(['""].*['""])"      = "`$1'$($packageName)'"
            "(^\s*[$]url64\s*=\s*)(['""].*['""])"      = "`$1'$($Latest.URL64)'"
            "(^\s*[$]url\s*=\s*)(['""].*['""])"      = "`$1'$($Latest.URL32)'"
            "(^\s*[$]*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^\s*[$]*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^\s*[$]*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32Type)'"
            "(^\s*[$]*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64Type)'"
        };
        'tools\chocolateyUnInstall.ps1' = @{
            "(^\s*[$]packageName\s*=\s*)(['""].*['""])"      = "`$1'$($packageName)'"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $url

    $reVersion  = ">(\d+.\d+.\d+)<"
    $download_page.Content -imatch $reVersion
    $version = $Matches[1]

    $links = $download_page.Links | ? { $_.href -imatch "zip" }

    $url32 = ($links | ? { $_.href -imatch "x86.zip$" }).href
    $url64 = ($links | ? { $_.href -imatch "x86_64.zip$" }).href

    $x = ($links | ? { $_.href -imatch "x86.zip" -and $_.href -match "zip\.(\w+)$" }).href
    $checksum32Type = $Matches[1]
    $checkSum32 = (Invoke-WebRequest ($x))
    $checkSum32 = [System.Text.Encoding]::Default.GetString($checkSum32.Content)

    $x = ($links | ? { $_.href -imatch "x86_64.zip" -and $_.href -match "zip\.(\w+)$" }).href
    $checksum64Type = $Matches[1]
    $checkSum64 = (Invoke-WebRequest ($x))
    $checkSum64 = [System.Text.Encoding]::Default.GetString($checkSum64.Content)

    $Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version; Checksum32 = $checkSum32; Checksum32Type = $checksum32Type; Checksum64 = $checkSum64; Checksum64Type = $checksum64Type; }
    return $Latest
}

update -ChecksumFor none
