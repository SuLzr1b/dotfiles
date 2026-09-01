import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Niri 0.1
import "./sources/modules"

ShellRoot {
    id: root
    property color colBg: "#1a1b26"
    property color colFg: "#a9b1d6"
    property color colMuted: "#444b6a"
    property color colCyan: "#0db9d7"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#e0af68"
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 13

    Process {
        id: sysMon
        command: ["sh", "-c", "qs -c ~/.config/quickshell/bar/sources/systemMonitor"]
    }
    Process {
        id: powerMenu
        command: ["sh", "-c", "qs -c ~/.config/quickshell/bar/sources/powerMenu"]
    }

    Niri {
        id: niri
        Component.onCompleted: connect()

        onConnected: console.info("Connected to niri")
        onErrorOccurred: function(error) {
            console.error("Niri error:", error)
        }
    }

    LazyLoader { active: true; component: Bar {} }
}
