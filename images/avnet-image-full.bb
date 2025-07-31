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
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'weston', \
       bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11-base x11-sato', '', d), d)} \
"

DOCKER ?= ""
DOCKER = "docker"

CORE_IMAGE_EXTRA_INSTALL += " \
    packagegroup-base-wifi \
    packagegroup-core-full-cmdline \
    packagegroup-tools-bluetooth \
    pulseaudio-module-bluetooth-discover \
    pulseaudio-module-bluetooth-policy \
    pulseaudio-module-bluez5-discover \
    pulseaudio-module-bluez5-device \
    pulseaudio-module-switch-on-connect \
    pulseaudio-module-loopback \
    packagegroup-fsl-tools-audio \
    packagegroup-fsl-tools-gpu \
    packagegroup-fsl-tools-gpu-external \
    packagegroup-fsl-tools-testapps \
    packagegroup-fsl-tools-benchmark \
    packagegroup-imx-isp \
    packagegroup-imx-security \
    packagegroup-fsl-gstreamer1.0 \
    packagegroup-fsl-gstreamer1.0-full \
    packagegroup-fsl-opencv-imx \
    packagegroup-imx-ml \
    firmware-nxp-wifi \
    packagegroup-qt6-imx \
    packagegroup-core-ssh-openssh \
    openssh-sftp openssh-sftp-server \
    packagegroup-misc-utils \
    firmwared \
    ${@bb.utils.contains('DISTRO_FEATURES', 'x11 wayland', 'weston-xwayland xterm', '', d)} \
    ${DOCKER} \
"

inherit populate_sdk_qt6_base

CONFLICT_DISTRO_FEATURES = "directfb"

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
    ${EXTRA_GCC_TOOL} \
    tzdata vim tree \
    gnupg \
    parted \
    v4l-utils \
    inetutils \
    hostapd \
    cryptodev-module \
    openssl-bin \
    wireless-tools \
    git \
    spitools \
    alsa-state \
    weston-timer \
    pulseaudio-server \
    xz \
    lrzsz \
    yavta \
    fb-test \
    fbgrab \
    i2c-tools \
    libgpiod libgpiod-tools \
    powertop \
    dos2unix \
    rsync \
    freerdp \
    nodejs \
    nodejs-npm \
    python3 \
    python3-pip \
"

#CORE_IMAGE_EXTRA_INSTALL:append:mx93-nxp-bsp = " nxp-demo-experience "

install_demo_93() {
    if ! grep -q "icon_demo_launcher.png" ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
    then
       echo "" >> ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
       echo "[launcher]" >> ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
       echo "icon=/home/root/.nxp-demo-experience/icon/icon_demo_launcher.png" >> ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
       echo "path=QMLSCENE_DEVICE=softwarecontext /usr/bin/gopoint" >> ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
       echo "" >> ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
       echo "[launcher]" >> ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
       echo "icon=/usr/share/weston/terminal.png" >> ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
       echo "path=/usr/bin/weston-terminal" >> ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
    fi

    if ! grep -q "HOME=/home/root/" ${IMAGE_ROOTFS}${sysconfdir}/default/weston
    then
        echo "\nHOME=/home/root/\nQT_QPA_PLATFORM=wayland" >> ${IMAGE_ROOTFS}${sysconfdir}/default/weston
    fi
}

ROOTFS_POSTPROCESS_COMMAND:append:mx93-nxp-bsp = "install_demo_93; "


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
