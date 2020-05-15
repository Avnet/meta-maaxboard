# meta-maaxboard

A meta-layer for Embest MaaXBoard.

## How to

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
$ git clone https://github.com/ahnniu/meta-maaxboard
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

## Customization

- You could add more packages in the image recipe: meta-maaxboard/images/lite-image.bb
- Distro features: meta-maaxboard/conf/distro/fsl-imx-wayland-lite.conf
- Machine features: meta-maaxboard/conf/machine/maaxboard-ddr4-2g-sdcard.conf