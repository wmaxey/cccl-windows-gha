Param(
    [Parameter(Mandatory=$true)]
    [string]
    $cudaVersion
)

$ErrorActionPreference='Stop'

## Make sure the script is local to the directory here.
Push-location "$PSScriptRoot"

## Source and install the below
./scripts/install-cuda.ps1 -cudaVersion $cudaVersion
./scripts/install-lit.ps1
./scripts/install-cmake.ps1
./scripts/install-ninja.ps1

## Save the current environment without MSVC plugged in
New-Item -ItemType Directory -Path "$HOME" -Name "build-env"

# Filter these non-portable exported environment variables
$envFilter = `
    "COMPUTERNAME","TEMP","TMP","SystemDrive","SystemRoot","USERNAME","USERPROFILE",`
    "APPDATA","LOCALAPPDATA","NUMBER_OF_PROCESSORS","PROCESSOR_ARCHITECTURE",`
    "PROCESSOR_IDENTIFIER","PROCESSOR_LEVEL","PROCESSOR_REVISION","OS"

$ENV:INSTALLED_MSVC_VERSION=$msvcVersion
Get-ChildItem ENV: | Where-Object { $_.Name -notin $envFilter } | Export-CliXml "$HOME\build-env\env-var.clixml"

./scripts/clear-temp.ps1

Pop-Location
