$ErrorActionPreference = 'Stop';

$packageName= 'metricbeat'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.1.3-windows-x86.zip'
$url64      = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.1.3-windows-x86_64.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  url           = $url
  url64bit      = $url64
  checksum      = '42ecf33ac7be6b00350e28e47749335a9fdaf3b6443b06752a73054564b2045054d1c7615bda6f9e36a1ccdf3ec1f4f2888068315aee462f0aef514487c005e8'
  checksumType  = 'sha512'
  checksum64    = '493384b2f97b627042fa864fc9c59d3843c073b83f9ee14501570099b94f6b89c793bee3e26cdbc8fb863e1b7bcc0f978c0fe0d9db3f29f4842d56c9abcae0d1'
  checksumType64= 'sha512'
}

Install-ChocolateyZipPackage @packageArgs

$pTemp = (dir $installationPath  $packageName*).Name
Invoke-Expression $(Join-Path $installationPath "$($pTemp)\install-service-$($packageName).ps1")
