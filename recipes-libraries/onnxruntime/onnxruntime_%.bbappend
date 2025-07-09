LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://fix-eigen-hash.sed"

do_configure:prepend() {
    #before do_configure, using sed to modify the hash of eigen
    eigen_cmake="${OECMAKE_SOURCEPATH}/external/eigen.cmake"

    if [ -f "${eigen_cmake}" ]; then
        bbnote "Patching eigen.cmake hash with sed"
        sed -f ${UNPACKDIR}/fix-eigen-hash.sed -i ${eigen_cmake}
    else
        bbfatal "eigen.cmake not found at ${eigen_cmake}"
    fi
}