
require recipes-kernel/linux/linux-maaxboard-mini-src-patched-${PV}.inc

do_copy_defconfig_maaxboardmini () {
    install -d ${B}
    # copy latest defconfig to use for maaxboard mini
    mkdir -p ${B}
    cp ${S}/arch/arm64/configs/maaxboard_mini_defconfig ${B}/.config
    cp ${S}/arch/arm64/configs/maaxboard_mini_defconfig ${B}/../defconfig
}