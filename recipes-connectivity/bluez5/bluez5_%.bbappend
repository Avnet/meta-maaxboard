FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://maaxboard-bt \
    file://maaxboard-bt.service \
    file://bluetooth.service \
"

do_install_append() {
    install -d ${D}${sysconfdir}/bluetooth
    # install -d ${D}${sysconfdir}/dbus-1/system.d

    install -m 0755 ${WORKDIR}/maaxboard-bt ${D}${sysconfdir}/bluetooth

    install -d ${D}${systemd_unitdir}/system
    install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants

    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -m 0644 ${WORKDIR}/maaxboard-bt.service ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/bluetooth.service ${D}${systemd_unitdir}/system

        # ln -sf ${systemd_unitdir}/system/maaxboard-bt.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/maaxboard-bt.service
    fi
}
