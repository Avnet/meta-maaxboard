import os

class BoardBrightness(object):
    global brightnessValue

    def __init__(self, enableBoardHardware):
        global brightnessValue
        brightnessValue = 9
        self.enableHardware = enableBoardHardware

    def Brightness_init(self):
        global brightnessValue
        if self.enableHardware:
            os.system("echo "+str(brightnessValue)+" > /sys/devices/platform/backlight/backlight/backlight/brightness")

    def Brightness_set(self,value):
        global brightnessValue
        if self.enableHardware:
            if value < 10 and value > 0:
                brightnessValue = value
                os.system("echo "+str(brightnessValue)+" > /sys/devices/platform/pwm-backlight/backlight/pwm-backlight/brightness")

    def Brightness_get(self):
        global brightnessValue
        return brightnessValue