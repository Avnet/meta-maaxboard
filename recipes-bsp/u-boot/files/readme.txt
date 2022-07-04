# How to configure the environment variables in uEnv.txt

It is possible to set an environment variable in uEnv.txt. To load the devicetree overlay file from
"overlay/" folder, you should set "enable_overlay_" or "fdt_extra_overlays". Also you can set some 
environment variables from uboot to overwrite the old settings.

Refer to the following description for different boards.

#-----------------------------------------------------------------------------------------
## For MaaXBoard-8ulp U-Boot Env
/-----------------------|--------------|------------------------------
|       Config          | Value if set |     To be loading
|-----------------------|--------------|------------------------------
| enable_overlay_disp   | '1' or 'yes' |  maaxboard-8ulp-mipi.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_gpio   | '1' or 'yes' |  maaxboard-8ulp-ext-gpio.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_i2c    | '1' or 'yes' |  maaxboard-8ulp-ext-i2c.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_spi    | '1' or 'yes' |  maaxboard-8ulp-ext-spi.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_uart   | '1' or 'yes' |  maaxboard-8ulp-ext-uart.dtbo
|-----------------------|--------------|------------------------------
| enable_overlay_cam    | '1' or 'yes' |  maaxboard-8ulp-cam.dtbo
|---------------------------------------------------------------------
| fdt_file             : is a base dtb file, should be set maaxboard-8ulp.dtb
|---------------------------------------------------------------------
| fdt_extra_overlays   : other dtbo files to be loading, such as 1.dtbo 2.dtbo 3.dtbo
|---------------------------------------------------------------------
|---------------------------------------------------------------------
| uboot env   : you could set some environment variables of u-boot here, such as 'console=' 'bootargs=' 
\---------------------------------------------------------------------
default setting:
    fdt_file=maaxboard-8ulp.dtb
    enable_overlay_disp=1
    enable_overlay_gpio=1
    #fdt_extra_overlays=1.dtbo 2.dtbo 3.dtbo
    #ethaddr=aa:bb:cc:aa:bb:cc
    console=ttyLP1,115200
