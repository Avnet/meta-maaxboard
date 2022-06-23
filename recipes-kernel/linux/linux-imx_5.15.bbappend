require recipes-kernel/linux/linux-maaxboard-src-5.15.inc

KERNEL_DEF_CONFIG ??= "imx_v8_defconfig"
KERNEL_DEF_CONFIG:maaxboard8ulp = "maaxboard_8ulp_defconfig"

do_copy_defconfig:maaxboardbase () {
    install -d ${B}
    # copy latest KERNEL_DEF_CONFIG to use for mx8
    mkdir -p ${B}
	cp ${S}/arch/arm64/configs/${KERNEL_DEF_CONFIG} ${B}/.config
}
