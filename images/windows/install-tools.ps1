Param(
    [Parameter(Mandatory=$true)]
    [string[]]
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

./scripts/clear-temp.ps1

Pop-Location
