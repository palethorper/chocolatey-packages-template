import-module au

$url = 'https://www.elastic.co/downloads/beats/auditbeat'
# $url = 'https://www.elastic.co/downloads/past-releases/auditbeat-6-6-0'
$packageName = 'auditbeat'

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
        };
        "$($packageName).nuspec" = @{
            "(<projectSourceUrl.*?)(\d+\.\d+)(.*?projectSourceUrl>)"    = "`${1}$([regex]::match($Latest.Version, "\d+\.\d+").Value)`${3}"
            "(<docsUrl.*?)(\d+\.\d+)(.*?docsUrl>)"    = "`${1}$([regex]::match($Latest.Version, "\d+\.\d+").Value)`${3}"
        };
     }
}

function global:au_GetLatest {
    $download_page = invoke-webrequest $url -UseBasicParsing -DisableKeepAlive

    $reVersion  = "\s*(\d+\.\d+\.\d+)\s*<\/div>"
    # $reVersion  = "\s*(\d+\.\d+\.\d+)\s*" # debug
    $download_page.Content -imatch $reVersion
    $version = $Matches[1]

    $links = $download_page.Links | ? { $_.href -imatch "zip" -and $_.href -notmatch "alpha|beta|-rc\d-" }

    $url32 = ($links | ? { $_.href -imatch "x86.zip$" }).href
    $url64 = ($links | ? { $_.href -imatch "x86_64.zip$" }).href

    $x = ($links | ? { $_.href -imatch "x86.zip" -and $_.href -match "zip\.(\w+)$" }).href
    $checksum32Type = $Matches[1]
    $checkSum32 = (Invoke-WebRequest ($x) -UseBasicParsing -DisableKeepAlive)
    $checkSum32 = [System.Text.Encoding]::Default.GetString($checkSum32.Content)
    ($checkSum32 | Out-String) -imatch "^\S+"
    $checkSum32 = $Matches[0]

    $x = ($links | ? { $_.href -imatch "x86_64.zip" -and $_.href -match "zip\.(\w+)$" }).href
    $checksum64Type = $Matches[1]
    $checkSum64 = (Invoke-WebRequest ($x) -UseBasicParsing -DisableKeepAlive)
    $checkSum64 = [System.Text.Encoding]::Default.GetString($checkSum64.Content)
    $checkSum64 = ($checkSum64 | Out-String) -imatch "^\S+"
    $checkSum64 = $Matches[0]

    $Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version; Checksum32 = $checkSum32; Checksum32Type = $checksum32Type; Checksum64 = $checkSum64; Checksum64Type = $checksum64Type; }
    return $Latest
}

update -ChecksumFor none
