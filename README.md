# meta-maaxboard

A meta-layer for Embest MaaXBoard.

> This is the "zeus" / Yocto 3.0.4 branch. The zeus branch can only support MaaXBoard Nano now, For MaaXBoard / MaaXBoard Mini, please checkout the "sumo" / Yocto 2.5.3 branch. The "zeus" branch will support MaaXBoard / MaaXBoard Mini in the end of Dec 2020.

## How to

### Install Host Yocto Development Env

You should have a linux machine, below instructions show how to setup the env on a Ubuntu:18.04 machine.

```bash
$ sudo apt-get update && sudo apt-get install -y \
        gawk \
        wget \
        git-core \
        diffstat \
        unzip \
        texinfo \
        gcc-multilib \
        build-essential \
        chrpath \
        socat \
        libsdl1.2-dev \
        xterm \
        sed \
        cvs \
        subversion \
        coreutils \
        texi2html \
        docbook-utils \
        python-pysqlite2 \
        help2man \
        make \
        gcc \
        g++ \
        desktop-file-utils \
        libgl1-mesa-dev \
        libglu1-mesa-dev \
        mercurial \
        autoconf \
        automake \
        groff \
        curl \
        lzop \
        asciidoc \
        u-boot-tools \
        cpio \
        sudo \
        locales
```

Install repo

```bash
sudo curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
sudo chmod a+x /usr/bin/repo
```

### Fetch the source

Download meta layers from NXP

```bash
mkdir imx-yocto-bsp
$ cd imx-yocto-bsp
$ repo init -u https://source.codeaurora.org/external/imx/imx-manifest -b imx-linux-zeus -m imx-5.4.24-2.1.0.xml
$ repo sync
```

Clone this repo and checkout to zeus branch

```bash
$ cd sources
$ git clone https://github.com/Avnet/meta-maaxboard.git
$ git checkout zeus
```

### Do patch

NXP do some hook / patch according different machine / distro when init a new build. We need do this first.

If you're going to build MaaXBoard Nano

```bash
$ cd imx-yocto-bsp
$ mkdir imx8mnevk
$ DISTRO=fsl-imx-wayland MACHINE=imx8mnevk source fsl-setup-release.sh -b imx8mnevk
$ rm -rf imx8mnevk
```

###  Build configure

```bash
$ cd imx-yocto-bsp
# Create the build directory
$ mkdir -p nano/build
# Create the default build conf in nano/build
$ source sources/poky/oe-init-build-env nano/build
```

### Upate local conf

You should update 2 conf file in the build directory(nano/build/conf/):

- local.conf
- bblayers.conf

We provide a sample under /meta-maaxboard/conf:

- local.conf.sample.nano for MaaXBoard Nano
- bblayers.conf.sample

> NOTE: variable 'BSPDIR' in bblayer.conf should be defined, the value should be the repo init directory. It is imx-yocto-bsp directory in above example

If you're going to build MaaXBoard Nano, you should change the Machine(in local.conf) to:

```ini
MACHINE ??= 'maaxboard-nano-ddr4-1g-sdcard'
```

### Build

```bash
$ cd /path/to/bsp_dir/
$ source sources/poky/oe-init-build-env nano/build

$ bitbake lite-image
```

### Flash sdcard

```bash
# This image will be generated under: /path/to/nano/build/tmp/deploy/images/maaxboard-nano-ddr4-1g-sdcard/lite-image-maaxboard-nano-ddr4-1g-sdcard-20201116084413.rootfs.wic.bz2
# unzip the bz2 file
$ bunzip2 lite-image-maaxboard-nano-*.rootfs.wic.bz2
## dd
$ sudo dd if=lite-image-maaxboard-nano-ddr4-1g-sdcard-20201116084413.rootfs.wic of=/dev/sda bs=10M conv=fsync
$ sync
```

### Power On

The default login is user 'root' with the password 'avnet'

### Build SDK

```bash
$ cd /path/to/bsp_dir/
$ source sources/poky/oe-init-build-env nano/build

$ bitbake lite-image -c populate_sdk
# The SDK will be generated under: /path/to/nano/build/tmp/deploy/sdk/
# fsl-imx-wayland-lite-glibc-x86_64-lite-image-aarch64-toolchain-5.4-zeus.sh
```

