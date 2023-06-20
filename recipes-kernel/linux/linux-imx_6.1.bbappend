# NOTE:
# ${MACHINE} defined in meta-maaxboard/conf/local.conf.sample.xxx
# It should be maaxboard,maaxboard-8ulp,maaxboard-mini,maaxboard-nano

require recipes-kernel/linux/linux-maaxboard-src.inc

KERNEL_DEF_CONFIG ??= "imx_v8_defconfig"
KERNEL_DEF_CONFIG = "${MACHINE}_defconfig"

do_copy_defconfig:maaxboardbase () {
    install -d ${B}
    mkdir -p ${B}
    cp ${S}/arch/arm64/configs/${KERNEL_DEF_CONFIG} ${B}/.config
}

KERNEL_DTC_FLAGS = "-@"

KERNEL_DEVICETREE2 ?= ""

KERNEL_DEVICETREE2:maaxboard  = " \
    freescale/${MACHINE}/camera-ov5640.dtbo \
    freescale/${MACHINE}/display-dual.dtbo \
    freescale/${MACHINE}/display-hdmi.dtbo \
    freescale/${MACHINE}/display-mipi.dtbo \
    freescale/${MACHINE}/ext-gpio.dtbo \
    freescale/${MACHINE}/ext-i2c2.dtbo \
    freescale/${MACHINE}/ext-i2c3.dtbo \
    freescale/${MACHINE}/ext-pwm2.dtbo \
    freescale/${MACHINE}/ext-pwm4.dtbo \
    freescale/${MACHINE}/ext-spi1.dtbo \
    freescale/${MACHINE}/ext-uart2.dtbo \
    freescale/${MACHINE}/ext-wm8960.dtbo \
    freescale/${MACHINE}/usb0-device.dtbo \
"

KERNEL_DEVICETREE2:maaxboard-mini  = " \
    freescale/${MACHINE}/camera-ov5640.dtbo \
    freescale/${MACHINE}/display-mipi.dtbo \
    freescale/${MACHINE}/ext-gpio.dtbo \
    freescale/${MACHINE}/ext-i2c2.dtbo \
    freescale/${MACHINE}/ext-i2c3.dtbo \
    freescale/${MACHINE}/ext-pwm1.dtbo \
    freescale/${MACHINE}/ext-pwm2.dtbo \
    freescale/${MACHINE}/ext-pwm3.dtbo \
    freescale/${MACHINE}/ext-spi1.dtbo \
    freescale/${MACHINE}/ext-uart2.dtbo \
    freescale/${MACHINE}/ext-wm8960.dtbo \
    freescale/${MACHINE}/usb0-device.dtbo \
"

KERNEL_DEVICETREE2:maaxboard8ulp = " \
    freescale/${MACHINE}/camera-ov5640.dtbo \
    freescale/${MACHINE}/display-mipi.dtbo \
    freescale/${MACHINE}/ext-gpio.dtbo \
    freescale/${MACHINE}/ext-i2c4.dtbo \
    freescale/${MACHINE}/ext-spi5.dtbo \
    freescale/${MACHINE}/ext-uart4.dtbo \
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

do_deploy:append(){
    install -d ${DEPLOYDIR}/overlays
    cp ${WORKDIR}/build/arch/arm64/boot/dts/freescale/${MACHINE}/*.dtbo ${DEPLOYDIR}/overlays
}
