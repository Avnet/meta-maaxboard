require recipes-kernel/linux/linux-maaxboard-src-${PV}.inc

KERNEL_DEF_CONFIG ??= "imx_v8_defconfig"
KERNEL_DEF_CONFIG_maaxboardnano = "maaxboard_nano_defconfig"

do_copy_defconfig_maaxboardbase () {
    install -d ${B}
    # copy latest imx_v8_defconfig to use for mx8
    mkdir -p ${B}
    cp ${S}/arch/arm64/configs/${KERNEL_DEF_CONFIG} ${B}/.config
    cp ${S}/arch/arm64/configs/${KERNEL_DEF_CONFIG} ${B}/../defconfig
}
