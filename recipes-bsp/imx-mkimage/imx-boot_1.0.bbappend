IMX_EXTRA_FIRMWARE = "firmware-imx-8m"
DDR_FW_VERSION = "_201810"

get_plat_by_soc() {
    local soc=$1
    local plat=
    case "${soc}" in
        "iMX8MM")
            plat=imx8mm
            ;;
        "iMX8MN")
            plat=imx8mn
            ;;
        "iMX8MP")
            plat=imx8mp
            ;;
        *)
            plat=imx8mq
            ;;
    esac
    echo "${plat}"
}

get_uboot_dtb_name_by_mk_target() {
    local soc=$1
    local mk_target=$2
    local plat=
    local name=

    plat=$(get_plat_by_soc ${soc})
    case "${mk_target}" in
        "flash_ddr4_val")
            name="${plat}-ddr4-val.dtb"
            ;;
        "flash_ddr4_evk")
            name="${plat}-ddr4-evk.dtb"
            ;;
        "flash_ddr3l_val")
            name="${plat}-ddr3l-val.dtb"
            ;;
    esac

    echo "${name}"
}

copy_uboot_dtb() {
    local target_dtb_name=$1
    bbnote "Copy $(basename ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME}) to $(basename ${BOOT_STAGING}/${target_dtb_name})"
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME}   ${BOOT_STAGING}/${target_dtb_name}
}

# # Rewrite compile_${SOC_FAMILY} -> compile_maaxboardbase if use our own DDR_FIRMWARE_NAME
# # DDR_FIRMWARE_NAME = "ddr4_dmem_1d.bin ddr4_dmem_2d.bin ddr4_imem_1d.bin ddr4_imem_2d.bin"
# # DDR_FW_VERSION = "201810"
# # instead of
# # DDR_FIRMWARE_NAME = "ddr4_imem_1d_201810.bin ddr4_dmem_1d_201810.bin ddr4_imem_2d_201810.bin ddr4_dmem_2d_201810.bin"
# # In this case, we should copy these ddr firmware name style from ddr4_dmem_1d.bin to ddr4_imem_1d_201810.bin
# # More refer to: imx-mkimage/iMX8M/soc.mak
# #
# #
# compile_maaxboardbase() {
#     bbnote 8MQ/8MM boot binary build
#     for ddr_firmware in ${DDR_FIRMWARE_NAME}; do
#         local fw_extension="${ddr_firmware##*.}"
#         local fw_basename="${ddr_firmware%.*}"
#         local fw_target_name="${fw_basename}_${DDR_FW_VERSION}.${fw_extension}"
#         bbnote "Copy ddr_firmware: ${ddr_firmware} from ${DEPLOY_DIR_IMAGE} -> ${BOOT_STAGING}/${fw_target_name} "
#         cp ${DEPLOY_DIR_IMAGE}/${ddr_firmware}               ${BOOT_STAGING}/${fw_target_name}
#     done
#     cp ${DEPLOY_DIR_IMAGE}/signed_dp_imx8m.bin               ${BOOT_STAGING}
#     cp ${DEPLOY_DIR_IMAGE}/signed_hdmi_imx8m.bin             ${BOOT_STAGING}
#     cp ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} \
#                                                              ${BOOT_STAGING}/u-boot-spl.bin
#     cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME}   ${BOOT_STAGING}
#     cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/u-boot-nodtb.bin-${MACHINE}-${UBOOT_CONFIG} \
#                                                              ${BOOT_STAGING}/u-boot-nodtb.bin
#     bbnote "\
# Using standard mkimage from u-boot-tools for FIT image builds. The standard \
# mkimage is compatible for this use, and using it saves us from having to \
# maintain a custom recipe."
#     ln -sf ${STAGING_DIR_NATIVE}${bindir}/mkimage            ${BOOT_STAGING}/mkimage_uboot
#     cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME} ${BOOT_STAGING}/bl31.bin
#     cp ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME}                     ${BOOT_STAGING}/u-boot.bin
# }


do_compile_maaxboardbase() {
    local dtb_target_name=

    compile_${SOC_FAMILY}

    # Copy TEE binary to SoC target folder to mkimage
    if ${DEPLOY_OPTEE}; then
        cp ${DEPLOY_DIR_IMAGE}/tee.bin                       ${BOOT_STAGING}
    fi
    # mkimage for i.MX8
    for target in ${IMXBOOT_TARGETS}; do
        dtb_target_name=$(get_uboot_dtb_name_by_mk_target ${SOC_TARGET} ${target})
        bbnote "generate ${dtb_target_name} for ${target} from ${UBOOT_DTB_NAME}"
        copy_uboot_dtb ${dtb_target_name}
        bbnote "building ${SOC_TARGET} - ${REV_OPTION} ${target}"
        make SOC=${SOC_TARGET} DDR_FW_VERSION=${DDR_FW_VERSION} ${REV_OPTION} ${target}
        if [ -e "${BOOT_STAGING}/flash.bin" ]; then
            cp ${BOOT_STAGING}/flash.bin ${S}/${BOOT_CONFIG_MACHINE}-${target}
        fi
    done
}
