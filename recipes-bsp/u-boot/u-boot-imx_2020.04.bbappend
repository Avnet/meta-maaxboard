# FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

UBOOT_SRC_maaxboardnano = "${MAAXBOARD_GIT_HOST_MIRROR}/uboot-imx.git;protocol=ssh"
SRCBRANCH_maaxboardnano = "maaxboard_nano_5.4.24_2.1.0"
SRC_URI_maaxboardnano = "${UBOOT_SRC};branch=${SRCBRANCH} \
"
SRCREV_maaxboardnano = "a705424a97edf7baa650373bad1c172feceded72"
