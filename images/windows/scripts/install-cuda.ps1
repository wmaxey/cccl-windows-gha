Param(
    [Parameter(Mandatory=$false)]
    [string[]]
    $cudaVersion="latest"
)

$cudaUri = @{
    # Why did the names change???
    "11.0"="11.0.2/network_installers/cuda_11.0.2_win10_network.exe"
    "12.1"="12.1.1/network_installers/cuda_12.1.1_windows_network.exe"
    "12.1.0"="12.1.0/network_installers/cuda_12.1.0_windows_network.exe"
    "12.1.1"="12.1.1/network_installers/cuda_12.1.1_windows_network.exe"
    "latest"="12.1.1/network_installers/cuda_12.1.1_windows_network.exe"
}[$cudaVersion]

$componentTag = @{
    "11.0"="11.0"
    "12.1"="12.1"
    "12.1.0"="12.1"
    "12.1.1"="12.1"
    "latest"="12.1"
}

$cudaVersionUrl = "https://developer.download.nvidia.com/compute/cuda/$cudaUri"

Invoke-WebRequest -Uri "$cudaVersionUrl" -OutFile "./cuda_network.exe" -UseBasicParsing
Start-Process -Wait -PassThru -FilePath .\cuda_network.exe -ArgumentList "-s nvcc_${componentTag} cudart_${componentTag}"

$ENV:PATH="$ENV:PATH;C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v${componentTag}\bin"
$ENV:CUDA_PATH="C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v${componentTag}"

Remove-Item .\cuda_network.exe
