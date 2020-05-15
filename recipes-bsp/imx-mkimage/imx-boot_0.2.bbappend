FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI = "${IMX_MKIMAGE_SRC};nobranch=1"

# commit 2cf091c075ea1950afa22a56e224dc4e448db542 tag: rel_imx_4.14.78_1.0.0_ga
SRCREV = "2cf091c075ea1950afa22a56e224dc4e448db542"

# Diff from git@192.168.2.149:ahnniu/imx-mkimage.git
# a87e9c4e98ee5574d014493f850050c5f16b2787
SRC_URI += " \
        file://add-maaxboard-support.diff \
"

