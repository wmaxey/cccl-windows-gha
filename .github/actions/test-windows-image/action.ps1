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

.\images\vs-version-matrix.ps1

$clList = $vsVersionMatrix["$vs"]
foreach($cl in $clList) {
    Write-Output "Launching $image-$cl"
    # Concatenate compiler version to image and test
    docker run --mount type=bind,src="$(Get-Location)\.github\actions\test-windows-image",dst="C:\test" $image-$cl powershell "C:\test\image-test.ps1"
    TestReturnCode
}
