# Embest MaaxBoard Mini common settings

MACHINEOVERRIDES =. "mx8:mx8m:mx8mm:"
MACHINEOVERRIDES =. "maaxboardbase:maaxboardmini:"

require conf/machine/include/imx-base.inc
require conf/machine/include/tune-cortexa53.inc

MACHINE_FEATURES += " pci wifi bluetooth bcm43455"

KERNEL_DEVICETREE  = "freescale/maaxboard-mini-mipi.dtb"
KERNEL_DEVICETREE += "freescale/maaxboard-mini-lvds.dtb"
KERNEL_DEVICETREE += "freescale/maaxboard-mini-device.dtb"

WKS_FILE_DEPENDS_append = " uenv"
IMAGE_BOOT_FILES += "uEnv.txt"

UBOOT_CONFIG ??= "sd"
UBOOT_CONFIG[sd] = "maaxboard_mini_defconfig,sdcard"

# Set u-boot DTB
UBOOT_DTB_NAME = "maaxboard-mini.dtb"

# Set imx-mkimage boot target
IMXBOOT_TARGETS = "flash_ddr4_evk"

# Used by poky/meta/recipes-bsp/u-boot/u-boot.inc
SPL_BINARY = "spl/u-boot-spl.bin"

# Set DDR FIRMWARE
DDR_FIRMWARE_NAME = "ddr4_imem_1d.bin ddr4_dmem_1d.bin ddr4_imem_2d.bin ddr4_dmem_2d.bin"

# More refer to meta-fsl-bsp-release/imx/meta-bsp/classes/image_types_fsl.bbclass
IMAGE_BOOTLOADER = "imx-boot"
IMX_BOOT_SEEK = "33"

# Boot partition size [in KiB] for kernel and other data
# More refer to meta-fsl-bsp-release/imx/meta-bsp/classes/image_types_fsl.bbclass
BOOT_SPACE = "65536"

# uboot-imx/include/configs/maaxboard_mini.h
# Refer to linux-imx/drivers/tty/serial/imx.c
SERIAL_CONSOLES = "115200;ttymxc0"

UBOOT_SUFFIX = "bin"
UBOOT_MAKE_TARGET = ""

PREFERRED_PROVIDER_virtual/bootloader = "u-boot-imx"
PREFERRED_PROVIDER_u-boot = "u-boot-imx"
PREFERRED_VERSION_u-boot-imx = "2020.04"

# meta-fsl-bsp-release/imx/meta-bsp/conf/machine/include/imx-base.inc
PREFERRED_PROVIDER_virtual/kernel = "linux-imx"
PREFERRED_VERSION_linux-imx = "5.4"
PREFERRED_VERSION_linux-imx-headers = "5.4"

# /etc/hostname
hostname_pn-base-files = "maaxboard-mini"

