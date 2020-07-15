FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI = "${UBOOT_SRC};nobranch=1"
# commit 654088cc211e021387b04a8c33420739da40ebbe (tag: rel_imx_4.14.78_1.0.0_ga)
SRCREV = "654088cc211e021387b04a8c33420739da40ebbe"

# The latest commit
# commit 11dfc0c5c42c45904943779a2961c6e2129341d6 (HEAD -> maaxboard_v2018.03_4.14.78_1.0.0_ga, origin/maaxboard_v2018.03_4.14.78_1.0.0_ga)
# Author: Nick <bin.cheng@embest-tech.com>
# Date:   Wed Jul 15 02:32:46 2020 +0000
#     UART:MaaXBoard_Mini: modify the debug console
#             Change the debug console to ttymxc0


# NOT WORK: git format-patch 654088cc211e021387b04a8c33420739da40ebbe..37a75d5165eb0f7c12063374623c00edd1b6970a

# Because there has some binaries in the repo, do_patch will run failed without -f
# We can use git diff to create the patch, first checkout the latest branch,
# remove tools/imx-boot, this will not be used in yocto

# git checkout develop
# rm -rf tools/imx-boot
# git diff --patch 654088cc211e021387b04a8c33420739da40ebbe --output=654088cc211e021387b04a8c33420739da40ebbe-11dfc0c5c42c45904943779a2961c6e2129341d6.diff
SRC_URI += " \
        file://654088cc211e021387b04a8c33420739da40ebbe-11dfc0c5c42c45904943779a2961c6e2129341d6.diff \
"
LOCALVERSION = "-4.14.78_1.0.0"

