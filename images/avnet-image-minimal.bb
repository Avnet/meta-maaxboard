SUMMARY = "A small image just capable of allowing a device to boot."
LICENSE = "MIT"

IMAGE_LINGUAS = " "
IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"

inherit core-image

IMAGE_ROOTFS_SIZE ?= "512"
#IMAGE_ROOTFS_EXTRA_SPACE:append = "${@bb.utils.contains("DISTRO_FEATURES", "systemd", " + 4096", "", d)}"

EXTRA_IMAGE_FEATURES:remove = "tools-sdk tools-debug"

CORE_IMAGE_EXTRA_INSTALL:append = " \
	tzdata \
	openssh \
	evtest \
	alsa-utils \
    v4l-utils \
	inetutils \
    hostapd \
	wpa-supplicant \
	wireless-tools \
    spitools \
    alsa-state \
    lrzsz \
    yavta \
    libgpiod libgpiod-tools \
	packagegroup-fsl-gstreamer1.0 \
	packagegroup-fsl-gstreamer1.0-full \
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
