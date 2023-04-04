DESCRIPTION = "Copy user wpa_supplicant.conf"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

inherit systemd

SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE:${PN} = "wpa-conf.service"

SRC_URI += " file://20-mlan0.network "
SRC_URI += " file://wpa-conf.service "
SRC_URI += " file://wpa-conf.timer "
SRC_URI += " file://wpa_supplicant@.service "

FILES:${PN} += "${sysconfdir}/systemd/network/20-mlan0.network"
FILES:${PN} += "${systemd_unitdir}/system/wpa-conf.service"
FILES:${PN} += "${systemd_unitdir}/system/wpa-conf.timer"
FILES:${PN} += "${systemd_unitdir}/system/wpa_supplicant@.service"

do_install() { 
    install -d ${D}/${systemd_unitdir}/system 
    install -d ${D}${sysconfdir}/systemd/network
    install -m 0644 ${WORKDIR}/20-mlan0.network ${D}${sysconfdir}/systemd/network
    install -m 0644 ${WORKDIR}/wpa-conf.service ${D}/${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/wpa-conf.timer ${D}/${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/wpa_supplicant@.service ${D}/${systemd_unitdir}/system
}
