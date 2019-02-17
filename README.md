# ParaView Ubuntu Docker Image

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Build Status](https://travis-ci.org/lhofmann/paraview-ubuntu-docker.svg?branch=master)](https://travis-ci.org/lhofmann/paraview-ubuntu-docker)

This docker image contains the [Ubuntu paraview package](https://packages.ubuntu.com/search?keywords=paraview) built from source using `debuild` including build artifacts (in directory `/home/paraview/paraview`). In this environment, external ParaView plugins can be built, which will then be compatible with the paraview package of the specific Ubuntu version. The plugins can be distributed either as single .so files or as .deb packages, which have the paraview package as dependency.

Prebuilt docker images can be found on [Docker Hub](https://hub.docker.com/r/lhofmann/paraview-ubuntu). If you want to build your own docker images, see the instructions below.

## Usage

An example plugin is provided in [shared/example/](shared/example/). The following steps will build this plugin using Ubuntu 18.04.

Start a detached container with name `build` and with the directory `./shared/` mounted to `/mnt/shared`
```bash
docker run -itd --name build --volume="$(pwd)/shared:/mnt/shared:rw" lhofmann/paraview-ubuntu:18.04
```

Run cmake and build the target `package`
```bash
docker exec build cmake -B/mnt/shared/build -H/mnt/shared/example 
docker exec build cmake --build /mnt/shared/build --target package
```

The built plugin will be in `shared/build/libExamplePlugin.so` and `shared/build/Example-0.1.0-Linux.deb`.

### CMake

For distributing .so files, set `CMAKE_BUILD_WITH_INSTALL_RPATH=TRUE` in your CMake config. A debian package can be built using CPack by installing the plugin to `/usr/lib/paraview/plugins` (any .so in this directory is automatically loaded by ParaView). See [shared/example/CMakeLists.txt](shared/example/CMakeLists.txt) for a full example.

## Building the docker images

As default, a Ubuntu 18.04 is built:

```bash
docker build --rm -t "paraview-ubuntu:18.04" .
```

The build argument `ubuntu_version` can be used to specify the Ubuntu version, for example 16.04:

```bash
docker build --rm -t "paraview-ubuntu:16.04" --build-arg ubuntu_version="16.04" .
```
