FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
            file://dhcpcd.service \
        "

inherit systemd

SYSTEMD_PACKAGES = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '${PN}', '', d)}"
SYSTEMD_SERVICE_${PN}_append = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', ' dhcpcd.service', '', d)}"

do_install_append () {
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system
        install -m 644 ${WORKDIR}/*.service ${D}/${systemd_unitdir}/system
    fi
}
