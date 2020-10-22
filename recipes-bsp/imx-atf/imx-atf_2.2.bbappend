FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_maaxboardnano = " \
        ${ATF_SRC};branch=${SRCBRANCH} \
        file://imx8mn_bl31_corext_m7_domain_peripherals_assignment_uart4_no_rw_access.diff \
"
