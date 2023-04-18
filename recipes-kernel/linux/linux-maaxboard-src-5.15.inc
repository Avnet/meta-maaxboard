
KERNEL_SRC:maaxboardbase = "${MAAXBOARD_GIT_HOST_MIRROR}/linux-imx.git;${MAAXBOARD_GIT_PROTOCOL}"
KERNEL_BRANCH:maaxboardbase = "maaxboard_lf-5.15.71-2.2.0"
SRC_URI:maaxboardbase = "${KERNEL_SRC};branch=${KERNEL_BRANCH};${MAAXBOARD_GIT_USER}"

#SRCREV:maaxboard = "f4b1d1c5782d600f65edd5562a5e9543aac98447"
SRCREV:maaxboard = "${AUTOREV}"
