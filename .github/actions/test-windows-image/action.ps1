Param(
    [Parameter(Mandatory=$true)]
    [string]
    $msvcVersion,
    [Parameter(Mandatory=$true)]
    [string]
    $cudaVersion="latest",
    [Parameter(Mandatory=$true)]
    [string]
    $edition="windows",
    [Parameter(Mandatory=$true)]
    [string]
    $isolation="hyperv",
    [Parameter(Mandatory=$true)]
    [string]
    $repo
)

function TestReturnCode {
    if (-not $?) {
        throw 'Step Failed'
    }
}

$ErrorActionPreference = "Stop"

# Assume this script is launched from repo root.
./images/vs-version-matrix.ps1
$clVerArray = ($vsVerToCompilers[$msvcVersion])

foreach($cl in $clVerArray) {
    $image=$(./images/generate-image-name -clVersion $cl -isolation $isolation -cudaVersion $cudaVersion -edition $edition -repo $repo)
    Write-Output "Testing $image"

    docker run --mount type=bind,src="$(Get-Location)\.github\actions\test-windows-image",dst="C:\test" $image powershell "C:\test\image-test.ps1"
    TestReturnCode
}
