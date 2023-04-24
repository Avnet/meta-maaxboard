
KERNEL_SRC:maaxboardbase = "${MAAXBOARD_GIT_HOST_MIRROR}/linux-imx.git;${MAAXBOARD_GIT_PROTOCOL}"
KERNEL_BRANCH:maaxboardbase = "maaxboard_lf-5.15.71-2.2.0"
SRC_URI:maaxboardbase = "${KERNEL_SRC};branch=${KERNEL_BRANCH};${MAAXBOARD_GIT_USER}"

#SRCREV:maaxboardbase = "66e63bd0cd0dee1930f32569bdf344aea92dec9e"
SRCREV:maaxboardbase = "${AUTOREV}"
