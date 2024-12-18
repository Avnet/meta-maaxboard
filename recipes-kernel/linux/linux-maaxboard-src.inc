
KERNEL_SRC:maaxboardbase = "${MAAXBOARD_GIT_HOST_MIRROR}/linux-imx.git;${MAAXBOARD_GIT_PROTOCOL}"
KERNEL_BRANCH:maaxboardbase = "maaxboard_lf-6.6.3-1.0.0"
SRC_URI:maaxboardbase = "${KERNEL_SRC};branch=${KERNEL_BRANCH};${MAAXBOARD_GIT_USER}"

SRCREV:maaxboardbase = "${AUTOREV}"

FILESEXTRAPATHS:prepend:maaxboardosm93 := "${THISDIR}/files:"
SRC_URI:append:maaxboardosm93 = " file://maaxboardosm93_1GB_memory_kernel_dtb.patch "
