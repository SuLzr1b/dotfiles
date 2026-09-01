import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

PanelWindow {
    anchors {
        right: true
        top: true
    }
    margins {
        right: 200
    }
    width: 270
    height: 90
    color: "transparent"
    Rectangle {
        id: menu
        anchors.fill: parent
        color: "#101a28"
        bottomLeftRadius: 10
        bottomRightRadius: 10
        RowLayout {
            anchors.fill: parent
            Rectangle {
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 5
                }
                width: 260
                height: 20
                radius: 10
                color: "#0b3c56"
                Text {
                    anchors {
                        left: parent.left
                        leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }
                    text: "\uf4bc     " + cpuUsage
                    font.family: root.fontFamily
                    font.pixelSize: 13
                    color: "#d9f0fc"
                }
            }
            Rectangle {
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 35
                }
                width: 260
                height: 20
                radius: 10
                color: "#0b3c56"
                Text {
                    anchors {
                        left: parent.left
                        leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }
                    text: "\uefc5     " + memUsage
                    font.family: root.fontFamily
                    font.pixelSize: 13
                    color: "#d9f0fc"
                }
            }
            Rectangle {
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 65
                }
                width: 260
                height: 20
                radius: 10
                color: "#0b3c56"
                Text {
                    anchors {
                        left: parent.left
                        leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }
                    text: "\udb86\udd1a     " + eip
                    font.family: root.fontFamily
                    font.pixelSize: 13
                    color: "#d9f0fc"
                }
            }
        }
    }
}
