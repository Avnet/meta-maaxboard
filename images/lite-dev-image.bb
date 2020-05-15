SUMMARY = "A console lite image for development"
LICENSE = "MIT"

require images/lite-image.bb

IMAGE_FEATURES += " \
    allow-empty-password \
    debug-tweaks \
    nfs-server \
"

CORE_IMAGE_EXTRA_INSTALL += " \
    packagegroup-core-full-cmdline \
    packagegroup-tools-bluetooth \
    packagegroup-fsl-tools-audio \
    packagegroup-fsl-tools-gpu \
    packagegroup-fsl-tools-gpu-external \
    packagegroup-fsl-tools-benchmark \
    packagegroup-fsl-gstreamer1.0 \
    packagegroup-fsl-gstreamer1.0-full \
"