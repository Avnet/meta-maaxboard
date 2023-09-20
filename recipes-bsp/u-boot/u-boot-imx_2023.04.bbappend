
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

UBOOT_SRC:maaxboardbase = "${MAAXBOARD_GIT_HOST_MIRROR}/uboot-imx.git;${MAAXBOARD_GIT_PROTOCOL}"
UBOOT_BRANCH:maaxboardbase = "maaxboard_lf-6.1.22-2.0.0"
SRC_URI:maaxboardbase = "${UBOOT_SRC};branch=${UBOOT_BRANCH};${MAAXBOARD_GIT_USER}"

SRCREV:maaxboardbase = "${AUTOREV}"

do_deploy:append:maaxboardbase() {
    # Deploy u-boot-nodtb.bin and fsl-imx8m*-XX.dtb for mkimage to generate boot binary
    if [ -n "${UBOOT_CONFIG}" ]
    then
        for config in ${UBOOT_MACHINE}; do
            i=$(expr $i + 1);
            for type in ${UBOOT_CONFIG}; do
                j=$(expr $j + 1);
                if [ $j -eq $i ]
                then
                    install -d ${DEPLOYDIR}/${BOOT_TOOLS}
                    install -m 0777 ${B}/${config}/arch/arm/dts/${UBOOT_DTB_NAME}  ${DEPLOYDIR}/${BOOT_TOOLS}
                    install -m 0777 ${B}/${config}/u-boot-nodtb.bin  ${DEPLOYDIR}/${BOOT_TOOLS}/u-boot-nodtb.bin-${MACHINE}-${type}
                fi
            done
            unset  j
        done
        unset  i
    fi
}
