import QtQuick
import Quickshell.Hyprland
import ".."

Item {
    id: workspaceModule
		property int spacing: 6
		height: Config.panelHeight

    Rectangle {
        id: background
        anchors.fill: parent
        radius: 10
		color: "#c0313244"
		anchors.margins: 2   // optional inner padding
		opacity: 1

        Row {
            id: row
            anchors.centerIn: parent
            spacing: 8

            Repeater {
                model: Hyprland.workspaces

                Text {
                    property bool isActive: modelData.id === Hyprland.focusedWorkspace?.id
                    text: isActive ? "" : ""
                    color: "#cba6f7"

                    font {
                        family: "Symbols Nerd Font"
                        pixelSize: 18
                        bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: modelData.activate()
                    }
                }
            }
        }
    }

    // Set the module's implicit size so MainBar can layout properly
    implicitWidth: row.childrenRect.width + 16
    implicitHeight: Config.panelHeight
}

