Param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('2017', '2019', '2022')]
    [string[]]
    $msvcVersion,
    [Parameter(Mandatory=$false)]
    [string[]]
    $clVersion='latest'
)

Push-location "$PSScriptRoot"

$ENV:MSVC_COMPILER_VER=$clVersion

docker compose -f .\docker-compose.yml build windows-$msvcVersion --progress=plain
# Override defaults in .env with ENV vars above.
docker compose -f .\docker-compose.cl.yml build windows-extend-$msvcVersion --progress=plain

Pop-Location
