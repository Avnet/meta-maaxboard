# Copyright David.fu <david.fu@avnet.com>
# asound.state for DA7212

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "\
         file://asound-8ulp.state \
         file://asound-8ulp.conf \
         file://asound-nano.state \
         file://asound-nano.conf \
"

do_install:append:maaxboard8ulp () {
    install -m 0644 ${WORKDIR}/asound-8ulp.state ${D}${localstatedir}/lib/alsa/asound.state
    install -m 0644 ${WORKDIR}/asound-8ulp.conf ${D}${sysconfdir}/asound.conf
}

do_install:append:maaxboardnano () {
    install -m 0644 ${WORKDIR}/asound-nano.state ${D}${localstatedir}/lib/alsa/asound.state
    install -m 0644 ${WORKDIR}/asound-nano.conf ${D}${sysconfdir}/asound.conf
}
