require recipes-kernel/linux/linux-maaxboard-mini-src-base-4.14.98.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# Diff based the below commit
# commit 7dacd1bfaaa4080a276f809d4ca1a2b110afd323 (origin/maaxboard_4.14.98_2.0.0_ga)
# Author: Nick <bin.cheng@embest-tech.com>
# Date:   Fri Mar 13 07:59:43 2020 +0000
#     PMIC:DTS:MAAXBOARD_MINI: emable the power always-on for GPU

SRC_URI += " \
        file://imx8mm-5d6cbeafb80c52af322a45985aa7b41f9b9ec66c-7dacd1bfaaa4080a276f809d4ca1a2b110afd323.diff \
"
