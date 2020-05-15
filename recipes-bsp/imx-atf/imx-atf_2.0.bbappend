
# Our u-boot-imx is based on tag rel_imx_4.14.78_1.0.0_ga
# imx-aft(bl31.bin) should also be rel_imx_4.14.78_1.0.0_ga
# Or, it cannot boot correctly

SRC_URI = "${ATF_SRC};nobranch=1"
################################################################################

# commit d6451cc1e162eff89b03dd63e86d55b9baa8885b tag: rel_imx_4.14.78_1.0.0_ga
SRCREV = "d6451cc1e162eff89b03dd63e86d55b9baa8885b"

