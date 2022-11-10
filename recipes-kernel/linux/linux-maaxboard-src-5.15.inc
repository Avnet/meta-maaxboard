
KERNEL_SRC:maaxboardbase = "${MAAXBOARD_GIT_HOST_MIRROR}/linux-imx.git;${MAAXBOARD_GIT_PROTOCOL}"
KERNEL_BRANCH:maaxboardbase = "maaxboard_lf-5.15.5-1.0.0"
SRC_URI:maaxboardbase = "${KERNEL_SRC};branch=${KERNEL_BRANCH};${MAAXBOARD_GIT_USER}"

SRCREV:maaxboard8ulp = "219d1dc974100f01e9c948bc305da699309b5789"
#SRCREV:maaxboard8ulp = "${AUTOREV}"
