ARG ROOT_IMAGE

FROM $ROOT_IMAGE

ARG MSVC_VER
ARG MSVC_COMPILER_VER

ENV MSVC_COMPILER_VER=${MSVC_COMPILER_VER}
RUN /tools/install-compiler.ps1 -msvcVersion $ENV:MSVC_VER -clversion $ENV:MSVC_COMPILER_VER

ADD scripts/CCCLenv.psm1  /Users/ContainerAdministrator/Documents/WindowsPowerShell/Modules/CCCLenv/CCCLenv.psm1
ADD scripts/profile.ps1  /Users/ContainerAdministrator/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1
