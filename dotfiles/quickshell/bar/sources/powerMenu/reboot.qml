import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Rectangle {
    width: 130
    height: 20
    radius: 5
    color: root.buttomColor
    Text {
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: 10
        }
        text: "\udb81\udc53  reboot"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 13
        color: root.textColor
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            reBoot.running = true
        }
        onEntered: {
            parent.color = root.hoverColor
        }
        onExited: {
            parent.color = root.buttomColor
        }
    }
}
