import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

Rectangle {
    color: "#0b3c56"
    height: 15
    width: 160
    bottomLeftRadius: 3
    bottomRightRadius: 3

    Text {
        anchors {
            horizontalCenter: parent.horizontalCenter
        }
        id: clock
        text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
        color: "#d9f0fc"
        font.family: "CaskaydiaCove Nerd Font"
        font.pixelSize: 13

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
        }
    }
}
