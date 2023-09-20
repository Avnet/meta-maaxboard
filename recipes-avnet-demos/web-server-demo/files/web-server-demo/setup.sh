#!/bin/sh
echo installing modules
pip3 install pyserial psutil==5.8.0 PyCrypto microdot tendo opencv-python==4.7.0.72 opencv-python-headless==4.7.0.72

echo enabling launch.sh
chmod +x launch.sh

echo enabling exit.sh
chmod +x exit.sh

echo Copy weston.ini 
cp ./weston.ini /etc/xdg/weston

echo Copy autorun.sh
cp ./autolaunch/autorun.sh /opt

echo enabling autorun.sh
chmod +x /opt/autorun.sh

echo Copy root_env
cp ./autolaunch/root_env /opt

echo Copy autorun.service
cp ./autolaunch/autorun.service /etc/systemd/system

echo Copy rc.local
cp ./autolaunch/rc.local /etc

echo Copy uEnv.txt
cp ./autolaunch/uEnv.txt /run/media/mmcblk0p1

echo enabeling camera
usermod -a -G video $LOGNAME

echo Setting time zone to Europe/Berlin
timedatectl set-timezone Europe/Berlin
date -d "$(wget --method=HEAD -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f4-10)"

echo #########################
echo Reboot to apply changes !
echo #########################