require recipes-kernel/linux/linux-maaxboard-src-5.15.inc

KERNEL_DEF_CONFIG ??= "imx_v8_defconfig"
KERNEL_DEF_CONFIG:maaxboard8ulp = "maaxboard_8ulp_defconfig"

do_copy_defconfig:maaxboardbase () {
    install -d ${B}
    # copy latest KERNEL_DEF_CONFIG to use for mx8
    mkdir -p ${B}
	cp ${S}/arch/arm64/configs/${KERNEL_DEF_CONFIG} ${B}/.config
}

KERNEL_DTC_FLAGS = "-@"

KERNEL_DEVICETREE2 ?= ""
KERNEL_DEVICETREE2:maaxboard8ulp  = " \
    freescale/overlays/maaxboard-8ulp-cam.dtbo \
    freescale/overlays/maaxboard-8ulp-ext-i2c.dtbo \
    freescale/overlays/maaxboard-8ulp-ext-uart.dtbo \
    freescale/overlays/maaxboard-8ulp-ext-gpio.dtbo \
    freescale/overlays/maaxboard-8ulp-ext-spi.dtbo \
    freescale/overlays/maaxboard-8ulp-mipi.dtbo \
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
    cp ${WORKDIR}/build/arch/arm64/boot/dts/freescale/overlays/* ${DEPLOYDIR}/overlays
}
