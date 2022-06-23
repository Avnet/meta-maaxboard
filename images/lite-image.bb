SUMMARY = "A console lite image for production"
LICENSE = "MIT"

inherit core-image

# additional free disk space created in Kbytes
#IMAGE_OVERHEAD_FACTOR = "1.0"
#IMAGE_ROOTFS_EXTRA_SPACE = "512000"

## Select Image Features
IMAGE_FEATURES += " \
    ssh-server-openssh \
    hwcodecs \
    package-management \
"

DOCKER ?= ""
DOCKER:mx8 = "docker"

CORE_IMAGE_EXTRA_INSTALL += " \
    packagegroup-core-full-cmdline \
    packagegroup-tools-bluetooth \
    packagegroup-fsl-tools-audio \
    packagegroup-fsl-tools-gpu \
    packagegroup-fsl-tools-gpu-external \
    packagegroup-fsl-tools-testapps \
    packagegroup-fsl-tools-benchmark \
    packagegroup-imx-isp \
    packagegroup-imx-security \
    packagegroup-fsl-gstreamer1.0 \
    packagegroup-fsl-gstreamer1.0-full \
    firmwared \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'weston-init', '', d)} \
    ${DOCKER} \
"

inherit populate_sdk_qt6_base

CONFLICT_DISTRO_FEATURES = "directfb"
CORE_IMAGE_EXTRA_INSTALL:append = " packagegroup-qt6-imx tzdata "

EXTRA_GCC_TOOL ?= ""
EXTRA_GCC_TOOL:mx8 = " \
    gcc \
    gcc-symlinks \
    binutils \
    automake \
    autoconf \
"

CORE_IMAGE_EXTRA_INSTALL:append = " \
    ${EXTRA_GCC_TOOL} \
    gnupg \
    parted \
	v4l-utils \
    git \
    hostapd \
    spitools \
    pulseaudio-server \
    xz \
    lrzsz \
    yavta \
    libgpiod libgpiod-tools \
"

inherit extrausers
# Create the password hash with following command on host:
# >> mkpasswd -m sha256crypt avnet -S abcd6789
# Remember to escape the character $ in the resulting hash

# Set the root password: avnet
#PASSWD="\$5\$abcd6789\$vlMo5CC1IJlipoXWQifbiMJ8fZqRIV26EXIi97RxPjC"
EXTRA_USERS_PARAMS = "\
    usermod -p '${PASSWD}' root; \
"
