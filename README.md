# Brief Introduction



A meta-layer for MaaXBoard series boards

- Yocto Kirkstone(4.0) support:    MaaXBoard/MaaXBoard-Mini/MaaXBoard-Nano/MaaXBoard-8ULP



# Yocto Setup



## Host setup



To get the Yocto Project expected behavior in a Linux Host Machine, and the recommended minimum Ubuntu version is 20.04 or later. An important consideration is the hard disk space required in the host machine.  It is recommended that at least 250 GB is provided, which is enough to compile all backends together.

A Yocto Project build requires that some packages be installed for the build that are documented under the Yocto Project. Go to Yocto Project Quick Start and check for the packages that must be installed for your build machine. Essential Yocto Project host packages are:

```bash
$ sudo apt-get update && sudo apt-get install -y \
wget git-core diffstat unzip texinfo gcc-multilib \
build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
pylint3 xterm rsync curl gawk zstd lz4 locales bash-completion
```



## Repo setup



Repo is a tool built on top of Git that makes it easier to manage projects that contain multiple repositories, which do not need to be on the same server. Repo complements very well the layered nature of the Yocto Project, making it easier for users to add their own layers to the BSP.



Install or update **repo** to the latest version.

```bash
$ mkdir -p ~/bin
$ curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
$ chmod a+x ~/bin/repo
$ export PATH=~/bin:$PATH
```



Make sure that Git is set up properly with the following commands:

```bash
$ git config --global user.name "Your Name"
$ git config --global user.email "Your Email"
$ git config --list
```



## Yocto setup



The following example shows how to download the i.MX Yocto Project Community BSP recipe layers. For this example, a directory called imx-yocto-bsp is created for the project. Any name can be used instead of this.

```bash
$ mkdir -p ~/imx-yocto-bsp
$ cd ~/imx-yocto-bsp
$ repo init -u https://github.com/nxp-imx/imx-manifest -b imx-linux-kirkstone -m imx-5.15.71-2.2.0.xml
$ repo sync
```



When this process is completed, the source code is checked out into the directory imx-yocto-bsp/sources.  Then we need use following commands to clone this project (meta-maaxboard)  to `imx-yocto-bsp/sources` folder.

```bash
$ cd sources/
$ git clone https://github.com/Avnet/meta-maaxboard.git -b kirkstone meta-maaxboard
```



# Yocto Build



## Build configurations



**MaaXBoard** provides a script, ***maaxboard-setup.sh***, that simplifies the setup for MaaXBoard serial boards. To use the script, the name of the
specific machine to be built for needs to be specified. The script will sets up a directory and the configuration files for the specified machine.

The syntax for the  ***maaxboard-setup.sh*** script is shown below:

```bash
$ MACHINE=<machine name> source sources/meta-maaxboard/tools/maaxboard-setup.sh -b <build dir>
```

* MACHINE=<machine configuration name> is the machine name which points to the configuration file in conf/machine in
  meta-maaxboard.  Which should be  `maaxboard` , `maaxboard-mini`,  `maaxboard-nano` or `maaxboard-8ulp`.
* -b <build dir> specifies the name of the build directory created by the ***maaxboard-setup.sh*** script.



Take MaaXBoard board as example, we can use following command to setup the Yocto build environment.

```bash
$ cd ~/imx-yocto-bsp
$ MACHINE=maaxboard source sources/meta-maaxboard/tools/maaxboard-setup.sh -b maaxboard/build
```



If a new terminal window is opened or the machine is rebooted after a build directory is set up, the setup environment script should
be used to set up the environment variables and run a build again. The full ***maaxboard-setup.sh*** is not needed.

```bash
$ cd ~/imx-yocto-bsp
$ source sources/poky/oe-init-build-env maaxboard/build
```



## Build an image



The Yocto Project build uses the bitbake command. For example, bitbake <component> builds the named component. Each component build has multiple tasks, such as fetching, configuration, compilation, packaging, and deploying to the target rootfs.

The bitbake image build gathers all the components required by the image and build in order of the dependency per task. The first build is the toolchain along with the tools required for the components to build.  The following command is an example on how to build an image:

```bash
$ bitbake avnet-image-full
```



There are three images support in MaaXBoard serials.

* ***avnet-image-full***       Default system image with GCC, QT6, OpenCV  and GPU tools support;
* ***avnet-image-lite***       A lite system image without GCC, QT6, OpenCV  and GPU tools support;
* ***avnet-image-chromium***   A system image with chromium  browser support based on avnet-image-full;



After building, the output system images are located in `tmp/deploy/images/maaxboard`  :

* ***avnet-image-full-maaxboard.wic***         Yocto system image will be flashed into SD card or eMMC.
* ***avnet-image-full-maaxboard.tar.zst***     Root file system taball package
* ***imx-boot***                               Bootloader u-boot image



## Build a SDK



After building Yocto BSP, if you want to continue to build the toolchain installer and populate the SDK image, use the following command:

```bash
$ bitbake avnet-image-full -c populate_sdk
```



When building finished, you can get the avnet-image-full based SDK at  *`tmp/deploy/sdk/fsl-imx-wayland-lite-glibc-x86_64-avnet-image-full-armv8a-maaxboard-toolchain-5.15-kirkstone.sh`*. Later, if you want to to install the SDK, just run:

```bash
$ sudo bash tmp/deploy/sdk/fsl-imx-wayland-lite-glibc-x86_64-avnet-image-full-armv8a-maaxboard-toolchain-5.15-kirkstone.sh
NXP i.MX Release Distro SDK installer version 5.15-kirkstone
============================================================
Enter target directory for SDK (default: /opt/fsl-imx-wayland-lite/5.15-kirkstone):
You are about to install the SDK to "/opt/fsl-imx-wayland-lite/5.15-kirkstone". Proceed [Y/n]? y
Extracting SDK.............................done
Setting it up...done
SDK has been successfully set up and is ready to be used.
```



Each time you wish to use the SDK in a new shell session, you need to source the environment setup script e.g.

```bash
$ . /opt/fsl-imx-wayland-lite/5.15-kirkstone/environment-setup-armv8a-poky-linux
```

