DESCRIPTION = "Weston need start after system bootup"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

inherit systemd

SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE:${PN} = "weston.timer"

SRC_URI += " file://weston.timer "

FILES:${PN} += "${systemd_unitdir}/system/weston.timer"

do_install() { 
    install -d ${D}/${systemd_unitdir}/system 
    install -m 0644 ${WORKDIR}/weston.timer ${D}/${systemd_unitdir}/system
}
