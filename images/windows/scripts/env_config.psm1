$EnvVarBackup = (Resolve-Path -path "$ENV:TEMP\cccl_env\env-var.clixml" | % {$_ -replace '\\','/'})
# Import the pre-configured environment
Import-CliXml $EnvVarBackup | % { Write-Output "Setting Var: $($_.Name)=$($_.Value)"; Set-Item -force -path "env:$($_.Name)" $_.Value }

$MSBuildPath = "C:\msbuild"

$MSBuildPathMap = @{
    "14.11"="$MSBuildPath\15\VC\Auxiliary\Build"
    "14.12"="$MSBuildPath\15\VC\Auxiliary\Build"
    "14.13"="$MSBuildPath\15\VC\Auxiliary\Build"
    "14.14"="$MSBuildPath\15\VC\Auxiliary\Build"
    "14.15"="$MSBuildPath\15\VC\Auxiliary\Build"
    "14.16"="$MSBuildPath\15\VC\Auxiliary\Build"
    "14.20"="$MSBuildPath\16\VC\Auxiliary\Build"
    "14.21"="$MSBuildPath\16\VC\Auxiliary\Build"
    "14.22"="$MSBuildPath\16\VC\Auxiliary\Build"
    "14.23"="$MSBuildPath\16\VC\Auxiliary\Build"
    "14.24"="$MSBuildPath\16\VC\Auxiliary\Build"
    "14.25"="$MSBuildPath\16\VC\Auxiliary\Build"
    "14.26"="$MSBuildPath\16\VC\Auxiliary\Build"
    "14.27"="$MSBuildPath\16\VC\Auxiliary\Build"
    "14.28"="$MSBuildPath\16\VC\Auxiliary\Build"
    "14.28.29333"="$MSBuildPath\16\VC\Auxiliary\Build"
    "14.28.29910"="$MSBuildPath\16\VC\Auxiliary\Build"
    "14.29"="$MSBuildPath\16\VC\Auxiliary\Build"
    "14.29.30037"="$MSBuildPath\16\VC\Auxiliary\Build"
    "14.29.30133"="$MSBuildPath\16\VC\Auxiliary\Build"
    "14.30"="$MSBuildPath\17\VC\Auxiliary\Build"
    "14.31"="$MSBuildPath\17\VC\Auxiliary\Build"
    "14.32"="$MSBuildPath\17\VC\Auxiliary\Build"
    "14.33"="$MSBuildPath\17\VC\Auxiliary\Build"
    "14.34"="$MSBuildPath\17\VC\Auxiliary\Build"
    "14.35"="$MSBuildPath\17\VC\Auxiliary\Build"
}

function Get-VSDevPrompt {
    param([string]$vcver = "14.3")
    if (Test-Path -Path $EnvVarBackup) {
        Remove-Item -Path "ENV:*"
        Import-CliXml $EnvVarBackup | % { Set-Item -force -path "env:$($_.Name)" $_.Value }
    }

    # Save all the process' environment variables in CLIXML format.
    $BuildPath = $MSBuildPathMap[$vcver]
    Write-Output "Loading VC from: $BuildPath"

    Push-Location "$BuildPath"
    cmd /c "vcvars64.bat -vcvars_ver=$vcver & set" |
        foreach {
            if ($_ -match "=") {
                $v = $_.split("="); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
            }
        }
    Pop-Location

    # Stupid, but makes cl.exe happy
    $global:CC_FP = $(get-command cl).Source.Replace("\","/")

    Write-Host "`nVisual Studio Command Prompt variables set." -ForegroundColor Yellow
    Write-Host "Use `$CC_FP as shortcut for Cmake: $CC_FP" -ForegroundColor Yellow
}

Get-VSDevPrompt 14.35

Export-ModuleMember -Function Get-VSDevPrompt
