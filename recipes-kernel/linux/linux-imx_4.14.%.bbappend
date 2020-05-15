FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRCBRANCH = "imx_4.14.78_1.0.0"
LOCALVERSION = "-1.1.0"
SRC_URI = "${KERNEL_SRC};nobranch=1"
SRCREV = "66620c3d281c5a5b27cbb7a51276d2f94f619f1c"

SRC_URI += " \
        file://IMX8M-maaxboard-support.diff \
"

do_copy_defconfig_maaxboard () {
    install -d ${B}
    # copy latest defconfig to use for maaxboard
    mkdir -p ${B}
    cp ${S}/arch/arm64/configs/em-sbc-imx8m_defconfig ${B}/.config
    cp ${S}/arch/arm64/configs/em-sbc-imx8m_defconfig ${B}/../defconfig
}