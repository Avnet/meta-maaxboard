import os

class BoardLEDS(object):
    def __init__(self, enableBoardHardware):
        self.enableHardware = enableBoardHardware

    def LED_init(self):
        if self.enableHardware:
            os.system("echo none > /sys/class/leds/ledred/trigger")
            os.system("echo none > /sys/class/leds/ledgreen/trigger")
            os.system("echo none > /sys/class/leds/ledblue/trigger")
            os.system("echo 0 > /sys/class/leds/ledred/brightness")
            os.system("echo 0 > /sys/class/leds/ledgreen/brightness")
            os.system("echo 0 > /sys/class/leds/ledblue/brightness")

    def LED_on(self,led):
        if self.enableHardware:
            if led == "red":
                os.system("echo 1 > /sys/class/leds/ledred/brightness")

            elif led == "green":
                os.system("echo 1 > /sys/class/leds/ledgreen/brightness")

            elif led == "blue":
                os.system("echo 1 > /sys/class/leds/ledblue/brightness")

    def LED_off(self,led):
        if self.enableHardware:
            if led == "red":
                os.system("echo 0 > /sys/class/leds/ledred/brightness")

            elif led == "green":
                os.system("echo 0 > /sys/class/leds/ledgreen/brightness")

            elif led == "blue":
                os.system("echo 0 > /sys/class/leds/ledblue/brightness")