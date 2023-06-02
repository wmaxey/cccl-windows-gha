# Building Docker containers on Windows

This Dockerfile can be built and then ran while mapped to your workspace to help with building applications on Windows.
This process removes much of the difficulty in assembling a workspace compatible with several CCCL projects.

## Caveats

It is easy to be successful with hyperv enabled, however the true potential of the container can be 
achieved when `--isolation=process` is used. This requires either Windows 11 or Server editions of Windows.

## Building the container

### Step 0
If you are developing and testing, [install docker-desktop.](https://docs.docker.com/desktop/) If you are worried about 
deployment you may need to 
[install Docker Engine](https://docs.docker.com/engine/install/binaries/#install-server-and-client-binaries-on-windows)
manually. Regardless whatever option allows you to invoke Docker from the shell is required.

### Step 1

Prepare to wait, a long time, and execute the build step.

`$> docker build --pull --rm -f "docker\msvc\msvc.Dockerfile" -t MyWinEnv:latest "docker\msvc"`

### Step 2

Start up the container and mount your work directory.

`$> docker run --mount type=bind,src=C:\absolut\vodka\path,dst=C:\workspace\ -it MyWinEnv powershell.exe`

### Step 3 - Pick a flavor

Now that you are in a shell, we need to pick a MSVC environment. A powershell module that handles this has been
pre-loaded to assist with this.

`$> Get-VSDevPrompt 14.xy`

Inspect msvc/resources/env_config.psm1 to see which compilers are available, this will occasionally get updated to
support new versions as they are released.

### Step 4 - Build your projects

The environment will be configured to use the compiler you selected, and NVCC will be already set into the PATH.
No hacks necessary to make Thrust build (fingers crossed.)

`$> cmake -S thrust -B build -G Ninja`
`$> ninja -C build thrust.tests`