Param(
    [Parameter(Mandatory=$true)]
    [string[]]
    $image,
    [Parameter(Mandatory=$true)]
    [ValidateSet('2017', '2019', '2022')]
    [string[]]
    $vs
)

function TestReturnCode {
    if (-not $?) {
        throw 'Step Failed'
    }
}

Push-Location "$PSScriptRoot"

..\..\..\images\vs_version_matrix.ps1

$clList = $vsVersionMatrix["$vs"]
foreach($cl in $clList) {
    # Concatenate compiler version to image and test
    docker run --mount type=bind,src=$(pwd),dst=C:\test $image-$cl "C:\test\.github\actions\test-windows-image\image-test.ps1"
    TestReturnCode
}

Pop-Location
