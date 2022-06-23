DESCRIPTION = "Copy user wpa_supplicant.conf"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

inherit systemd

SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE:${PN} = "wpa-conf.service"

SRC_URI += " file://wpa-conf.service "
FILES:${PN} += "${systemd_unitdir}/system/wpa-conf.service"

do_install() { 
    install -d ${D}/${systemd_unitdir}/system 
    install -m 0644 ${WORKDIR}/wpa-conf.service ${D}/${systemd_unitdir}/system
}

do_install:append_maaxboardnano() { 
    sed -i "s/wlan/mlan/g" ${D}/${systemd_unitdir}/system/wpa-conf.service
}
