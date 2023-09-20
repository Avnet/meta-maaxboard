
SUMMARY = "Copy WebUI server demo to /home/root"
DESCRIPTION = "This recipe copies the contents of the web-server-demo to the /home/root directory on the target system."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://web-server-demo"

do_install() {
    install -d ${D}/home/root/web-server-demo
    cp -r ${WORKDIR}/web-server-demo ${D}/home/root
    chmod -R a+rX ${D}/home/root/web-server-demo
    chmod +x ${D}/home/root/web-server-demo/launch.sh 

    install -D -m 0755 ${WORKDIR}/web-server-demo/autolaunch/autorun.service \
        ${D}${sysconfdir}/systemd/system/autorun.service

    install -D -m 0755 ${WORKDIR}/web-server-demo/autolaunch/rc.local \
        ${D}${sysconfdir}/rc.local

    install -D -m 0755 ${WORKDIR}/web-server-demo/autolaunch/autorun.sh \
        ${D}/opt/autorun.sh 

    chmod +x ${D}/opt/autorun.sh 

    install -D -m 0755 ${WORKDIR}/web-server-demo/autolaunch/root_env \
        ${D}/opt/root_env 
}
FILES:${PN} += "/home/root/web-server-demo"
FILES:${PN} += "/opt"
