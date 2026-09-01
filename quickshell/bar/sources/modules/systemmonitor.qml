import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Rectangle {
    anchors {
        left: parent.left
    }
    color: "#0b3c56"
    height: 15
    width: 40
    bottomLeftRadius: 3
    bottomRightRadius: 3
    Text {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        text: "\ud83d\uddf4"
        font.family: root.fontFamily
        font.pixelSize: 13
        color: "#d9f0fc"
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            parent.color = "#0b564b"
            sysMon.running = true
        }
        onExited: {
            parent.color = "#0b3c56"
            sysMon.running = false
        }
    }
}
