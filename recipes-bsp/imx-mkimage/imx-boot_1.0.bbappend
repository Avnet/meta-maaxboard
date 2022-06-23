# Copyright 2022 AVNET

IMX_M4_DEMOS      = ""
M4_DEFAULT_IMAGE ?= "m4_image.bin"

# Setting for i.MX 8ULP
IMX_M4_DEMOS:mx8ulp = "imx-m33-demos:do_deploy"
M4_DEFAULT_IMAGE:mx8ulp = "imx8ulp_m33_TCM_rpmsg_lite_str_echo_rtos.bin"
ATF_MACHINE_NAME:mx8ulp = "bl31-imx8ulp.bin"
IMX_EXTRA_FIRMWARE:mx8ulp = "firmware-upower firmware-sentinel"
SECO_FIRMWARE_NAME:mx8ulp = "mx8ulpa0-ahab-container.img"
SOC_TARGET:mx8ulp = "iMX8ULP"
SOC_FAMILY:mx8ulp = "mx8ulp"


do_compile[depends] += "${IMX_M4_DEMOS}"

do_compile:prepend() {
    case ${SOC_FAMILY} in
    mx8ulp)
        cp ${DEPLOY_DIR_IMAGE}/${M4_DEFAULT_IMAGE}       ${BOOT_STAGING}/m33_image.bin
        ;;
    esac
}

compile_mx8ulp() {
    bbnote 8ULP boot binary build
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME} ${BOOT_STAGING}/bl31.bin
    cp ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME}                     ${BOOT_STAGING}/u-boot.bin
    if [ -e ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} ] ; then
        cp ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} \
                                                             ${BOOT_STAGING}/u-boot-spl.bin
    fi

    # Copy SECO F/W and upower.bin
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${SECO_FIRMWARE_NAME}  ${BOOT_STAGING}/
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/upower.bin          ${BOOT_STAGING}/upower.bin
}

do_deploy:append() {
    case ${SOC_FAMILY} in
    mx8ulp)
        install -m 0644 ${BOOT_STAGING}/m33_image.bin        ${DEPLOYDIR}/${BOOT_TOOLS}
        ;;
    esac
}

deploy_mx8ulp() {
    install -d ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0755 ${S}/${TOOLS_NAME}                       ${DEPLOYDIR}/${BOOT_TOOLS}
    if [ -e ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} ] ; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} \
                                                             ${DEPLOYDIR}/${BOOT_TOOLS}
    fi
}

alias_uboot_dtb_name() {
	target_dtb_name=""
    case ${SOC_FAMILY} in
    mx8ulp)
        target_dtb_name="imx8ulp-evk.dtb"
        ;;
    esac
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME}  ${BOOT_STAGING}/${target_dtb_name}
}

do_compile:maaxboardbase() {
    # mkimage for i.MX8
    # Copy TEE binary to SoC target folder to mkimage
    if ${DEPLOY_OPTEE}; then
        cp ${DEPLOY_DIR_IMAGE}/tee.bin ${BOOT_STAGING}
    fi
    for target in ${IMXBOOT_TARGETS}; do
        compile_${SOC_FAMILY}
        if [ "$target" = "flash_linux_m4_no_v2x" ]; then
           # Special target build for i.MX 8DXL with V2X off
           bbnote "building ${IMX_BOOT_SOC_TARGET} - ${REV_OPTION} V2X=NO ${target}"
           make SOC=${IMX_BOOT_SOC_TARGET} ${REV_OPTION} V2X=NO dtbs=${UBOOT_DTB_NAME} flash_linux_m4
        else
           alias_uboot_dtb_name
           bbnote "building ${IMX_BOOT_SOC_TARGET} - ${REV_OPTION} ${target}"
           make SOC=${IMX_BOOT_SOC_TARGET} ${REV_OPTION} ${target}
        fi
        if [ -e "${BOOT_STAGING}/flash.bin" ]; then
            cp ${BOOT_STAGING}/flash.bin ${S}/${BOOT_CONFIG_MACHINE}-${target}
        fi
    done
}