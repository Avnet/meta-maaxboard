# FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

UBOOT_SRC_maaxboardbase = "${MAAXBOARD_GIT_HOST_MIRROR}/uboot-imx.git;protocol=ssh"
SRCBRANCH_maaxboardbase = "maaxboard_v2021.04_5.10.35_2.0.0"
SRC_URI_maaxboardbase = "${UBOOT_SRC};branch=${SRCBRANCH}"
SRCREV_maaxboardnano = "fc9266f88a8923dce1868e4462520316f52a977f"
SRCREV_maaxboard = "8e694f7d407b0984490f4361620c772172759e28"
SRCREV_maaxboardmini = "18bbcf32381423d32067e9f0be62ce988c787257"
