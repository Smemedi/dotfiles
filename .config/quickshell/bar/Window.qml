import QtQuick
import Quickshell.Hyprland

Item {
    width: background.width
    height: 30
    
    readonly property var activetoplevel: Hyprland.activeToplevel
    readonly property list<HyprlandWorkspace> workspaces: Hyprland.workspaces.values
    
    function activateWorkspaceById(id) {
        const index = workspaces.findIndex(w => w.id === id)
        workspaces[index].activate()
    }
    
    Rectangle {
        id: background
        width: windowText.width + 20  // text width + padding
        height: parent.height
        radius: 10
        color: "#c0313244"
        
        Text {
            id: windowText
            anchors.centerIn: parent
						font.pixelSize: 14
						font.family: "MesloLGS Nerd Font Mono Bold"
						font.bold: true
            color: "#89dceb"
						text: {
                if (activetoplevel?.wayland) {
                    var appId = activetoplevel.wayland.appId;
                    var appName = appId.split('.').pop();
										return "| " + appName.charAt(0).toUpperCase() + appName.slice(1) + " |";
                }
                return "| Hyprland |";
            }
        }
    }
}
