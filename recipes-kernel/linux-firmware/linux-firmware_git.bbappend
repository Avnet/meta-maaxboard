FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# Firmware for AzureWave AW-CM390SM Modules
SRC_URI += " \
            file://AW_CM390SM.tar.bz2;unpack=true;subdir=maaxboard-firmware \
"

do_install_append_maaxboard () {
    # Install AzureWave AW-CM390SM firmware
    install -m 0644 ${WORKDIR}/maaxboard-firmware/AW_CM390SM/brcm/brcmfmac43455-sdio.bin ${D}${nonarch_base_libdir}/firmware/brcm
    install -m 0644 ${WORKDIR}/maaxboard-firmware/AW_CM390SM/brcm/brcmfmac43455-sdio.clm_blob ${D}${nonarch_base_libdir}/firmware/brcm
    install -m 0644 ${WORKDIR}/maaxboard-firmware/AW_CM390SM/brcm/brcmfmac43455-sdio.txt ${D}${nonarch_base_libdir}/firmware/brcm    
}