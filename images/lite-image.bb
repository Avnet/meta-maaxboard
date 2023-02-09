SUMMARY = "A console lite image for production"
LICENSE = "MIT"

inherit core-image

# additional free disk space created in Kbytes
IMAGE_OVERHEAD_FACTOR = "1.0"
IMAGE_ROOTFS_EXTRA_SPACE = "512000"

## Select Image Features
IMAGE_FEATURES += " \
    ssh-server-openssh \
    hwcodecs \
    package-management \
"
ERPC_COMPS ?= ""
ERPC_COMPS_append_mx7ulp = "packagegroup-imx-erpc"

HANTRO_PKGS = ""
HANTRO_PKGS_mx8mm = "imx-vpu-hantro-daemon"
HANTRO_PKGS_mx8mp = "imx-vpu-hantro-daemon"
HANTRO_PKGS_mx8mq = "imx-vpu-hantro-daemon"

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
    packagegroup-core-ssh-openssh \
    openssh-sftp openssh-sftp-server \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'weston-init', '', d)} \
    ${HANTRO_PKGS} \
"

CORE_IMAGE_EXTRA_INSTALL_append = " packagegroup-qt5-imx "

CORE_IMAGE_EXTRA_INSTALL_append = " \
    gnupg \
    parted \
    v4l-utils \
    sudo \
    nano \
    git \
    e2fsprogs \
    linux-imx-headers \
    gcc \
    gcc-symlinks \
    binutils \
    automake \
    autoconf \
    hostapd \
    evtest \
    mtd-utils \
    i2c-tools \
    spitools \
    pulseaudio-server \
    xz \
    dos2unix \
    rsync \
"

CORE_IMAGE_EXTRA_INSTALL_append_maaxboardnano = "wifi-service"

# Modify default environment
modify_env() {
    echo "alias ls='ls --color=auto'" >> ${IMAGE_ROOTFS}/etc/profile
}
ROOTFS_POSTPROCESS_COMMAND += "modify_env; "

inherit extrausers
EXTRA_USERS_PARAMS = "\
    usermod -P avnet root; \
"
