import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

ShellRoot {
    id: root
    property string fontFamily: "JetBrainsMono Nerd Font"

    property var cpuUsage: 0
    property var memUsage: 0
    property var eip: 0

    Process {
        id: cpuProc
        command: ["sh", "-c", "cat ~/.rq-scripts/system-status/cpu"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                cpuUsage = data
            }
        }

        Component.onCompleted: running = true
    }
    Process {
        id: memProc
        command: ["sh", "-c", "cat ~/.rq-scripts/system-status/mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                memUsage = data
            }
        }
        Component.onCompleted: running = true
    }
    Process {
        id: ipProc
        command: ["sh", "-c", "cat ~/.rq-scripts/eip/ip"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                eip = data
            }
        }

        Component.onCompleted: running = true
    }
    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            memProc.running = true
            ipProc.running = true
        }
    }
    LazyLoader { active: true; component: Win {} }
}
