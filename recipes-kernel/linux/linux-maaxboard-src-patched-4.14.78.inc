require recipes-kernel/linux/linux-maaxboard-src-base-4.14.78.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# commit 509b965acc52a46934f43ea9a7a290c7f8d7fd93 (origin/maaxboard_4.14.78_1.0.0_ga)
# Author: Nick <bin.cheng@embest-tech.com>
# Date:   Thu Jul 2 03:15:25 2020 +0000
#     Revert "GPIOMEM:DEFCONFIG:MaaXBoard: Add gpiomem support for Maaxboard"

SRC_URI += " \
        file://imx8m-66620c3d281c5a5b27cbb7a51276d2f94f619f1c-509b965acc52a46934f43ea9a7a290c7f8d7fd93.diff \
"
