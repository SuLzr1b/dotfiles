import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

Rectangle {
    height: 15
    width: 25
    bottomLeftRadius: 3
    bottomRightRadius: 3
    color: "#0b3c56"
    Text {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        text: "\udb82\udce8"
        color: "#ffffff"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 15
    }
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: (mouse) => {
            if (!powerMenu.running)
                powerMenu.running = true
            else
                powerMenu.running = false
        }
        hoverEnabled: true
        onEntered: {
            parent.color = "#0b564b"
        }
        onExited: {
            parent.color = "#0b3c56"
        }
    }
}
