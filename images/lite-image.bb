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
    packagegroup-fsl-gstreamer1.0 \
    apt \
    sudo \
    bash \
    nano \
    dhcpcd \
    git \
    e2fsprogs-resize2fs \
    parted \
    man-db \
"

inherit extrausers
EXTRA_USERS_PARAMS = "\
    usermod -P avnet root; \
"