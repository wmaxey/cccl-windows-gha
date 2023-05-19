Invoke-WebRequest -Uri "https://developer.download.nvidia.com/compute/cuda/12.1.0/network_installers/cuda_12.1.0_windows_network.exe" -OutFile "./cuda_network.exe" -UseBasicParsing
Start-Process -Wait -PassThru -FilePath .\cuda_network.exe -ArgumentList "-s nvcc_12.1 cudart_12.1"

$ENV:PATH="$ENV:PATH;C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.1\bin"
$ENV:CUDA_PATH="C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.1"

Remove-Item .\cuda_network.exe
