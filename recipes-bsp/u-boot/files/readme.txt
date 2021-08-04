# How to configure the environment variables in uEnv.txt

It is possible to set an environment variable in uEnv.txt. To load the devicetree overlay file from
"overlay/" folder, you should set "enable_overlay_" or "fdt_extra_overlays". Also you can set some 
environment variables from uboot to overwrite the old settings.

Refer to the following description for different boards.


## For MaaXBoard U-Boot Env
/-----------------------|--------------|------------------------------
|       Config          | Value if set |     To be loading
|-----------------------|--------------|------------------------------
|                       |  'hdmi'      |  maaxboard-hdmi.dtbo
| enable_overlay_disp   |  'mipi'      |  maaxboard-mipi.dtbo
|                       |  'dual'      |  maaxboard-dual-display.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_gpio   | '1' or 'yes' |  maaxboard-ext-gpio.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_i2c    | '1' or 'yes' |  maaxboard-ext-i2c.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_pwm    | '1' or 'yes' |  maaxboard-ext-pwm.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_spi    | '1' or 'yes' |  maaxboard-ext-spi.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_sai2   | '1' or 'yes' |  maaxboard-ext-sai2.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_uart2  | '1' or 'yes' |  maaxboard-ext-uart2.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_camera | '1' or 'yes' |  maaxboard-ov5640.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_usbgadget '1' or 'yes'|  maaxboard-usb0-device.dtbo
|---------------------------------------------------------------------
| fdt_file             : is a base dtb file, should be set maaxboard-base.dtb
|---------------------------------------------------------------------
| fdt_extra_overlays   : other dtbo files to be loading, such as maaxboard-ext-wm8960.dtbo
|---------------------------------------------------------------------
|---------------------------------------------------------------------
|  uboot env   : you could set some environment variables of u-boot here, such as 'console=' 'bootargs=' 
\---------------------------------------------------------------------
default setting:
    fdt_file=maaxboard-base.dtb
    enable_overlay_disp=hdmi
    enable_overlay_gpio=1
    #fdt_extra_overlays=1.dtbo 2.dtbo 3.dtbo
    console=ttymxc0,115200 console=tty1


#-----------------------------------------------------------------------------------------
## For MaaXBoard-Mini U-Boot Env
/-----------------------|--------------|------------------------------
|       Config          | Value if set |     To be loading
|-----------------------|--------------|------------------------------
| enable_overlay_mipi   | '1' or 'yes' |  maaxboard-mini-mipi.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_gpio   | '1' or 'yes' |  maaxboard-mini-ext-gpio.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_i2c    | '1' or 'yes' |  maaxboard-mini-ext-i2c.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_pwm    | '1' or 'yes' |  maaxboard-mini-ext-pwm.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_spi    | '1' or 'yes' |  maaxboard-mini-ext-spi.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_sai3   | '1' or 'yes' |  maaxboard-mini-ext-sai3.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_uart2  | '1' or 'yes' |  maaxboard-mini-ext-uart2.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_camera | '1' or 'yes' |  maaxboard-mini-ov5640.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_usbgadget '1' or 'yes'|  maaxboard-mini-usb1-device.dtbo
|---------------------------------------------------------------------
| fdt_file             : is a base dtb file, should be set maaxboard-mini-base.dtb
|---------------------------------------------------------------------
| fdt_extra_overlays   : other dtbo files to be loading, such as maaxboard-mini-ext-wm8960.dtbo
|---------------------------------------------------------------------
|---------------------------------------------------------------------
| uboot env   : you could set some environment variables of u-boot here, such as 'console=' 'bootargs=' 
\---------------------------------------------------------------------
default setting:
    fdt_file=maaxboard-mini-base.dtb
    enable_overlay_mipi=1
    enable_overlay_gpio=1
    #fdt_extra_overlays=1.dtbo 2.dtbo 3.dtbo
    console=ttymxc0,115200 console=tty1


#-----------------------------------------------------------------------------------------
## For MaaXBoard-Nano U-Boot Env
/-----------------------|--------------|------------------------------
|       Config          | Value if set |     To be loading
|-----------------------|--------------|------------------------------
| enable_overlay_mipi   | '1' or 'yes' |  maaxboard-nano-mipi.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_gpio   | '1' or 'yes' |  maaxboard-nano-ext-gpio.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_i2c    | '1' or 'yes' |  maaxboard-nano-ext-i2c.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_pwm    | '1' or 'yes' |  maaxboard-nano-ext-pwm.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_spi    | '1' or 'yes' |  maaxboard-nano-ext-spi.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_uart4  | '1' or 'yes' |  maaxboard-nano-ext-uart4.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_camera | '1' or 'yes' |  maaxboard-nano-ov5640.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_audio  | '1' or 'yes' |  maaxboard-nano-audio.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_mic    | '1' or 'yes' |  maaxboard-nano-mic.dtbo
|---------------------------------------------------------------------
| fdt_file             : is a base dtb file, should be set maaxboard-nano-base.dtb
|---------------------------------------------------------------------
| fdt_extra_overlays   : other dtbo files to be loading, such as 1.dtbo 2.dtbo 3.dtbo
|---------------------------------------------------------------------
|---------------------------------------------------------------------
| uboot env   : you could set some environment variables of u-boot here, such as 'console=' 'bootargs=' 
\---------------------------------------------------------------------
default setting:
    fdt_file=maaxboard-nano-base.dtb
    enable_overlay_mipi=1
    enable_overlay_audio=1
    enable_overlay_mic=1
    enable_overlay_gpio=1
    #fdt_extra_overlays=1.dtbo 2.dtbo 3.dtbo
    console=ttymxc1,115200 console=tty1


