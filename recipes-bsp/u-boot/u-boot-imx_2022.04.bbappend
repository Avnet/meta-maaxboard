
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

UBOOT_SRC:maaxboard = "${MAAXBOARD_GIT_HOST_MIRROR}/uboot-imx.git;${MAAXBOARD_GIT_PROTOCOL}"
UBOOT_BRANCH:maaxboard = "maaxboard_lf-5.15.71-2.2.0"
SRC_URI:maaxboard = "${UBOOT_SRC};branch=${UBOOT_BRANCH};${MAAXBOARD_GIT_USER}"

#SRCREV:maaxboard = "921947072436d70f5fb83c313b580e96d2f1bbcf"
SRCREV:maaxboard = "${AUTOREV}"
