
SUMMARY = "Python Serial Port Extension"
HOMEPAGE = "https://github.com/pyserial/pyserial"
AUTHOR = "Chris Liechti <cliechti@gmx.net>"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=520e45e59fc2cf94aa53850f46b86436"

SRC_URI = "https://files.pythonhosted.org/packages/1e/7d/ae3f0a63f41e4d2f6cb66a5b57197850f919f59e558159a4dd3a818f5082/pyserial-3.5.tar.gz"
SRC_URI[md5sum] = "1cf25a76da59b530dbfc2cf99392dc83"
SRC_URI[sha256sum] = "3c77e014170dfffbd816e6ffc205e9842efb10be9f58ec16d3e8675b4925cddb"

S = "${WORKDIR}/pyserial-3.5"

RDEPENDS_${PN} = ""

inherit setuptools3
