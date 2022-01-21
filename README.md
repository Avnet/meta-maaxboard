# meta-maaxboard

A meta-layer for MaaXBoard series boards
> 

Yocto hardknott 3.3 support:        MaaXBoard Nano

Yocto zeus 3.0 support:             MaaXBoard / MaaXBoard Mini / MaaXBoard Nano

Yocto sumo 2.5 support:             MaaXBoard / MaaXBoard Mini



## How to

### Install Host Yocto Development Env

You should have a linux machine, below instructions show how to setup the env on a Ubuntu:20.04 machine.

```bash
$ sudo apt-get update && sudo apt-get install -y \
wget git-core diffstat unzip texinfo gcc-multilib \
build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
pylint3 xterm rsync curl locales bash-completion
```

Install repo

```bash
$ curl https://storage.googleapis.com/git-repo-downloads/repo > ./repo
$ chmod a+x repo
$ sudo mv repo /usr/bin/
```

Set Git configuration:
```bash
$ git config --global user.name "Your Name"
$ git config --global user.email "you@example.com"
```

### Fetch the source

Download meta layers from NXP

```bash
$ mkdir ~/imx-yocto-bsp
$ cd ~/imx-yocto-bsp
$ repo init -u https://source.codeaurora.org/external/imx/imx-manifest -b imx-linux-hardknott -m imx-5.10.35-2.0.0.xml
$ repo sync
```

Clone this repo and checkout to hardknott branch

```bash
$ cd ~/imx-yocto-bsp/sources/
$ git clone https://github.com/Avnet/meta-maaxboard.git -b hardknott
```

### Build

```bash
$ cd ~/imx-yocto-bsp
$ MACHINE=maaxboard-nano source sources/meta-maaxboard/tools/maaxboard-setup.sh -b maaxboard-nano/build
$ bitbake lite-image
```

For more information, please refer to MaaXBoard-Nano-Linux-Yocto-Lite-Development_Guide

