Param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('15', '16', '17')]
    [string[]]
    $msvcVersion
)

$msvcPath = "C:\msbuild\$msvcVersion"

Invoke-WebRequest -Uri "https://aka.ms/vs/$msvcVersion/release/vs_buildtools.exe" -UseBasicParsing -OutFile .\vs_buildtools.exe
Start-Process -NoNewWindow -PassThru -Wait -FilePath .\vs_buildtools.exe -ArgumentList "install --installWhileDownloading --installPath $msvcPath --wait --norestart --nocache --quiet --config $pwd\resources\$msvcVersion\.vsconfig"

Remove-Item .\vs_buildtools.exe
