
SUMMARY = "The impossibly small web framework for MicroPython"
HOMEPAGE = "https://github.com/miguelgrinberg/microdot"
AUTHOR = "Miguel Grinberg <miguel.grinberg@gmail.com>"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=fa1a4c40fd447b31a33c3200064bc3dd"

SRC_URI = "https://files.pythonhosted.org/packages/0f/78/ef370258a626833741e160bd4d46f81e91678d89b6e39b5c5c629966897d/microdot-1.3.2.tar.gz"
SRC_URI[md5sum] = "c41a5832fd998b1b6026e57fb4dc1f7b"
SRC_URI[sha256sum] = "5866e87b3e010dc8395c800ced1320a8ed5e65f370ac27fe7d0a927dbb8c7f61"

S = "${WORKDIR}/microdot-1.3.2"

RDEPENDS_${PN} = ""

inherit setuptools3
