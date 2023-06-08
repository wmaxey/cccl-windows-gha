# msvcVersion, cudaVersion, OS edition, isolation mode
Param(
    [Parameter(Mandatory=$true)]
    [string]
    $clVersion,
    [Parameter(Mandatory=$false)]
    [string]
    $cudaVersion="latest",
    [Parameter(Mandatory=$false)]
    [string]
    $edition="windows",
    [Parameter(Mandatory=$false)]
    [string]
    $isolation="hyperv",
    [Parameter(Mandatory=$true)]
    [string]
    $repo
)

Write-Output "${repo}:${edition}-${isolation}-cuda-${cudaVersion}-cl-${clVersion}"