### Install the SDK on a Host to develop Kernel / U-Boot

First, You should get the SDK: fsl-imx-wayland-lite-glibc-x86_64-lite-image-aarch64-toolchain-5.4-zeus.sh

```bash
$ chmod +x fsl-imx-wayland-lite-glibc-x86_64-lite-image-aarch64-toolchain-5.4-zeus.sh
# Install
$ ./fsl-imx-wayland-lite-glibc-x86_64-lite-image-aarch64-toolchain-5.4-zeus.sh
```

## Configuration

- Distor: 'fsl-imx-wayland-lite'
    - meta-maaxboard/conf/distro/fsl-imx-wayland-lite.conf
- Image: "lite-image"
    - meta-maaxboard/images/lite-image.bb
- Machine:
    - MaaXBoard Nano: maaxboard-nano-ddr4-1g-sdcard

## Customization

- You could add more packages in the image recipe: meta-maaxboard/images/lite-image.bb
- Distro features: meta-maaxboard/conf/distro/fsl-imx-wayland-lite.conf
- Machine features: meta-maaxboard/conf/machine/maaxboard-ddr4-2g-sdcard.conf


## Setup a Debian Repository

Here we want to show you how to setup a Debian Repository. In this way, you could use `apt-get install` to install packages that you built in Yocto.

### Host Setup

This is the host machine that you build the Yocto images. If you want to setup a Debian repository, you should also install a web server here.

```bash
$ sudo apt install nginx
```

#### Build Packages

Before using `apt-get install` a package, you should first build it. Let's take nano for example.

```bash
$ cd /path/to/bsp_dir/
$ source sources/poky/oe-init-build-env maaxboard/build

$ bitbake nano
```

#### Generate Packages index files

After build the packages, you should generate the package index files for apt-get to search.

First, change to the deb directory:

```bash
$ cd /home/build/maaxboard-nano/nano/build/tmp/deploy/deb
$ ls
aarch64  aarch64-mx8mn  all  maaxboard_nano_ddr4_1g_sdcard
```
Add a script called dpkg-scan.sh

```bash
$ nano dpkg-scan.sh
```

Add

```bash
#!/bin/bash

ls -d */  | sed 's/\///' | cat | while IFS=' ' read -r item
do
    echo "[$item]"
    echo -e "\t- Delete pevious generated package info(./Package, ./Package.gz, ./Release)"
    rm -rf ${item}/Packages.gz ${item}/Packages ${item}/Release
    echo -e "\t- Scan Packages and generate Packages.gz"
    dpkg-scanpackages ${item} | gzip > ${item}/Packages.gz
done
```

```bash
$ sudo chmod +x ./dpkg-scan.sh
```

Exec ./dpkg-scan.sh everytime you build a new package:

```bash
./dpkg-scan.sh
```

#### Config web server

```bash
sudo nano /etc/nginx/sites-available/deb
```

Add

```
server {
    listen 80 default_server;
    server_name yocto_deb_packages;
    root /home/build/maaxboard/maaxboard-yocto/maaxboard/build/tmp/deploy/deb/;

    location / {
        autoindex on;
    }
}
```

Enable website

```bash
# Disable the nginx default site
$ sudo rm /etc/nginx/sites-enabled/default
$ sudo ln -s /etc/nginx/sites-available/deb /etc/nginx/sites-enabled/deb
```

#### Start / Stop nginx

```bash
$ sudo systemctl restart nginx
```

In your client web browser, check the website:

```
http://192.168.2.58/
```

### MaaXBoard Config

#### Add Sources List

```bash
$ sudo nano /etc/apt/sources.list
```

Add

```
deb http://192.168.2.58/ aarch64/
deb http://192.168.2.58/ aarch64-mx8mn/
deb http://192.168.2.58/ maaxboard_nano_ddr4_1g_sdcard/
deb http://192.168.2.58/ all/
```

#### apt-get update

```bash
$ sudo rm -rf /var/lib/apt/lists/*
$ sudo apt-get update
```

#### Install packages

```bash
sudo apt-get install nano
```