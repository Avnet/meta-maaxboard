#!/bin/sh
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

if grep -q "autorun.service" /etc/rc.local; then
    echo  /etc/rc.local already updated
else
    line_number=$(grep -n "exit 0" /etc/rc.local | tail -n 1 | cut -d ':' -f 1)
    sed -i "${line_number}s/exit 0/\# enable auto launching of the web-server-demo\nsystemctl enable autorun.service\n\nexit 0/" /etc/rc.local
    echo  Updated /etc/rc.local
fi

echo Copy uEnv.txt
cp ./autolaunch/uEnv.txt /run/media/mmcblk0p1

echo enabeling camera
usermod -a -G video $LOGNAME

#echo Setting time zone to Europe/Berlin
#timedatectl set-timezone Europe/Berlin
#date -d "$(wget --method=HEAD -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f4-10)"

echo #########################
echo Reboot to apply changes !
echo #########################