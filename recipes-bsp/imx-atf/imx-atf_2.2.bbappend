FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRCBRANCH_maaxboardmini = "maaxboard_5.4.24_2.1.0"
ATF_SRC_maaxboardmini = "${MAAXBOARD_GIT_HOST_MIRROR}/imx-atf.git;protocol=https"
SRCREV_maaxboardmini = "d801fd97ea9606bf5a686334639abac2ddb77985"

SRC_URI_maaxboardnano = " \
        ${ATF_SRC};branch=${SRCBRANCH} \
        file://imx8mn_bl31_corext_m7_domain_peripherals_assignment_uart4_no_rw_access.diff \
"
