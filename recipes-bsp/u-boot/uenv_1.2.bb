SUMMARY = "U-Boot Env"
SECTION = "app"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

S = "${WORKDIR}"

SRC_URI = " "

SRC_URI_maaxboard = " \
            file://uEnv-mq.txt \
"

SRC_URI_maaxboardmini = " \
            file://uEnv-mini.txt \
"

SRC_URI_maaxboardnano = " \
            file://uEnv-nano.txt \
            file://readme.txt \
"

FILES_${PN} = "/boot"

do_install () {
    install -d ${D}/boot
    install -m 0644 ${S}/uEnv-*.txt ${D}/boot/uEnv.txt
    install -m 0644 ${S}/readme.txt ${D}/boot/readme.txt
}

inherit deploy
addtask deploy after do_install

do_deploy () {
    install -m 0644 ${D}/boot/uEnv.txt ${DEPLOYDIR}
    install -m 0644 ${D}/boot/readme.txt ${DEPLOYDIR}
}

COMPATIBLE_MACHINE = "(maaxboardbase)"
PACKAGE_ARCH = "${MACHINE_ARCH}"
