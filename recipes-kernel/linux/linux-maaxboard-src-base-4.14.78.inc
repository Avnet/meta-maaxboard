SRCBRANCH = "imx_4.14.78_1.0.0_ga"
LOCALVERSION = "-1.0.0"
KERNEL_SRC ?= "git://source.codeaurora.org/external/imx/linux-imx.git;protocol=https"
SRC_URI = "${KERNEL_SRC};nobranch=1"
SRCREV = "66620c3d281c5a5b27cbb7a51276d2f94f619f1c"

S = "${WORKDIR}/git"