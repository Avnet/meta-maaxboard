SUMMARY = "A console lite image for production"
LICENSE = "MIT"

inherit core-image

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
    packagegroup-fsl-tools-gpu \
    packagegroup-fsl-tools-gpu-external \
    packagegroup-fsl-gstreamer1.0 \
    packagegroup-fsl-gstreamer1.0-full \
    x264 \
    opencv \
    python3-opencv \
    apt \
    sudo \
    bash \
    nano \
    dhcpcd \
    git \
    e2fsprogs-resize2fs \
    parted \
    man-db \
    linux-imx-headers \
    gcc \
    gcc-symlinks \
    binutils \
    automake \
    autoconf \
    dnsmasq \
    hostapd \
    evtest \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'weston-init', '', d)} \
    mtd-utils \
    nss \
    nspr \
    libxkbcommon \
    pulseaudio-server \
"

inherit extrausers
EXTRA_USERS_PARAMS = "\
    usermod -P avnet root; \
"