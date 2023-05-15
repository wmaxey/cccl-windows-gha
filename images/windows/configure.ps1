Param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('15', '16', '17')]
    [string[]]
    $msvcVersion
)

$ErrorActionPreference='Stop'
Set-PSDebug -Trace 2


## Make sure the script is local to the directory here.
Push-location "$PSScriptRoot"

## Source and install the below
./scripts/install-cuda.ps1
./scripts/install-lit.ps1
./scripts/install-cmake.ps1
./scripts/install-ninja.ps1

## Save the current environmet without MSVC plugged in
New-Item -ItemType Directory -Path "$ENV:TEMP" -Name "cccl_env"
Get-ChildItem env: | Export-CliXml "$ENV:TEMP\cccl_env\env-var.clixml"

## Install MSVC
./scripts/install-vs.ps1 -msvcVersion $msvcVersion

Pop-Location
