# MaaXBoard Nano - Yocto Lite Image Usage

This is a simple usage of the Yocto Lite Image for MaaXBoard Nano.

## Network

### DHCP

Yocto Lite Image use dhcpcd as the DHCP clint. It will automatically retrieve IP from the DHCP server. if you want to config a static IP address, follow the below guides:

```bash
nano /etc/dhcpcd.conf
```
Add content like below example:

```
interface eth0
static ip_address=192.168.2.100/24
static routers=192.168.2.1
static domain_name_servers=192.168.2.252 8.8.8.8
```

### SSH

SSHD service will automatically enabled and started after system reboot.

```bash
systemctl start sshd.socket
systemctl stop sshd.socket
systemctl restart sshd.socket

```

SSHD config

```bash
nano /etc/ssh/sshd_config
```
After modify the ssh_config, you should restart the sshd.socket service.

If you want to login ssh with root, add the below contents to sshd_config:

```
PermitRootLogin yes
```

After edit the sshd_config file, you should restart the sshd service with:

```bash
sudo systemctl restart sshd.socket
```

### Wi-Fi

#### Connecting Wi-Fi with CLI

```bash
# scan
sudo iwlist mlan0 scan
```

Adding the network details

```bash
nano /etc/wpa_supplicant.conf
```

Network info in wpa_supplicant.conf

```
network={
    ssid="testing"
    psk="testingPassword"
}
```

Connect

```bash
wpa_supplicant -B -i mlan0 -c /etc/wpa_supplicant.conf
# use ifconfig to verify
ifconfig mlan0
```

#### Auto Connect Wi-Fi after reboot (System Service)

Prepare config file

```bash
mkdir -p /etc/wpa_supplicant
cp /etc/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant-mlan0.conf
```
> Note: Add network info to /etc/wpa_supplicant/wpa_supplicant-mlan0.conf

```bash
systemctl start wpa_supplicant@mlan0
systemctl enable wpa_supplicant@mlan0

# log info
#journalctl -u wpa_supplicant@mlan0
```

#### AP

> Currently, The image doesn't support AP.

### Bluetooth

#### Bluetooth Audio

Run pulseaudio daemon first

```bash
$ pulseaudio -D -v
```
Pair and connect the audio device

```bash
$ bluetoothctl
[bluetooth]# power on
[bluetooth]# pairable on
[bluetooth]# scan on
[bluetooth]# scan off
[bluetooth]# pair <mac address>
[bluetooth]# trust <mac address>
[bluetooth]# quit
```

List the audio devcie

```bash
$ pactl list
```

Play an audio file with aplay

```bash
$ aplay -D pulse test.wav
```

#### OBEX

Pair the Phone/PC device

```bash
$ bluetoothctl
[bluetooth]# power on
[bluetooth]# pairable on
[bluetooth]# scan on
Now, Copy the MAC Address of your PC
[bluetooth]# scan off
[bluetooth]# pair <mac address>
[bluetooth]# trust <mac address>
[bluetooth]# quit
```

Run the OBEXD dameon and connect to the target bluetooth device

```bash
export $(dbus-launch)
/usr/libexec/bluetooth/obexd -r /home/root -a -d & obexctl
[obex]# connect <mac address of PC>
[obex]#
```

**Transfer file to PC/phone**

```bash
[obex]# send /home/root/hello.mp3
```

**Transfer file from PC/phone to MaaXBoard**

Just use the PC/Phone tools to send.

> Note: Current have issues in Transfering file from PC/phone to MaaXBoard


## MutiMedias

### Audio Play

```
gst-play-1.0 ./hello.mp3
```

### Record Video

```bash
# /dev/video1 is a usb camera
gst-launch-1.0 -e v4l2src device=/dev/video1 num-buffers=100 ! video/x-raw,format=YUY2,framerate=30/1, width=640, height=480 ! videoconvert ! x264enc ! video/x-h264, profile=baseline ! mp4mux ! filesink location=output.mp4
```


