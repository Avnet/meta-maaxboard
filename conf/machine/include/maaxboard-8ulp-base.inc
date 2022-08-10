# Avnet MaaxBoard 8ULP common settings

MACHINEOVERRIDES =. "mx8:mx8ulp:"
MACHINEOVERRIDES =. "maaxboardbase:maaxboard8ulp:"

require conf/machine/include/imx-base.inc
require conf/machine/include/arm/armv8a/tune-cortexa35.inc

DEFAULTTUNE:mx8ulp ?= "cortexa35-crypto"
MACHINEOVERRIDES_EXTENDER:mx8ulp = "imxdrm:imxgpu:imxgpu2d:imxgpu3d"
MACHINEOVERRIDES_EXTENDER_FILTER_OUT_use-mainline-bsp += " mx8ulp \
"
MACHINE_SOCARCH_SUFFIX = "-mx8ulp"
MACHINE_GSTREAMER_1_0_PLUGIN ?= "imx-gst1.0-plugin"
IMX_DEFAULT_KERNEL = "linux-imx"

IMX_DEFAULT_BSP = "nxp"

MACHINE_FEATURES += " wifi bluetooth"

KERNEL_DEVICETREE = " \
    freescale/${KERNEL_DEVICETREE_DTBNAME} \
"

IMX_DEFAULT_BOOTLOADER = "u-boot-imx"

LOADADDR = ""
UBOOT_SUFFIX = "bin"
UBOOT_MAKE_TARGET = ""
SPL_BINARY = "spl/u-boot-spl.bin"

UBOOT_CONFIG ??= "sd"
UBOOT_CONFIG[sd]   = "${UBOOT_CONFIG_NAME},sdcard"

# Set ATF platform name
ATF_PLATFORM = "imx8ulp"

# Set u-boot DTB
UBOOT_DTB_NAME = "${UBOOT_DEVICETREE_DTBNAME}"

# Set imx-mkimage boot target
IMXBOOT_TARGETS = "flash_singleboot_m33"

IMX_BOOT_SOC_TARGET = "iMX8ULP"
IMX_BOOT_SEEK = "32"

SERIAL_CONSOLES = "115200;ttyLP1"

# Add additional firmware
MACHINE_FIRMWARE:append = " firmware-imx-epdc"
MACHINE_FIRMWARE:append:mx8ulp = " sof-imx sof-zephyr"
