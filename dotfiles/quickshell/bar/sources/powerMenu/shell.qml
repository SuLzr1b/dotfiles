import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

ShellRoot {
    id: root

    property var hoverColor: "#0b564b"
    property var buttomColor: "#0b3c56"
    property var textColor: "#d9f0fc"

    Process {
        id: powOff
        command: ["sh", "-c", "sudo /sbin/poweroff"]
    }
    Process {
        id: reBoot
        command: ["sh", "-c", "sudo /sbin/reboot"]
    }

    LazyLoader { active: true; component: Menu {} }
}
