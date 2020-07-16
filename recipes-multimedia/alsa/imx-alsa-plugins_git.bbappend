SRCBRANCH_maaxboard = "nxp/master"
SRC_URI_maaxboard = "git://source.codeaurora.org/external/imx/imx-alsa-plugins.git;protocol=https;branch=${SRCBRANCH}"
SRCREV_maaxboard = "9a63071e7734bd164017f3761b8d1944c017611f"

# MaaxBoard Mini 4.14.98-2.0.0_ga
IMXALSA_SRC_maaxboardmini ?= "git://source.codeaurora.org/external/imx/imx-alsa-plugins.git;protocol=https"
NXP_REPO_MIRROR_maaxboardmini ?= "nxp/"
SRCBRANCH_maaxboardmini = "${NXP_REPO_MIRROR}master"
SRC_URI_maaxboardmini = "${IMXALSA_SRC};branch=${SRCBRANCH}"
SRCREV_maaxboardmini = "9a63071e7734bd164017f3761b8d1944c017611f"