DESCRIPTION = "Turn on SSH if /boot/ssh is present"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

inherit systemd

SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE:${PN} = "sshswitch.service"

SRC_URI += " file://sshswitch.service "
FILES:${PN} += "${systemd_unitdir}/system/sshswitch.service"

do_install() { 
    install -d ${D}/${systemd_unitdir}/system 
    install -m 0644 ${WORKDIR}/sshswitch.service ${D}/${systemd_unitdir}/system
}
