SUMMARY = "OpenSSH SSH client/server"
PR = "r1"

inherit packagegroup

RDEPENDS:${PN} = "expand-rootfs sshswitch wpa-conf"
