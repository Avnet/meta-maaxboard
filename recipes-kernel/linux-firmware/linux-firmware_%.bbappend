FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

DTS_BOARD_NAME ?= ""
DTS_BOARD_NAME_maaxboard="avnet,maaxboard"

# Firmware for AzureWave AW-CM390SM Modules
SRC_URI += " \
            file://AW_CM390SM.tar.bz2;unpack=true;subdir=maaxboard-firmware \
            file://NXP_firmware_bt.tar.gz;unpack=true;subdir=maaxboard-firmware \
"

az_install_firmware() {
    # Install AzureWave AW-CM390SM firmware
    install -m 0644 ${WORKDIR}/maaxboard-firmware/AW_CM390SM/brcm/brcmfmac43455-sdio.bin ${D}${nonarch_base_libdir}/firmware/brcm
    install -m 0644 ${WORKDIR}/maaxboard-firmware/AW_CM390SM/brcm/brcmfmac43455-sdio.clm_blob ${D}${nonarch_base_libdir}/firmware/brcm
    install -m 0644 ${WORKDIR}/maaxboard-firmware/AW_CM390SM/brcm/brcmfmac43455-sdio.txt ${D}${nonarch_base_libdir}/firmware/brcm
    cd ${D}${nonarch_base_libdir}/firmware/brcm
    ln -s brcmfmac43455-sdio.txt brcmfmac43455-sdio.${DTS_BOARD_NAME}.txt
}

az_install_firmware_aw(){
    install -d ${D}${nonarch_base_libdir}/firmware/nxp/aw/
    install -m 0644 ${WORKDIR}/maaxboard-firmware/NXP_firmware_bt/nxp/sd8987_wlan.bin ${D}${nonarch_base_libdir}/firmware/nxp/
    install -m 0644 ${WORKDIR}/maaxboard-firmware/NXP_firmware_bt/nxp/uart8987_bt.bin ${D}${nonarch_base_libdir}/firmware/nxp/
    install -m 0644 ${WORKDIR}/maaxboard-firmware/NXP_firmware_bt/nxp/sduart8987_combo.bin ${D}${nonarch_base_libdir}/firmware/nxp/
    # install -m 0644 ${WORKDIR}/maaxboard-firmware/NXP_firmware_bt/nxp/wifi_mod_para_sd8987.conf ${D}${nonarch_base_libdir}/firmware/nxp/
}

do_install_append_maaxboard () {
    az_install_firmware
}

do_install_append_maaxboardmini () {
    az_install_firmware
}

do_install_append_maaxboardnano () {
    az_install_firmware_aw
}
