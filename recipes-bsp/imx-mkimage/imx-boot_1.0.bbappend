# Copyright 2023 AVNET
# Reference: meta-imx/meta-bsp/recipes-bsp/imx-mkimage/imx-boot_1.0.bbappend

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# SECO firmware(mx8ulpa0-ahab-container.img) from firmware-sentinel-0.9 will reboot failure
# in linux system, so we replace it by the one from firmware-sentinel-0.8.
SRC_URI += " file://maaxboard_8ulp_m33_image.bin "
SRC_URI += " file://mx8ulpa0-ahab-container.img "

IMX_M4_DEMOS      = ""
IMX_M4_DEMOS:mx8-nxp-bsp  = "imx-m4-demos:do_deploy"
IMX_M4_DEMOS:mx8m-nxp-bsp = ""

# Setting for i.MX 8ULP
IMX_M4_DEMOS:mx8ulp-nxp-bsp = "imx-m33-demos:do_deploy"
M4_DEFAULT_IMAGE:mx8ulp-nxp-bsp = "maaxboard_8ulp_m33_image.bin"
ATF_MACHINE_NAME:mx8ulp-nxp-bsp = "bl31-imx8ulp.bin"
IMX_EXTRA_FIRMWARE:mx8ulp-nxp-bsp = "firmware-upower firmware-sentinel"
SOC_TARGET:mx8ulp-nxp-bsp = "iMX8ULP"
SOC_FAMILY:mx8ulp-nxp-bsp = "mx8ulp"

IS_DXL                = "false"

do_compile[depends] += "${IMX_M4_DEMOS}"

do_compile:prepend() {
    case ${SOC_FAMILY} in
    mx8ulp)
        install -m 0755 ${WORKDIR}/${M4_DEFAULT_IMAGE}       ${DEPLOY_DIR_IMAGE}/${M4_DEFAULT_IMAGE}
        install -m 0755 ${WORKDIR}/${M4_DEFAULT_IMAGE}       ${BOOT_STAGING}/m33_image.bin
        install -m 0755 ${WORKDIR}/${SECO_FIRMWARE_NAME}     ${DEPLOY_DIR_IMAGE}/${SECO_FIRMWARE_NAME}
        ;;
    esac
}

compile_mx8ulp() {
    bbnote 8ULP boot binary build
    cp ${DEPLOY_DIR_IMAGE}/${SECO_FIRMWARE_NAME}             ${BOOT_STAGING}/
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME} ${BOOT_STAGING}/bl31.bin
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/upower.bin          ${BOOT_STAGING}/upower.bin
    cp ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME}                     ${BOOT_STAGING}/u-boot.bin
    if [ -e ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} ] ; then
        cp ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} \
                                                             ${BOOT_STAGING}/u-boot-spl.bin
    fi
}

do_deploy:append() {
    case ${SOC_FAMILY} in
    mx8ulp)
        install -m 0755 ${BOOT_STAGING}/m33_image.bin         ${DEPLOYDIR}/${BOOT_TOOLS}
        install -m 0755 ${BOOT_STAGING}/${SECO_FIRMWARE_NAME} ${DEPLOYDIR}/${BOOT_TOOLS}
        ;;
    esac
}

deploy_mx8ulp() {
    install -d ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0644 ${BOOT_STAGING}/${SECO_FIRMWARE_NAME}    ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0755 ${S}/${TOOLS_NAME}                       ${DEPLOYDIR}/${BOOT_TOOLS}
    if [ -e ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} ] ; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} \
                                                             ${DEPLOYDIR}/${BOOT_TOOLS}
    fi
}

copy_uboot_dtb() {
    local target_dtb_name=

    case ${MACHINE} in
        maaxboard-8ulp)
            target_dtb_name=imx8ulp-evk.dtb
            ;;
        maaxboard)
            target_dtb_name=imx8mq-ddr4-val.dtb
            ;;
        maaxboard-mini)
            target_dtb_name=imx8mm-ddr4-evk.dtb
            ;;
        maaxboard-nano)
            target_dtb_name=imx8mn-ddr4-evk.dtb
            ;;
    esac

    bbnote "Copy $(basename ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME}) to $(basename ${BOOT_STAGING}/${target_dtb_name})"
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME}   ${BOOT_STAGING}/${target_dtb_name}
}

do_compile:maaxboardbase() {
    # mkimage for i.MX8
    # Copy TEE binary to SoC target folder to mkimage
    if ${DEPLOY_OPTEE}; then
        cp ${DEPLOY_DIR_IMAGE}/tee.bin                       ${BOOT_STAGING}
    fi

    # mkimage for i.MX8
    for target in ${IMXBOOT_TARGETS}; do
        compile_${SOC_FAMILY}

        copy_uboot_dtb

        bbnote "building ${IMX_BOOT_SOC_TARGET} - ${REV_OPTION} ${target}"
        #make SOC=${IMX_BOOT_SOC_TARGET} ${REV_OPTION} ${target}
        make SOC=${IMX_BOOT_SOC_TARGET} ${target}

        if [ -e "${BOOT_STAGING}/flash.bin" ]; then
            cp ${BOOT_STAGING}/flash.bin ${S}/${BOOT_CONFIG_MACHINE}-${target}
        fi
    done
}

COMPATIBLE_MACHINE = "(mx8-generic-bsp|mx9-generic-bsp)"
