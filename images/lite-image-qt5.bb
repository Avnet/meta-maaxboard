DESCRIPTION = "Lite Image - Adds Qt5"
LICENSE = "MIT"

require images/lite-image.bb

inherit distro_features_check ${@bb.utils.contains('BBFILE_COLLECTIONS', 'qt5-layer', 'populate_sdk_qt5', '', d)}

CONFLICT_DISTRO_FEATURES = "directfb"

# Install Freescale QT demo applications
QT5_IMAGE_INSTALL_APPS = ""

# Install fonts
QT5_FONTS = "ttf-dejavu-common ttf-dejavu-sans ttf-dejavu-sans-mono ttf-dejavu-serif "

MACHINE_QT5_MULTIMEDIA_APPS = ""
QT5_IMAGE_INSTALL = ""
QT5_IMAGE_INSTALL_common = " \
    packagegroup-qt5-demos \
    ${QT5_FONTS} \
    ${QT5_IMAGE_INSTALL_APPS} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'libxkbcommon', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'qtwayland qtwayland-plugins', '', d)}\
    "

QT5_IMAGE_INSTALL_imxgpu3d = " \
    ${QT5_IMAGE_INSTALL_common} \
    gstreamer1.0-plugins-good-qt"

# QT5_IMAGE_INSTALL_remove = " packagegroup-qt5-webengine"

IMAGE_INSTALL += " \
${QT5_IMAGE_INSTALL} \
"
