import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.0

import org.freedesktop.gstreamer.GLVideoItem 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    color: "black"

    Item {
        anchors.fill: parent

        GstGLVideoItem {
            id: video
            objectName: "videoItem"
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
        }

        Rectangle {
            color: Qt.rgba(1, 1, 1, 0.7)
            border.width: 1
            border.color: "white"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 30
            height: parent.height - 30
            radius: 8
        }

        MouseArea {
            id: mousearea
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.opacity = 1.0
                hidetimer.start()
            }
        }

        Timer {
            id: hidetimer
            interval: 5000
            onTriggered: {
                parent.opacity = 0.0
                stop()
            }
        }
    }
}
