# FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

UBOOT_SRC:maaxboardbase = "${MAAXBOARD_GIT_HOST_MIRROR}/uboot-imx.git;${MAAXBOARD_GIT_PROTOCOL}"
UBOOT_BRANCH:maaxboardbase = "maaxboard_lf-5.15.5-1.0.0"
SRC_URI:maaxboardbase = "${UBOOT_SRC};branch=${UBOOT_BRANCH};${MAAXBOARD_GIT_USER}"

SRCREV:maaxboard8ulp = "${AUTOREV}"

do_deploy:append:maaxboardbase() {
    # Deploy u-boot-nodtb.bin and maaxboard*-XX.dtb for mkimage to generate boot binary
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