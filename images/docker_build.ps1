Param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('2017', '2019', '2022')]
    [string[]]
    $msvcVersion,
    [Parameter(Mandatory=$false)]
    [ValidateSet('windows', 'windows-server')]
    [string[]]
    $edition="windows"
)

Push-location "$PSScriptRoot"

# Source version matrix
./vs_version_matrix.ps1

docker compose -f .\docker-compose.yml build $edition-$msvcVersion --progress=plain

# Build each subcompiler version
$clList = $vsVersionMatrix["$msvcVersion"]
foreach($cl in $clList) {
    Write-Output "Building $msvcVersion - $cl"
    # Override defaults in .env.
    $ENV:WIN_IMAGE=$edition
    $ENV:MSVC_COMPILER_VER=$cl
    docker compose -f .\docker-compose.cl.yml build windows-extend-$msvcVersion --progress=plain
}

Pop-Location
