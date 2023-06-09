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
    $edition,
    [Parameter(Mandatory=$true)]
    [string]
    $repo
)

Write-Output "${repo}:${edition}-cuda-${cudaVersion}-cl-${clVersion}"
