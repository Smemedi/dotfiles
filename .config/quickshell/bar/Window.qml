import QtQuick
import Quickshell.Hyprland
import ".."

Item {
    width: background.width
    height: Config.panelHeight

    Rectangle {
        id: background
        width: windowText.width + 20
        height: parent.height
        radius: 10
        color: "#c0313244"

        Text {
            id: windowText
            anchors.centerIn: parent
            font.pixelSize: Config.fontSize
            font.family: Config.fontFamily
						font.bold: true
						font.weight: Font.bold
            color: "#89dceb"
            text: {
								var currentWorkspace = Hyprland.focusedMonitor?.activeWorkspace;
								var toplevels = Hyprland.toplevels.values;
								
								// Only consider toplevels on the current workspace
								var active = toplevels.find(function(t) {
										return t.activated && t.workspace?.id === currentWorkspace?.id;
								});
								
								if (!active) return "| Hyprland |";

								var appId = active.wayland?.appId || "";
								if (appId) {
										var name = appId.split('.').pop();
										return "| " + name.charAt(0).toUpperCase() + name.slice(1) + " |";
								}

								var title = active.title || "";
								var parts = title.split(/\s[—\-]\s/);
								var appName = parts[parts.length - 1].trim();
								if (!appName) return "| Hyprland |";
								return "| " + appName.charAt(0).toUpperCase() + appName.slice(1) + " |";
						}
        }
    }
}
