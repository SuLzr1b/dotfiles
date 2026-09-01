import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Niri 0.1

PanelWindow {
    id: bar
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 15
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: "#101a28"
        bottomLeftRadius: 0
        bottomRightRadius: 0
        //left
        RowLayout {
            anchors {
                left: parent.left
                leftMargin: 5
            }
            spacing: 3
            Loader { active: true; sourceComponent: Workspaces {} }
            Text {
                text: niri.focusedWindow?.appId ?? ""
                font.family: "CaskaydiaCove Nerd Font"
                font.pixelSize: 14
                color: "#d9f0fc"
            }
            Rectangle { width: 2; height: 16; color: "#ffffff"; radius: 3 }
            Text {
                text: niri.focusedWindow?.id ?? ""
                font.family: "CaskaydiaCove Nerd Font"
                font.pixelSize: 14
                color: "#d9f0fc"
            }
        }
        //center
        RowLayout {
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
        }

        RowLayout {
            anchors {
                right: parent.right
                rightMargin: 5
            }
            Loader { active: true; sourceComponent: SystemMonitor {} }
            Loader { active: true; sourceComponent: Clock {} }
            Loader { active: true; sourceComponent: PowerMenu {} }
        }
    }
}
