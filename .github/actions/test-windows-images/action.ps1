function TestReturnCode {
    if (-not $?) {
        throw 'Step Failed'
    }
}

Push-location "$PSScriptRoot"

$ErrorActionPreference = "Stop"

Get-VSDevPrompt

Write-Output "Test Ninja"
ninja --version
TestReturnCode

Write-Output "Test MSVC"
cl
TestReturnCode

echo "int main() {return 0;}" > $ENV:TEMP/test.cpp
Push-Location $ENV:TEMP
cl $ENV:TEMP/test.cpp
TestReturnCode
Pop-Location

Write-Output "Test CMake"
cmake --version
TestReturnCode

Write-Output "Test NVCC"
nvcc --version
TestReturnCode

echo "int main() {return 0;}" > $ENV:TEMP/test.cu
Push-Location $ENV:TEMP
nvcc $ENV:TEMP/test.cu
TestReturnCode
Pop-Location

Pop-Location
