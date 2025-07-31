
ATF_SRC = "${MAAXBOARD_GIT_HOST_MIRROR}/imx-atf.git;${MAAXBOARD_GIT_PROTOCOL}"
SRCBRANCH:maaxboard8ulp = "maaxboard_lf-6.6.36-2.1.0"
SRCBRANCH:maaxboardosm93 = "maaxboard_lf-6.6.52-2.2.0"
SRC_URI = "${ATF_SRC};branch=${SRCBRANCH}"
SRCREV = "${AUTOREV}"

ATF_BOOT_UART_BASE:maaxboardmini = "0x30860000"
