require recipes-kernel/linux/linux-maaxboard-src-${PV}.inc

KERNEL_DEF_CONFIG ??= "imx_v8_defconfig"
KERNEL_DEF_CONFIG_maaxboardnano = "maaxboard_nano_defconfig"
KERNEL_DEF_CONFIG_maaxboard = "maaxboard_defconfig"

do_copy_defconfig_maaxboardbase () {
    install -d ${B}
    # copy latest imx_v8_defconfig to use for mx8
    mkdir -p ${B}
    cp ${S}/arch/arm64/configs/${KERNEL_DEF_CONFIG} ${B}/.config
    cp ${S}/arch/arm64/configs/${KERNEL_DEF_CONFIG} ${B}/../defconfig
}

# Auto load Wi-Fi(nxp8987) driver moal
# /etc/modprobe.d/moal.conf
KERNEL_MODULE_AUTOLOAD_maaxboardnano += "moal"
KERNEL_MODULE_PROBECONF_maaxboardnano += "moal"
module_conf_moal_maaxboardnano = "options moal mod_para=nxp/wifi_mod_para_sd8987.conf"