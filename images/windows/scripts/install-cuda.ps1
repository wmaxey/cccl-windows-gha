Param(
    [Parameter(Mandatory=$false)]
    [string[]]
    $cudaVersion="latest"
)

$cudaVersionMap = @{
    "11.0"="11.0"
    "12.1"="12.1.1"
    "12.1.1"="12.1.1"
    "latest"="12.1.1"
}

$cudaVersionURI = "https://developer.download.nvidia.com/compute/cuda/${cudaVersionMap[$cudaVersion]}/network_installers/${cudaVersionMap[$cudaVersion]}_windows_network.exe"

Invoke-WebRequest -Uri "" -OutFile "./cuda_network.exe" -UseBasicParsing
Start-Process -Wait -PassThru -FilePath .\cuda_network.exe -ArgumentList "-s nvcc_12.1 cudart_12.1"

$ENV:PATH="$ENV:PATH;C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.1\bin"
$ENV:CUDA_PATH="C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.1"

Remove-Item .\cuda_network.exe
