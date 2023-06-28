# Setting up Windows Containers on Windows

These are instructions for configuring Windows to launch WCoW images for local development with CUDA and MSVC.

## Caveats

It is easy to be successful with hyperv enabled, however the true potential of the container can be
achieved when `--isolation=process` is used. This requires either Windows 11 or Server editions of Windows.

## Setting up Docker on Windows

If you are developing and testing, [install docker-desktop.](https://docs.docker.com/desktop/) If you are worried about
deployment you may need to
[install Docker Engine](https://docs.docker.com/engine/install/binaries/#install-server-and-client-binaries-on-windows)
manually. Regardless, either option allows you to invoke Docker from the shell is required.

To install Docker Engine via script:

```
## Invoke from within an elevated Powershell prompt
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1" -o install-docker-ce.ps1
.\install-docker-ce.ps1
## Fetch docker-compose plugin
Invoke-WebRequest -UseBasicParsing "https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-windows-x86_64.exe" -o $Env:ProgramFiles\Docker\docker-compose.exe
```

If issuing docker commands from a non-elevated prompt, you may need to add yourself to the `docker` group or modify the
Docker config: `daemon.json` appropriately to include the group you belong to.

## Launching Windows configurations:

Start up the container and mount workspace directories as needed.

`$> docker run --mount type=bind,src="$(pwd)",dst="C:\thrust" -it ${ImageRepo}:windows-cuda-12.1-cl-14.36 powershell`
