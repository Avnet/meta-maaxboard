DESCRIPTION = "Turn on SSH if /boot/ssh is present"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

inherit systemd

SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE:${PN} = "sshswitch.timer"

SRC_URI += " file://sshswitch.service "
SRC_URI += " file://sshswitch.timer "

FILES:${PN} += "${systemd_unitdir}/system/sshswitch.service"
FILES:${PN} += "${systemd_unitdir}/system/sshswitch.timer"

do_install() { 
    install -d ${D}/${systemd_unitdir}/system 
    install -m 0644 ${WORKDIR}/sshswitch.service ${D}/${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/sshswitch.timer ${D}/${systemd_unitdir}/system
}
