# meta-maaxboard

A meta-layer for Embest MaaXBoard.

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
$ repo init -u https://source.codeaurora.org/external/imx/imx-manifest -b imx-linux-sumo -m imx-4.14.98-2.2.0.xml
$ repo sync
```

Clone this repo

```bash
$ cd sources
$ git clone http://192.168.2.149/imx8m/meta-maaxboard.git
```

### Do patch

NXP do some hook / patch according different machine / distro when init a new build. We need do this first.

If you're going to build MaaXBoard

```bash
$ cd imx-yocto-bsp
$ mkdir imx8mqevk
$ DISTRO=fsl-imx-wayland MACHINE=imx8mqevk source fsl-setup-release.sh -b imx8mqevk
$ rm -rf imx8mqevk
```

Or if you're going to build MaaXBoard Mini

```bash
$ cd imx-yocto-bsp
$ mkdir imx8mmevk
$ DISTRO=fsl-imx-wayland MACHINE=imx8mmevk source fsl-setup-release.sh -b imx8mmevk
$ rm -rf imx8mmevk
```

###  Build configure

```bash
$ cd imx-yocto-bsp
# Create the build directory
$ mkdir -p maaxboard/build
# Create the default build conf in maaxboard/build
$ source sources/poky/oe-init-build-env maaxboard/build
```

### Upate local conf

You should update 2 conf file in the build directory(maaxboard/build/conf/):

- local.conf
- bblayers.conf

We provide a sample under /meta-maaxboard/conf:

- local.conf.sample
- bblayers.conf.sample

> NOTE: variable 'BSPDIR' in bblayer.conf should be defined, the value should be the repo init directory. It is imx-yocto-bsp directory in above example

If you're going to build MaaXBoard Mini, you should change the Machine(in local.conf) to:

```ini
MACHINE ??= 'maaxboard-mini-ddr4-2g-sdcard'
```

### Build

```bash
$ cd /path/to/bsp_dir/
$ source sources/poky/oe-init-build-env maaxboard/build

$ bitbake lite-image
```

### Flash sdcard

```bash
# This image will be generated under: /path/to/build/tmp/deploy/images/maaxboard-ddr4-2g-sdcard/lite-image-maaxboard-ddr4-2g-sdcard-20200515065319.rootfs.sdcard.bz2
# unzip the bz2 file
$ bunzip2 lite-image-maaxboard-*.rootfs.sdcard.bz2
## dd
$ sudo dd if=lite-image-maaxboard-ddr4-2g-sdcard-20200515065319.rootfs.sdcard of=/dev/sda bs=10M conv=fsync
$ sync
```

### Power On

The default login is user 'root' with the password 'avnet'

## Configuration

- Distor: 'fsl-imx-wayland-lite'
    - meta-maaxboard/conf/distro/fsl-imx-wayland-lite.conf
- Image: "lite-image"
    - meta-maaxboard/images/lite-image.bb
- Machine:
    - MaaXBoard: maaxboard-ddr4-2g-sdcard
    - MaaXBoard Mini: maaxboard-mini-ddr4-2g-sdcard

## Customization

- You could add more packages in the image recipe: meta-maaxboard/images/lite-image.bb
- Distro features: meta-maaxboard/conf/distro/fsl-imx-wayland-lite.conf
- Machine features: meta-maaxboard/conf/machine/maaxboard-ddr4-2g-sdcard.conf