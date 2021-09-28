DESCRIPTION = "Wifi start service"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
            file://maaxboard-wifi.service \
            file://wifi-start \
        "

do_install(){
    install -d ${D}${sysconfdir}/wifi
    install -d ${D}${systemd_unitdir}/system

    install -m 0755 ${WORKDIR}/wifi-start ${D}${sysconfdir}/wifi

    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -m 0644 ${WORKDIR}/maaxboard-wifi.service ${D}${systemd_unitdir}/system
    fi
}

FILES_${PN} += " \
    ${systemd_unitdir}/system \
    ${sysconfdir}/wifi/wifi-start \
"
RDEPENDS_wifi-service = "bash"