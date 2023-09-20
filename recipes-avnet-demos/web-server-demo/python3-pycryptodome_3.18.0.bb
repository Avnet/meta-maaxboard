
SUMMARY = "Cryptographic library for Python"
HOMEPAGE = "https://www.pycryptodome.org"
AUTHOR = "Helder Eijs <helderijs@gmail.com>"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://LICENSE.rst;md5=29242a70410a4eeff488a28164e7ab93"

SRC_URI = "https://files.pythonhosted.org/packages/b9/05/0e7547c445bbbc96c538d870e6c5c5a69a9fa5df0a9df3e27cb126527196/pycryptodome-3.18.0.tar.gz"
SRC_URI[md5sum] = "500651c3e5f6bc456f2a0c366318f21b"
SRC_URI[sha256sum] = "c9adee653fc882d98956e33ca2c1fb582e23a8af7ac82fee75bd6113c55a0413"

S = "${WORKDIR}/pycryptodome-3.18.0"

RDEPENDS_${PN} = ""

inherit setuptools3
