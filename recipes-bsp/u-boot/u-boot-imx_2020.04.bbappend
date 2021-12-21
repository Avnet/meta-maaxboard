# FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

UBOOT_SRC_maaxboardbase = "${MAAXBOARD_GIT_HOST_MIRROR}/uboot-imx.git;protocol=https"
SRCBRANCH_maaxboardbase = "maaxboard_v2020.04_5.4.24_2.1.0"
SRC_URI_maaxboardbase = "${UBOOT_SRC};branch=${SRCBRANCH} \
"
SRCREV_maaxboardnano = "2ee9ac4010c4c085f99f4ea97c1dfead83f32299"
SRCREV_maaxboard = "8e694f7d407b0984490f4361620c772172759e28"
SRCREV_maaxboardmini = "82c4fc6af8679cc2c3a74ea4611f0009642adea0"
