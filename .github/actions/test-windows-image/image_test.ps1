function TestReturnCode {
    if (-not $?) {
        throw 'Step Failed'
    }
}

Push-location "$PSScriptRoot"

$ErrorActionPreference = "Stop"

Write-Output "Test Ninja"
ninja --version
TestReturnCode

Write-Output "Test MSVC"
cl
TestReturnCode

Push-Location ~\
Write-Output "int main() {return 0;}" > .\test.cpp
cl .\test.cpp
TestReturnCode
Pop-Location

Write-Output "Test CMake"
cmake --version
TestReturnCode

Write-Output "Test NVCC"
nvcc --version
TestReturnCode

Push-Location ~
Write-Output "int main() {return 0;}" > .\test.cu
nvcc .\test.cu
TestReturnCode
Pop-Location

Pop-Location
