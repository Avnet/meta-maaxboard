
SUMMARY = "Microsoft Azure IoT Device Library"
HOMEPAGE = "https://github.com/Azure/azure-iot-sdk-python/"
AUTHOR = "Microsoft Corporation <opensource@microsoft.com>"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=27e94c0280987ab296b0b8dd02ab9fe5"

SRC_URI = "https://files.pythonhosted.org/packages/35/27/021fa4e4968ad83193ec18c8998ef416d3fbf9916e77167ce3fe6c21c30d/azure-iot-device-2.12.0.tar.gz"
SRC_URI[md5sum] = "2fc64a53b199806f47ad5ac4316c6986"
SRC_URI[sha256sum] = "a15a211341430674fa2959f4a87ac39d2ba1f7f0b8bfb09d94a4f1f1be27fb09"

S = "${WORKDIR}/azure-iot-device-2.12.0"

RDEPENDS_${PN} = "python3-urllib3 python3-deprecation python3-paho-mqtt python3-requests python3-requests-unixsocket python3-janus python3-pysocks"

inherit setuptools3
