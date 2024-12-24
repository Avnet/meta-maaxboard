#!/bin/sh

sleep 5
. /etc/profile.d/weston.sh
exec /home/root/web-server-demo/launch.sh

exit 0
