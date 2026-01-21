import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import Quickshell.Widgets
import QtQuick.Layouts
import Quickshell.Services.SystemTray

PanelWindow {
    id: root

    // Theme
    property color colBg: "#1a1b26"
    property color colFg: "#a9b1d6"
    property color colMuted: "#444b6a"
    property color colCyan: "#0db9d7"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#e0af68"
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 14

    // System data
    property int cpuUsage: 0
    property int memUsage: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var p = data.trim().split(/\s+/);
                var idle = parseInt(p[4]) + parseInt(p[5]);
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0);
                if (lastCpuTotal > 0) {
                    cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)));
                }
                lastCpuTotal = total;
                lastCpuIdle = idle;
            }
        }
        Component.onCompleted: running = true
    }

    // Memory process
    Process {
        id: memProc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var parts = data.trim().split(/\s+/);
                var total = parseInt(parts[1]) || 1;
                var used = parseInt(parts[2]) || 0;
                memUsage = Math.round(100 * used / total);
            }
        }
        Component.onCompleted: running = true
    }

    // Update your timer to run both processes
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true;
            memProc.running = true;
        }
    }
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 30
    color: root.colBg

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        // Workspaces
        // Repeater {
        //     model: 4
        //     Text {
        //         property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
        //         property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
        //         text: index + 1
        //         color: isActive ? root.colCyan : (ws ? root.colBlue : root.colMuted)
        //         font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
        //         MouseArea {
        //             anchors.fill: parent
        //             onClicked: Hyprland.dispatch("workspace " + (index + 1))
        //         }
        //     }
        // }
        // Repeater {
        //            model: SystemTray.items
        //
        //            Item {
        //                width: 32
        //                height: 32
        //
        //                // Background rectangle for hover effect
        //                Rectangle {
        //                    anchors.fill: parent
        //                    color: {
        //                        if (modelData.onlyMenu) return "transparent"
        //                        if (mouseArea.pressed) return Qt.rgba(0.3, 0.3, 0.3, 0.8)
        //                        if (mouseArea.containsMouse) return Qt.rgba(0.2, 0.2, 0.2, 0.6)
        //                        return "transparent"
        //                    }
        //                    radius: 4
        //
        //                    // Only show hover effect for non-menu-only items
        //                    visible: !modelData.onlyMenu
        //                }
        //
        //                IconImage {
        //                    anchors.centerIn: parent
        //                    source: modelData.icon
        //                    implicitSize: 24
        //                }
        //                    MouseArea {
        //                    id: mouseArea
        //                    anchors.fill: parent
        //                    hoverEnabled: !modelData.onlyMenu
        //
        //                    onClicked: function(mouse) {
        //                        if (mouse.button === Qt.LeftButton) {
        //                            if (!modelData.onlyMenu) {
        //                                modelData.activate()
        //                            } else if (modelData.hasMenu) {
        //                                modelData.display(parent, width/2, height)
        //                            }
        //                        } else if (mouse.button === Qt.RightButton && modelData.hasMenu) {
        //                            modelData.display(parent, mouse.x, mouse.y)
        //                        }
        //                    }
        //
        //                    onPressed: function(mouse) {
        //                        if (mouse.button === Qt.MiddleButton && !modelData.onlyMenu) {
        //                            modelData.secondaryActivate()
        //                        }
        //                    }
        //                }
        //
        //            }
        //        }

        Item {
            Layout.fillWidth: true
        }

        // CPU
        Text {
            text: "CPU: " + cpuUsage + "%"
            color: root.colYellow
            font {
                family: root.fontFamily
                pixelSize: root.fontSize
                bold: true
            }
        }

        Rectangle {
            width: 1
            height: 16
            color: root.colMuted
        }

        // Memory
        Text {
            text: "Mem: " + memUsage + "%"
            color: root.colCyan
            font {
                family: root.fontFamily
                pixelSize: root.fontSize
                bold: true
            }
        }

        Rectangle {
            width: 1
            height: 16
            color: root.colMuted
        }

        // Clock
        Text {
            id: clock
            color: root.colBlue
            font {
                family: root.fontFamily
                pixelSize: root.fontSize
                bold: true
            }
            text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
            }
        }
    }
}
