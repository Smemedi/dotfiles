import QtQuick
import Quickshell.Hyprland

Item {
    id: workspaceModule
		property int spacing: 6
		height: 30

    // Pill-shaped background
    Rectangle {
        id: background
        anchors.fill: parent
        radius: 10
				color: "#c0313244"
				anchors.margins: 2   // optional inner padding
				opacity: 1

        Row {
            id: row
            anchors.fill: parent
            anchors.margins: 6
            spacing: 8

            Repeater {
                model: Hyprland.workspaces

                Text {
                    property bool isActive: modelData.id === Hyprland.focusedWorkspace?.id
                    text: isActive ? "" : ""
                    color: "#cba6f7"

                    font {
                        family: "Symbols Nerd Font"
                        pixelSize: 16
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
    implicitHeight: 30
}

