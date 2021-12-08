
do_install_append() { 
    sed -i "s|^#NTP=.*|NTP=pool.ntp.org|g" ${D}/etc/systemd/timesyncd.conf
}

