IMX_EXTRA_FIRMWARE = "firmware-imx-8m"

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
        make SOC=${SOC_TARGET} ${REV_OPTION} ${target}
        if [ -e "${BOOT_STAGING}/flash.bin" ]; then
            cp ${BOOT_STAGING}/flash.bin ${S}/${BOOT_CONFIG_MACHINE}-${target}
        fi
    done
}
