#!/bin/sh
date -d "$(wget --method=HEAD -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f4-10)"
python3 /home/root/web-server-demo/webui.py