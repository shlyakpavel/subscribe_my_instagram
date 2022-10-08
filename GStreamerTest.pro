TEMPLATE = app

QT += core qml quick widgets

linux: !android {
    QT_CONFIG -= no-pkg-config
    CONFIG += link_pkgconfig debug
    PKGCONFIG = \
        gstreamer-1.0 \
        gstreamer-video-1.0
    CONFIG += link_pkgconfig
}

DEFINES += GST_USE_UNSTABLE_API

SOURCES += main.cpp

RESOURCES += qml.qrc


android {
    GSTREAMER_ROOT=/home/pavel/Android/gstreamer-qt-android/gstreamer-1.0-android-universal-1.21.1.1.tar/armv7/

    INCLUDEPATH += $$GSTREAMER_ROOT/include/gstreamer-1.0 $$GSTREAMER_ROOT/include/glib-2.0 $$GSTREAMER_ROOT/lib/glib-2.0/include

    #gstreamer plugins
    LIBS += $${GSTREAMER_ROOT}/lib/gstreamer-1.0/libgstvideotestsrc.a
    LIBS += $${GSTREAMER_ROOT}/lib/gstreamer-1.0/libgstqmlgl.a
    LIBS += $${GSTREAMER_ROOT}/lib/gstreamer-1.0/libgstopengl.a

#plugin libs
LIBS += $${GSTREAMER_ROOT}/lib/liborc-0.4.a
LIBS += $${GSTREAMER_ROOT}/lib/libgstgl-1.0.a
LIBS += $${GSTREAMER_ROOT}/lib/libgraphene-1.0.a
LIBS += $${GSTREAMER_ROOT}/lib/libpng16.a
LIBS += $${GSTREAMER_ROOT}/lib/libjpeg.a
LIBS += $${GSTREAMER_ROOT}/lib/libx264.a
LIBS += $${GSTREAMER_ROOT}/lib/libgstvideo-1.0.a
LIBS += $${GSTREAMER_ROOT}/lib/libgstaudio-1.0.a
LIBS += $${GSTREAMER_ROOT}/lib/libgstpbutils-1.0.a
LIBS += $${GSTREAMER_ROOT}/lib/libgsttag-1.0.a
LIBS += $${GSTREAMER_ROOT}/lib/libgstphotography-1.0.a
LIBS += $${GSTREAMER_ROOT}/lib/libgstcontroller-1.0.a
LIBS += $${GSTREAMER_ROOT}/lib/libgstcodecparsers-1.0.a
LIBS += -lEGL -lGLESv2

    #gstreamer libs
    LIBS += $${GSTREAMER_ROOT}/lib/libgstbase-1.0.a
    LIBS += $${GSTREAMER_ROOT}/lib/libgstreamer-1.0.a
    LIBS += $${GSTREAMER_ROOT}/lib/libgmodule-2.0.a
    LIBS += $${GSTREAMER_ROOT}/lib/libgobject-2.0.a
    LIBS += $${GSTREAMER_ROOT}/lib/libglib-2.0.a
    LIBS += $${GSTREAMER_ROOT}/lib/libffi.a
    LIBS += $${GSTREAMER_ROOT}/lib/libiconv.a
    LIBS += $${GSTREAMER_ROOT}/lib/libintl.a
    LIBS += $${GSTREAMER_ROOT}/lib/libz.a
}

