SUMMARY = "A console lite image for production"
LICENSE = "MIT"

inherit core-image

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
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'weston-init', '', d)} \
    ${HANTRO_PKGS} \
"

CORE_IMAGE_EXTRA_INSTALL_maaxboardnano += "wifi-service"

inherit extrausers
EXTRA_USERS_PARAMS = "\
    usermod -P avnet root; \
"
