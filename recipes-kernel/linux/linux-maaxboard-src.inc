
KERNEL_SRC:maaxboardbase = "${MAAXBOARD_GIT_HOST_MIRROR}/linux-imx.git;${MAAXBOARD_GIT_PROTOCOL}"
KERNEL_BRANCH:maaxboard8ulp = "maaxboard_lf-6.6.36-2.1.0"
KERNEL_BRANCH:maaxboardosm93 = "maaxboard_lf-6.6.52-2.2.0"
SRC_URI:maaxboardbase = "${KERNEL_SRC};branch=${KERNEL_BRANCH};${MAAXBOARD_GIT_USER}"

SRCREV:maaxboardbase = "${AUTOREV}"
