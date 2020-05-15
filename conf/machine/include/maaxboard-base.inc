# Embest MaaxBoard common settings

MACHINEOVERRIDES =. "mx8:mx8m:mx8mq:"
MACHINEOVERRIDES =. "maaxboard:"

require conf/machine/include/imx-base.inc
require conf/machine/include/arm/arch-arm64.inc

# MACHINE_FEATURES += " pci wifi bluetooth optee qca6174 bcm43455 bcm4356 bcm4359"
MACHINE_FEATURES += " pci wifi bluetooth qca6174 bcm43455 bcm4356 bcm4359"

KERNEL_DEVICETREE += "freescale/em-sbc-imx8m.dtb"


# UBOOT_CONFIG ??= "sd"
# UBOOT_CONFIG[sd] = "imx8mq_evk_config,sdcard"
# Used by poky/meta/recipes-bsp/u-boot/u-boot.inc
SPL_BINARY = "spl/u-boot-spl.bin"

# Set DDR FIRMWARE
# Refer to meta-fsl-bsp-release/imx/meta-bsp/recipes-bsp/imx-mkimage/imx-boot_0.2.bb
# meta-fsl-bsp-release/imx/meta-bsp/recipes-bsp/firmware-imx/firmware-imx_8.4.bb
DDR_FIRMWARE_NAME = "ddr4_dmem_1d.bin ddr4_dmem_2d.bin ddr4_imem_1d.bin ddr4_imem_2d.bin"

# Set u-boot DTB
# UBOOT_DTB_NAME = "fsl-imx8mq-ddr4-maaxboard.dtb"
UBOOT_DTB_NAME = "em-sbc-imx8m.dtb"

# Set imx-mkimage boot target
# IMXBOOT_TARGETS = "flash_ddr4_maaxboard flash_ddr4_maaxboard_no_hdmi"

# More refer to meta-fsl-bsp-release/imx/meta-bsp/classes/image_types_fsl.bbclass
IMAGE_BOOTLOADER = "imx-boot"
IMX_BOOT_SEEK = "33"

# Boot partition size [in KiB] for kernel and other data
# More refer to meta-fsl-bsp-release/imx/meta-bsp/classes/image_types_fsl.bbclass
BOOT_SPACE = "65536"

# arch/arm/dts/fsl-imx8mq-ddr4-maaxboard.dts -> chosen -> bootargs
# Refer to linux-imx/drivers/tty/serial/imx.c
SERIAL_CONSOLES = "115200;ttymxc0"

# Not Used
# LOADADDR = ""
UBOOT_SUFFIX = "bin"
UBOOT_MAKE_TARGET = "all"

PREFERRED_PROVIDER_virtual/bootloader = "u-boot-imx"
PREFERRED_PROVIDER_u-boot = "u-boot-imx"

# meta-fsl-bsp-release/imx/meta-bsp/conf/machine/include/imx-base.inc
PREFERRED_PROVIDER_virtual/kernel = "linux-imx"
# PREFERRED_VERSION_linux-imx = "4.14.78"

PREFERRED_PROVIDER_virtual/imxvpu = "imx-vpu-hantro"

