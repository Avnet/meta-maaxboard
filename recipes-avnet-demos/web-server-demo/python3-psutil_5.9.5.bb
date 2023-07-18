
SUMMARY = "Cross-platform lib for process and system monitoring in Python."
HOMEPAGE = "https://github.com/giampaolo/psutil"
AUTHOR = "Giampaolo Rodola <g.rodola@gmail.com>"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=a9c72113a843d0d732a0ac1c200d81b1"

SRC_URI = "https://files.pythonhosted.org/packages/d6/0f/96b7309212a926c1448366e9ce69b081ea79d63265bde33f11cc9cfc2c07/psutil-5.9.5.tar.gz"
SRC_URI[md5sum] = "864717cda1e2577b65da1f30cd37b537"
SRC_URI[sha256sum] = "5410638e4df39c54d957fc51ce03048acd8e6d60abc0f5107af51e5fb566eb3c"

S = "${WORKDIR}/psutil-5.9.5"

RDEPENDS_${PN} = ""

inherit setuptools3
