# meta-maaxboard

A meta-layer for MaaXBoard series boards

- Yocto honister 3.4 support:            MaaXBoard 8ULP



## How to

### Install Host Yocto Development Env

You should have a linux machine, below instructions show how to setup the env on a Ubuntu:20.04 machine.

```bash
$ sudo apt-get update && sudo apt-get install -y \
wget git-core diffstat unzip texinfo gcc-multilib \
build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
pylint3 xterm rsync curl gawk zstd lz4 locales bash-completion
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
$ repo init -u https://source.codeaurora.org/external/imx/imx-manifest -b imx-linux-honister -m imx-5.15.5-1.0.0.xml
$ repo sync
```

Clone this repo and checkout to honister branch

```bash
$ cd ~/imx-yocto-bsp/sources/
$ git clone https://github.com/Avnet/meta-maaxboard.git -b honister_maaxboard-8ulp
```

### Build

Create a new build folder and set the configuration for the first time, run the command:

```bash
$ cd ~/imx-yocto-bsp
$ MACHINE=maaxboard-8ulp source sources/meta-maaxboard/tools/maaxboard-setup.sh -b maaxboard-8ulp/build
$ bitbake lite-image
```

If you want to build in an existing build folder, use the following command:

```bash
$ cd ~/imx-yocto-bsp
$ source sources/poky/oe-init-build-env maaxboard-8ulp/build
```

For more information, please refer to Yocto Development Guide.

