# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2017-2018 NXP
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Linux Kernel provided and supported by NXP"
DESCRIPTION = "Linux Kernel provided and supported by NXP with focus on \
i.MX Family Reference Boards. It includes support for many IPs such as GPU, VPU and IPU."

require recipes-kernel/linux/linux-imx.inc

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"

require recipes-kernel/linux/linux-maaxboard-src-patched-${PV}.inc

DEPENDS += "lzop-native bc-native"

DEFAULT_PREFERENCE = "1"

addtask copy_defconfig after do_patch before do_preconfigure

do_copy_defconfig () {
    install -d ${B}
    # copy latest defconfig to use for maaxboard
    mkdir -p ${B}
    cp ${S}/arch/arm64/configs/maaxboard_defconfig ${B}/.config
    cp ${S}/arch/arm64/configs/maaxboard_defconfig ${B}/../defconfig
}

COMPATIBLE_MACHINE = "(maaxboard)"
