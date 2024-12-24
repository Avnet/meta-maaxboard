do_install:append() {
	ln -s /dev/null ${D}${sysconfdir}/systemd/system/systemd-journald-audit.service
} 
