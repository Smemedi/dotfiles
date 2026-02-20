import QtQuick
import Quickshell.Hyprland
Item {
    width: background.width
    height: 30
    
    Rectangle {
        id: background
        width: windowText.width + 20
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
                var currentWorkspace = Hyprland.focusedMonitor?.activeWorkspace;
                
                var allToplevels = Hyprland.toplevels.values;
                var workspaceToplevels = allToplevels.filter(function(t) {
                    return t.workspace && t.workspace.id === currentWorkspace?.id;
                });
                
                if (workspaceToplevels.length === 0) {
                    return "| Hyprland |";
                }
                
                var toplevel = workspaceToplevels[0];
                if (toplevel?.wayland?.appId) {
                    var appId = toplevel.wayland.appId;
                    var appName = appId.split('.').pop();
                    return "| " + appName.charAt(0).toUpperCase() + appName.slice(1) + " |";
                }
                
                return "| Hyprland |";
            }
        }
    }
}
