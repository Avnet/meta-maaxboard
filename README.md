# meta-maaxboard

A meta-layer for Embest MaaXBoard. This is eIQ(NXP eIQ Machine Learning) branch. It could build a image including the eIQ softwares:

- OpenCV 4.0.1
- Arm Compute Library 19.02
- Arm NN 19.02
- ONNX runtime 0.3.0
- TensorFlow 1.12
- TensorFlow Lite 1.12

Below will show you how to setup Yocto Development Env and how to build the eIQ image.


## How to

### Install Host Yocto Development Env

You should have a linux machine, below instructions show how to setup the env on a Ubuntu:18.04 machine.

```bash
$ sudo apt-get update && sudo apt-get install -y \
        gawk \
        wget \
        git-core \
        diffstat \
        unzip \
        texinfo \
        gcc-multilib \
        build-essential \
        chrpath \
        socat \
        libsdl1.2-dev \
        xterm \
        sed \
        cvs \
        subversion \
        coreutils \
        texi2html \
        docbook-utils \
        python-pysqlite2 \
        help2man \
        make \
        gcc \
        g++ \
        desktop-file-utils \
        libgl1-mesa-dev \
        libglu1-mesa-dev \
        mercurial \
        autoconf \
        automake \
        groff \
        curl \
        lzop \
        asciidoc \
        u-boot-tools \
        cpio \
        sudo \
        locales
```

Install repo

```bash
sudo curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
sudo chmod a+x /usr/bin/repo
```

### Fetch the source

Download meta layers from NXP

```bash
mkdir imx-yocto-bsp
$ cd imx-yocto-bsp
$ repo init -u https://source.codeaurora.org/external/imx/imx-manifest -b imx-linux-sumo -m imx-4.14.98-2.2.0.xml
$ repo sync
```

Clone this repo

```bash
$ cd sources
$ git clone https://github.com/Avnet/meta-maaxboard.git
```

Clone imx machinelearning repo
```bash
$ cd sources
$ git clone -b sumo https://source.codeaurora.org/external/imx/meta-imx-machinelearning.git
```

### Do patch

NXP do some hook / patch according different machine / distro when init a new build. We need do this first.

If you're going to build MaaXBoard

```bash
$ cd imx-yocto-bsp
$ mkdir imx8mqevk
$ DISTRO=fsl-imx-wayland MACHINE=imx8mqevk source fsl-setup-release.sh -b imx8mqevk
$ rm -rf imx8mqevk
```

Or if you're going to build MaaXBoard Mini

```bash
$ cd imx-yocto-bsp
$ mkdir imx8mmevk
$ DISTRO=fsl-imx-wayland MACHINE=imx8mmevk source fsl-setup-release.sh -b imx8mmevk
$ rm -rf imx8mmevk
```

###  Build configure

```bash
$ cd imx-yocto-bsp
# Create the build directory
$ mkdir -p maaxboard/build
# Create the default build conf in maaxboard/build
$ source sources/poky/oe-init-build-env maaxboard/build
```

### Upate local conf

You should update 2 conf file in the build directory(maaxboard/build/conf/):

- local.conf
- bblayers.conf

We provide a sample under /meta-maaxboard/conf:

- local.conf.eiq.sample
- bblayers.conf.eiq.sample

> NOTE: variable 'BSPDIR' in bblayer.conf should be defined, the value should be the repo init directory. It is imx-yocto-bsp directory in above example

If you're going to build MaaXBoard Mini, you should change the Machine(in local.conf) to:

```ini
MACHINE ??= 'maaxboard-mini-ddr4-2g-sdcard'
```

### Build

```bash
$ cd /path/to/bsp_dir/
$ source sources/poky/oe-init-build-env maaxboard/build

$ bitbake lite-image-qt5
```

### Flash sdcard

```bash
# This image will be generated under: /path/to/build/tmp/deploy/images/maaxboard-ddr4-2g-sdcard/lite-image-maaxboard-ddr4-2g-sdcard-20200515065319.rootfs.sdcard.bz2
# unzip the bz2 file
$ bunzip2 lite-image-maaxboard-*.rootfs.sdcard.bz2
## dd
$ sudo dd if=lite-image-maaxboard-ddr4-2g-sdcard-20200515065319.rootfs.sdcard of=/dev/sda bs=10M conv=fsync
$ sync
```

### Power On

The default login is user 'root' with the password 'avnet'

## Configuration

- Distor: 'fsl-imx-wayland-lite'
    - meta-maaxboard/conf/distro/fsl-imx-wayland-lite.conf
- Image: "lite-image"
    - meta-maaxboard/images/lite-image.bb
- Machine:
    - MaaXBoard: maaxboard-ddr4-2g-sdcard
    - MaaXBoard Mini: maaxboard-mini-ddr4-2g-sdcard

## Customization

- You could add more packages in the image recipe: meta-maaxboard/images/lite-image.bb
- Distro features: meta-maaxboard/conf/distro/fsl-imx-wayland-lite.conf
- Machine features: meta-maaxboard/conf/machine/maaxboard-ddr4-2g-sdcard.conf


## EIQ Example

Here shows how to run i.MX8M eIQ Machine Learning examples. More, please refer to the PDF document: 

- [NXP eIQ™ Machine Learning Software Development Environment for i.MX Applications Processors][https://www.nxp.com.cn/docs/en/nxp/user-guides/UM11226.pdf]


### OpenCV Face Detect Example

Save the below .py file to MaaXBoard filesystem and run it.

```bash
$ python face_detect.py
```


```python
import time
import cv2

def detect(img, cascade):
    rects = cascade.detectMultiScale(img, scaleFactor=1.3, minNeighbors=4, minSize=(30, 30),
                                     flags=cv2.CASCADE_SCALE_IMAGE)
    if len(rects) == 0:
        return []
    rects[:,2:] += rects[:,:2]
    return rects

def draw_rects(img, rects, color):
    for x1, y1, x2, y2 in rects:
        cv2.rectangle(img, (x1, y1), (x2, y2), color, 2)

if __name__ == '__main__':
    video_src = 1
    cascade_fn = "/usr/share/opencv4/lbpcascades//bpcascade_frontalface_improved.xml"
    cascade = cv2.CascadeClassifier(cascade_fn)

    cam = cv2.VideoCapture(video_src)

    index = 0
    time_sum = 0.0
    old_sum = 0.0
    while True:
        index += 1
        ret, img = cam.read()
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        gray = cv2.equalizeHist(gray)

        t = time.time()
        rects = detect(gray, cascade)
        dt = time.time() - t
        time_sum += dt

        vis = img.copy()
        if len( rects ) > 0:
            draw_rects( vis, rects, (0, 255, 0) )
        else:
            print("no face found")

        if index%100 == 0:
            old_sum = time_sum
            time_sum = 0.0

        if old_sum > 0.0001:
            cv2.putText( vis, '100 pics, average time: {} s'.format( round( old_sum/100.0, 4 ) ),
                             (20, 20), cv2.FONT_HERSHEY_PLAIN, 2, (0, 255, 0), 2 )
        cv2.imshow( 'facedetect', vis )

        key_ret = cv2.waitKey( 30)
        if (key_ret == 0): 
            break
    cam.release()
    cv2.destroyAllWindows()
```

[nxp]:https://www.nxp.com.cn/docs/en/nxp/user-guides/UM11226.pdf
