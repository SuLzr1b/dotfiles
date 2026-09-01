import QtQuick
import QtQuick.Layouts
import Quickshell
import Niri 0.1

Rectangle {
    anchors.left: parent.left
    color: "#0b3c56"
    height: 15
    width: 215
    bottomLeftRadius: 3
    bottomRightRadius: 3

    Rectangle {
        id: workspaceLayout
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            leftMargin: 10
            rightMargin: 10
        }

        RowLayout {
            anchors {
                verticalCenter: parent.verticalCenter
            }
            spacing: 5

            Repeater {
                model: niri.workspaces

                Rectangle {
                    visible: index < 11
                    width: 15
                    height: 5
                    radius: 10
                    color: model.isActive ? "#4a809e" : "#0b1b23"
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: niri.focusWorkspaceById(model.id)
                    }
                }
            }
        }
    }
}
