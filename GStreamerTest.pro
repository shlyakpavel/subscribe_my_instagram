TEMPLATE = app

QT += qml quick widgets

linux: !android {
    QT_CONFIG -= no-pkg-config
    CONFIG += link_pkgconfig debug
    PKGCONFIG = \
        gstreamer-1.0 \
        gstreamer-video-1.0
}

DEFINES += GST_USE_UNSTABLE_API

SOURCES += main.cpp

RESOURCES += qml.qrc

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/build_gstreamer.sh \
    android/gradle.properties \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/jni/Android.mk \
    android/jni/Application.mk \
    android/res/values/libs.xml


ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

android {
    GSTREAMER_ROOT_ANDROID = $$_PRO_FILE_PWD_/gstreamer-1.0/armv7

    gst.target = $$ANDROID_PACKAGE_SOURCE_DIR/libs/armeabi-v7a/libgstreamer_android.so
    gst.commands = cd $$ANDROID_PACKAGE_SOURCE_DIR; \
        ./build_gstreamer.sh TARGET_ARCH_ABI=armeabi-v7a \
            GSTREAMER_ROOT_ANDROID=$$GSTREAMER_ROOT_ANDROID \
            NDK_PROJECT_PATH=$$ANDROID_PACKAGE_SOURCE_DIR

    extraclean.commands = rm -rv $$ANDROID_PACKAGE_SOURCE_DIR/libs $$ANDROID_PACKAGE_SOURCE_DIR/obj
    clean.depends += extraclean

    QMAKE_EXTRA_TARGETS += gst clean extraclean
    PRE_TARGETDEPS += $$ANDROID_PACKAGE_SOURCE_DIR/libs/armeabi-v7a/libgstreamer_android.so

    INCLUDEPATH += $$GSTREAMER_ROOT_ANDROID/include/gstreamer-1.0 $$GSTREAMER_ROOT_ANDROID/include/glib-2.0 $$GSTREAMER_ROOT_ANDROID/lib/glib-2.0/include
    LIBS += -L$$ANDROID_PACKAGE_SOURCE_DIR/libs/armeabi-v7a -lgstreamer_android

    ANDROID_EXTRA_LIBS = $$ANDROID_PACKAGE_SOURCE_DIR/libs/armeabi-v7a/libgstreamer_android.so
}

