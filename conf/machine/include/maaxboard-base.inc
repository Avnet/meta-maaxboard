# Embest MaaxBoard common settings

MACHINEOVERRIDES =. "mx8:mx8m:mx8mq:"
MACHINEOVERRIDES =. "maaxboardbase:maaxboard:"

require conf/machine/include/imx-base.inc
require conf/machine/include/tune-cortexa53.inc

MACHINE_FEATURES += " pci wifi bluetooth bcm43455"

MACHINE_SOCARCH_FILTER_append_mx8mq = " virtual/libopenvg virtual/libgles1 virtual/libgles2 virtual/egl virtual/mesa virtual/libgl virtual/libg2d"

KERNEL_DEVICETREE = "freescale/maaxboard-base.dtb"

WKS_FILE_DEPENDS_append = " uenv"
IMAGE_BOOT_FILES += "uEnv.txt"
IMAGE_BOOT_FILES += "readme.txt"
IMAGE_BOOT_FILES += " overlays/*;overlays/"

UBOOT_CONFIG ??= "sd"
UBOOT_CONFIG[sd] = "maaxboard_defconfig,sdcard"

# Set u-boot DTB
UBOOT_DTB_NAME = "maaxboard.dtb"

# Set imx-mkimage boot target
IMXBOOT_TARGETS = "flash_ddr4_val"

# Used by poky/meta/recipes-bsp/u-boot/u-boot.inc
SPL_BINARY = "spl/u-boot-spl.bin"

# Set DDR FIRMWARE
# Refer to meta-fsl-bsp-release/imx/meta-bsp/recipes-bsp/imx-mkimage/imx-boot_0.2.bb
# meta-fsl-bsp-release/imx/meta-bsp/recipes-bsp/firmware-imx/firmware-imx_8.4.bb
DDR_FIRMWARE_NAME = "ddr4_imem_1d_201810.bin ddr4_dmem_1d_201810.bin ddr4_imem_2d_201810.bin ddr4_dmem_2d_201810.bin"

# More refer to meta-fsl-bsp-release/imx/meta-bsp/classes/image_types_fsl.bbclass
IMAGE_BOOTLOADER = "imx-boot"
IMX_BOOT_SEEK = "33"
OPTEE_BIN_EXT = "8mq"

# Boot partition size [in KiB] for kernel and other data
# More refer to meta-fsl-bsp-release/imx/meta-bsp/classes/image_types_fsl.bbclass
BOOT_SPACE = "65536"

# Refer to linux-imx/drivers/tty/serial/imx.c
SERIAL_CONSOLES = "115200;ttymxc0"

LOADADDR = ""
UBOOT_SUFFIX = "bin"
UBOOT_MAKE_TARGET = ""

PREFERRED_PROVIDER_virtual/bootloader = "u-boot-imx"
PREFERRED_PROVIDER_u-boot = "u-boot-imx"
PREFERRED_VERSION_u-boot-imx = "2021.04"

# meta-fsl-bsp-release/imx/meta-bsp/conf/machine/include/imx-base.inc
PREFERRED_PROVIDER_virtual/kernel = "linux-imx"
PREFERRED_VERSION_linux-imx = "5.4"
PREFERRED_VERSION_linux-imx-headers = "5.4"

# Use gstreamer 1.14 from meta-freescale
PREFERRED_VERSION_gstreamer1.0 ?= "1.14.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-base ?= "1.14.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-good ?= "1.14.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-bad ?= "1.14.imx"
PREFERRED_VERSION_gstreamer1.0-libav ?= "1.14.0"

# /etc/hostname
hostname_pn-base-files = "maaxboard"
