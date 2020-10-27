# Embest MaaxBoard Mini common settings

MACHINEOVERRIDES =. "mx8:mx8m:mx8mn:"
MACHINEOVERRIDES =. "maaxboardbase:maaxboardnano:"

require conf/machine/include/imx-base.inc
require conf/machine/include/tune-cortexa53.inc

MACHINE_FEATURES += " wifi bluetooth nxp8987"

KERNEL_DEVICETREE  = "freescale/maaxboard-nano-mipi.dtb"

WKS_FILE_DEPENDS_append = " uenv"
IMAGE_BOOT_FILES += "uEnv.txt"


UBOOT_CONFIG ??= "sd"
UBOOT_CONFIG[sd] = "maaxboard_nano_defconfig,sdcard"

# Set u-boot DTB
UBOOT_DTB_NAME = "maaxboard-nano-mipi.dtb"

# Set imx-mkimage boot target
IMXBOOT_TARGETS = "flash_ddr4_evk"

# Used by poky/meta/recipes-bsp/u-boot/u-boot.inc
SPL_BINARY = "spl/u-boot-spl.bin"

# Set DDR FIRMWARE
# Refer to meta-fsl-bsp-release/imx/meta-bsp/recipes-bsp/imx-mkimage/imx-boot_1.0.bb
# meta-fsl-bsp-release/imx/meta-bsp/recipes-bsp/firmware-imx/firmware-imx-8m_8.8.bb
DDR_FIRMWARE_NAME = "ddr4_imem_1d_201810.bin ddr4_dmem_1d_201810.bin ddr4_imem_2d_201810.bin ddr4_dmem_2d_201810.bin"
# DDR_FW_VERSION = "201810"


# More refer to meta-fsl-bsp-release/imx/meta-bsp/classes/image_types_fsl.bbclass
IMAGE_BOOTLOADER = "imx-boot"
IMX_BOOT_SEEK = "32"

# Boot partition size [in KiB] for kernel and other data
# More refer to meta-fsl-bsp-release/imx/meta-bsp/classes/image_types_fsl.bbclass
BOOT_SPACE = "65536"

# uboot-imx/include/configs/maaxboard_mini.h
# Refer to linux-imx/drivers/tty/serial/imx.c
SERIAL_CONSOLES = "115200;ttymxc1"

LOADADDR = ""
UBOOT_SUFFIX = "bin"
UBOOT_MAKE_TARGET = ""

PREFERRED_PROVIDER_virtual/bootloader = "u-boot-imx"
PREFERRED_PROVIDER_u-boot = "u-boot-imx"
PREFERRED_VERSION_u-boot-imx = "2020.04"

# meta-fsl-bsp-release/imx/meta-bsp/conf/machine/include/imx-base.inc
PREFERRED_PROVIDER_virtual/kernel = "linux-imx"
PREFERRED_VERSION_linux-imx = "5.4"
PREFERRED_VERSION_linux-imx-headers = "5.4"

