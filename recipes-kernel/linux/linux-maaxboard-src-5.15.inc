
KERNEL_SRC:maaxboardbase = "${MAAXBOARD_GIT_HOST_MIRROR}/linux-imx.git;${MAAXBOARD_GIT_PROTOCOL}"
KERNEL_BRANCH:maaxboardbase = "dev-maaxboard_lf-5.15.71-2.2.0"
SRC_URI:maaxboardbase = "${KERNEL_SRC};branch=${KERNEL_BRANCH};${MAAXBOARD_GIT_USER}"

#SRCREV:maaxboard = "b6bfd82cfebce7848f34343b0f82726461a778c2"
SRCREV:maaxboard = "${AUTOREV}"
