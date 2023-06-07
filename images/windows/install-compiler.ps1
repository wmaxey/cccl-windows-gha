Param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('15', '16', '17')]
    [string[]]
    $msvcVersion,
    [Parameter(Mandatory=$false)]
    [string[]]
    $clVersion='latest'
)

$ErrorActionPreference='Stop'

Push-location "$PSScriptRoot"

## Save the current environment without MSVC plugged in
New-Item -ItemType Directory -Path "$HOME" -Name "cccl_env"

# Filter these non-portable exported environment variables
$envFilter = `
    "COMPUTERNAME","TEMP","TMP","SystemDrive","SystemRoot","USERNAME","USERPROFILE",`
    "APPDATA","LOCALAPPDATA","NUMBER_OF_PROCESSORS","PROCESSOR_ARCHITECTURE",`
    "PROCESSOR_IDENTIFIER","PROCESSOR_LEVEL","PROCESSOR_REVISION","OS"

$ENV:INSTALLED_MSVC_VERSION=$msvcVersion
Get-ChildItem ENV: | Where-Object { $_.Name -notin $envFilter } | Export-CliXml "$HOME\cccl_env\env-var.clixml"

## Install older vs cl
./scripts/install-vs.ps1 -msvcVersion $msvcVersion -clVersion $clVersion
./scripts/clear-temp.ps1

Pop-Location
