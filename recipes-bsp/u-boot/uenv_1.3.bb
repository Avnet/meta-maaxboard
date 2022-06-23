SUMMARY = "U-Boot Env"
SECTION = "app"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

S = "${WORKDIR}"

SRC_URI = " "
SRC_URI:maaxboard8ulp = " \
            file://uEnv-8ulp.txt \
"

FILES:${PN} = "/boot"

do_install () {
    install -d ${D}/boot
    install -m 0644 ${S}/uEnv-*.txt ${D}/boot/uEnv.txt
}

inherit deploy
addtask deploy after do_install

do_deploy () {
    install -m 0644 ${D}/boot/uEnv.txt ${DEPLOYDIR}
}

COMPATIBLE_MACHINE = "(maaxboardbase)"
PACKAGE_ARCH = "${MACHINE_ARCH}"
