# How to configure the environment variables in uEnv.txt

It is possible to set an environment variable in uEnv.txt, to load the devicetree
overlay files from "overlays/" folder. And This will enable some hardware features
in u-boot. Also you can set some environment variables from uboot to overwrite the
old settings.

Refer to the following description for different boards.

#-----------------------------------------------------------------------------------------

## MaaXBoard 8ULP Configure Options
+-------------------+------------------+-------------------------------+
| options           | value can be set | dtbo to be loading            |
+-------------------+------------------+-------------------------------+
| dtoverlay_camera  | ov5640           | camera-ov5640.dtbo            |
+-------------------+------------------+-------------------------------+
| dtoverlay_display | mipi             | display-mipi.dtbo             |
+-------------------+------------------+-------------------------------+
| dtoverlay_gpio    | '1' or 'yes'     | ext-gpio.dtbo                 |
+-------------------+------------------+-------------------------------+
| dtoverlay_i2c     | '4'              | ext-i2c4.dtbo                 |
+-------------------+------------------+-------------------------------+
| dtoverlay_spi     | '5'              | ext-spi5.dtbo                 |
+-------------------+------------------+-------------------------------+
| dtoverlay_uart    | '4'              | ext-uart4.dtbo                |
+-------------------+------------------+-------------------------------+
| dtoverlay_extra   | Other dtbo files to be loading, such as xxx.dtbo |
+-------------------+--------------------------------------------------+
| fdt_file          | Board base dtb file, should be maaxboard-8ulp.dtb|
+-------------------+--------------------------------------------------+
| console           | Some u-boot environment variables                |
+-------------------+--------------------------------------------------+
