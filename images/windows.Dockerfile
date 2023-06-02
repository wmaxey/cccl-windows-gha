ARG ROOT_IMAGE="mcr.microsoft.com/windows/servercore:ltsc2022"

FROM $ROOT_IMAGE as prebuildenv

SHELL ["powershell.exe"]

ARG MSVC_VER

RUN Set-ExecutionPolicy Unrestricted -Scope CurrentUser
ADD ./ /tools

RUN /tools/install-tools.ps1 -msvcVersion $ENV:MSVC_VER
