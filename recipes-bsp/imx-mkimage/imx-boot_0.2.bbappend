FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI = "${IMX_MKIMAGE_SRC};nobranch=1"

# commit 2cf091c075ea1950afa22a56e224dc4e448db542 tag: rel_imx_4.14.78_1.0.0_ga
SRCREV = "2cf091c075ea1950afa22a56e224dc4e448db542"


# The latest commit
# commit 9a299d31a2045db3eafb7ee61ec3c7ee87225d53 (HEAD -> develop_imx_4.14.78_1.0.0_ga, origin/develop_imx_4.14.78_1.0.0_ga, origin/HEAD)
# Author: Nick <bin.cheng@embest-tech.com>
# Date:   Wed Jul 15 02:18:39 2020 +0000
#     iMX8MQ: MaaXBoard: Rename em-sbc-imx8m to maaxboard

SRC_URI += " \
        file://2cf091c075ea1950afa22a56e224dc4e448db542-9a299d31a2045db3eafb7ee61ec3c7ee87225d53.diff \
"

