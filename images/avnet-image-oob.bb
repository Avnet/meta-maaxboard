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
DOCKER = "docker"

CORE_IMAGE_EXTRA_INSTALL += " \
    packagegroup-base-wifi \
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
    packagegroup-fsl-opencv-imx \
    packagegroup-core-ssh-openssh \
    openssh-sftp openssh-sftp-server \
    firmwared \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'weston-init', '', d)} \
    ${DOCKER} \
    chromium-ozone-wayland \
"

inherit populate_sdk_qt6_base

CONFLICT_DISTRO_FEATURES = "directfb"
CORE_IMAGE_EXTRA_INSTALL:append = " packagegroup-qt6-imx tzdata "

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
    gnupg \
    parted \
    v4l-utils \
    inetutils \
    hostapd \
    wireless-tools \
    git \
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
    curl \
    freerdp \
    nodejs \
    nodejs-npm \
    python3 \
    python3-pip \
    python3-opencv \
    python3-azure-iot-device \
    python3-microdot \
    python3-numpy \
    python3-psutil \
    python3-pycairo \
    python3-pycryptodome \
    python3-pyserial \
    web-server-demo \
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

# Modify default environment
modify_profile() {
    echo "alias ls='ls --color=auto'" >> ${IMAGE_ROOTFS}/etc/profile
}

update_weston_ini() {
    if ! grep -q "icon=/home/root/web-server-demo/resources/icon.png" ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
    then
       printf "\n[launcher]\nicon=/home/root/web-server-demo/resources/icon.png\npath=/home/root/web-server-demo/launch.sh\n\n[launcher]\nicon=/home/root/web-server-demo/resources/blank.png\npath=\n\n[launcher]\nicon=/home/root/web-server-demo/resources/exit.png\npath=/home/root/web-server-demo/exit.sh\n\n" >> ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
    fi

    if ! grep -q "background-image=/home/root/web-server-demo/resources/desktop.png" ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
    then
       printf "\n[shell]\nbackground-image=/home/root/web-server-demo/resources/desktop.png\nbackground-type=centered\nbackground-color=0xff000000\n\n" >> ${IMAGE_ROOTFS}${sysconfdir}/xdg/weston/weston.ini
    fi
}
ROOTFS_POSTPROCESS_COMMAND += "modify_profile; update_weston_ini; "


modify_uenv() {
	sed -i 's/^#dtoverlay_camera/dtoverlay_camera/g' ${DEPLOY_DIR_IMAGE}/uEnv.txt
	sed -i 's/^#dtoverlay_display/dtoverlay_display/g' ${DEPLOY_DIR_IMAGE}/uEnv.txt
}
IMAGE_PREPROCESS_COMMAND += "modify_uenv;"
