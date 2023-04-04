require recipes-kernel/linux/linux-maaxboard-src-5.15.inc

KERNEL_DEF_CONFIG ??= "imx_v8_defconfig"
KERNEL_DEF_CONFIG:maaxboard = "maaxboard_defconfig"

do_copy_defconfig:maaxboardbase () {
    install -d ${B}
    # copy latest KERNEL_DEF_CONFIG to use for mx8
    mkdir -p ${B}
	cp ${S}/arch/arm64/configs/${KERNEL_DEF_CONFIG} ${B}/.config
}

KERNEL_DTC_FLAGS = "-@"

KERNEL_DEVICETREE2 ?= ""
KERNEL_DEVICETREE2:maaxboard  = " \
    freescale/maaxboard/camera-as0260.dtbo \
    freescale/maaxboard/camera-ov5640.dtbo \
    freescale/maaxboard/display-dual.dtbo \
    freescale/maaxboard/display-hdmi.dtbo \
    freescale/maaxboard/display-mipi.dtbo \
    freescale/maaxboard/ext-gpio.dtbo \
    freescale/maaxboard/ext-i2c2.dtbo \
    freescale/maaxboard/ext-i2c3.dtbo \
    freescale/maaxboard/ext-pwm2.dtbo \
    freescale/maaxboard/ext-pwm4.dtbo \
    freescale/maaxboard/ext-spi1.dtbo \
    freescale/maaxboard/ext-uart2.dtbo \
    freescale/maaxboard/ext-wm8960.dtbo \
    freescale/maaxboard/usb0-device.dtbo \
"

do_compile:append() {
    if [ -n "${KERNEL_DTC_FLAGS}" ]; then
        export DTC_FLAGS="${KERNEL_DTC_FLAGS}"
    fi

    for dtbf in ${KERNEL_DEVICETREE2}; do
        dtb=`normalize_dtb "$dtbf"`
        oe_runmake $dtb CC="${KERNEL_CC} $cc_extra " LD="${KERNEL_LD}" ${KERNEL_EXTRA_ARGS}
    done
}

do_deploy:append:maaxboard(){
    install -d ${DEPLOYDIR}/overlays
    cp ${WORKDIR}/build/arch/arm64/boot/dts/freescale/maaxboard/* ${DEPLOYDIR}/overlays
}
