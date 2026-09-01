import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

PanelWindow {
    anchors {
        top: true
        right: true
    }
    margins {
        top: 2
        right: 5
    }
    implicitWidth: 140
    implicitHeight: 55
    color: "transparent"
    Rectangle {
        id: menu
        anchors.fill: parent
        color: "#101a28"
        bottomLeftRadius: 10
        bottomRightRadius: 10

        RowLayout {
            anchors {
                top: parent.top
                topMargin: 5
                horizontalCenter: parent.horizontalCenter
            }
            Loader { active: true; sourceComponent: Poweroff {} }
        }
        RowLayout {
            anchors {
                top: parent.top
                topMargin: 30
                horizontalCenter: parent.horizontalCenter
            }
            Loader { active: true; sourceComponent: Reboot {} }
        }
    }
}
