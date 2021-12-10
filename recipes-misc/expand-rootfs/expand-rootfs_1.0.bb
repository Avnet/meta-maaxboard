DESCRIPTION = "Expand rootfs space on MMC"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " file://expand_rootfs "
FILES_${PN} += "${sbindir}/expand_rootfs"

do_install() { 
    install -d ${D}/${sbindir}/
    install -m 0755 ${WORKDIR}/expand_rootfs ${D}/${sbindir}/
}

RDEPENDS_expand-rootfs = "bash"
