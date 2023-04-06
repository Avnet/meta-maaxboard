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

CORE_IMAGE_EXTRA_INSTALL += " \
    packagegroup-core-full-cmdline \
    packagegroup-tools-bluetooth \
    packagegroup-fsl-tools-audio \
    packagegroup-imx-isp \
    packagegroup-imx-security \
    packagegroup-fsl-gstreamer1.0 \
    packagegroup-fsl-gstreamer1.0-full \
    packagegroup-core-ssh-openssh \
    openssh-sftp openssh-sftp-server \
    firmwared \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'weston-init', '', d)} \
"

inherit populate_sdk_qt6_base

CONFLICT_DISTRO_FEATURES = "directfb"
CORE_IMAGE_EXTRA_INSTALL:append = " tzdata "

EXTRA_GCC_TOOL ?= ""
EXTRA_GCC_TOOL = " \
    gcc \
    gcc-symlinks \
    binutils \
    automake \
    cmake \
    autoconf \
"

CORE_IMAGE_EXTRA_INSTALL:append = " \
    gnupg \
    parted \
    v4l-utils \
    git \
    hostapd \
    spitools \
    alsa-state \
    expand-rootfs \
    wpa-conf \
    weston-timer \
    pulseaudio-server \
    xz \
    lrzsz \
    yavta \
    libgpiod libgpiod-tools \
    powertop \
    dos2unix \
    rsync \
"

# Modify default environment
modify_env() {
    echo "alias ls='ls --color=auto'" >> ${IMAGE_ROOTFS}/etc/profile
}
ROOTFS_POSTPROCESS_COMMAND += "modify_env; "

inherit extrausers
# Create the password hash with following command on host:
# >> mkpasswd -m sha256crypt avnet -S abcd6789
# Remember to escape the character $ in the resulting hash

# Set the root password: avnet
#PASSWD="\$5\$abcd6789\$vlMo5CC1IJlipoXWQifbiMJ8fZqRIV26EXIi97RxPjC"
EXTRA_USERS_PARAMS = "\
    usermod -p '${PASSWD}' root; \
"