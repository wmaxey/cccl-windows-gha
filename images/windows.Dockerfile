ARG ROOT_IMAGE="mcr.microsoft.com/windows/servercore:ltsc2022"

FROM $ROOT_IMAGE as prebuildenv

SHELL ["powershell.exe"]
ENTRYPOINT [ "powershell.exe" ]

ARG MSVC_VER

RUN Set-ExecutionPolicy Unrestricted -Scope CurrentUser
ADD ./ /tools

RUN /tools/install-tools.ps1 -msvcVersion $ENV:MSVC_VER

ADD scripts/CCCLenv.psm1  /Users/ContainerAdministrator/Documents/WindowsPowerShell/Modules/CCCLenv/CCCLenv.psm1
ADD scripts/profile.ps1  /Users/ContainerAdministrator/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1
