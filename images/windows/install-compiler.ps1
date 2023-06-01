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

## Install cl
./scripts/install-cl.ps1 -msvcVersion $msvcVersion -clVersion $clVersion
./scripts/clear-temp.ps1

Pop-Location
