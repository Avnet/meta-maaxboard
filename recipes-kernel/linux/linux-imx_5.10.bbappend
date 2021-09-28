require recipes-kernel/linux/linux-maaxboard-src-5.10.inc

KERNEL_DEF_CONFIG ??= "imx_v8_defconfig"
KERNEL_DEF_CONFIG_maaxboardnano = "maaxboard_nano_defconfig"
KERNEL_DEF_CONFIG_maaxboard = "maaxboard_defconfig"
KERNEL_DEF_CONFIG_maaxboardmini = "maaxboard_mini_defconfig"
KBUILD_DEFCONFIG_maaxboardnano = "maaxboard_nano_defconfig"

KERNEL_DTC_FLAGS = "-@"

do_copy_defconfig_maaxboardbase () {
    install -d ${B}
    # copy latest imx_v8_defconfig to use for mx8
    mkdir -p ${B}
    cp ${S}/arch/arm64/configs/${KERNEL_DEF_CONFIG} ${B}/.config
    cp ${S}/arch/arm64/configs/${KERNEL_DEF_CONFIG} ${B}/../defconfig
}

# Auto load Wi-Fi(nxp8987) driver moal
# /etc/modprobe.d/moal.conf
#KERNEL_MODULE_AUTOLOAD_maaxboardnano += "moal"
#KERNEL_MODULE_PROBECONF_maaxboardnano += "moal"
#module_conf_moal_maaxboardnano = "options moal mod_para=nxp/wifi_mod_para_sd8987.conf"

KERNEL_DEVICETREE2  = " \
    freescale/overlays/maaxboard-nano-audio.dtbo \
    freescale/overlays/maaxboard-nano-ext-spi.dtbo \
    freescale/overlays/maaxboard-nano-ext-sai3.dtbo \
    freescale/overlays/maaxboard-nano-ext-uart4.dtbo \
    freescale/overlays/maaxboard-nano-ext-gpio.dtbo \
    freescale/overlays/maaxboard-nano-mic.dtbo \
    freescale/overlays/maaxboard-nano-ext-i2c.dtbo \
    freescale/overlays/maaxboard-nano-mipi.dtbo \
    freescale/overlays/maaxboard-nano-ext-pwm.dtbo \
    freescale/overlays/maaxboard-nano-ov5640.dtbo \
"
do_compile_append() {
    if [ -n "${KERNEL_DTC_FLAGS}" ]; then
        export DTC_FLAGS="${KERNEL_DTC_FLAGS}"
    fi

    for dtbf in ${KERNEL_DEVICETREE2}; do
        dtb=`normalize_dtb "$dtbf"`
        oe_runmake $dtb CC="${KERNEL_CC} $cc_extra " LD="${KERNEL_LD}" ${KERNEL_EXTRA_ARGS}
    done
}


do_deploy_append_maaxboardnano(){
    install -d ${DEPLOYDIR}/overlays
    cp ${WORKDIR}/build/arch/arm64/boot/dts/freescale/overlays/* ${DEPLOYDIR}/overlays
}
