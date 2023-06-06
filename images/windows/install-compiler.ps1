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
Set-PSDebug -Trace 2

Push-location "$PSScriptRoot"

## Install older vs cl
./scripts/install-vs.ps1 -msvcVersion $msvcVersion -clVersion $clVersion
./scripts/clear-temp.ps1

Pop-Location
