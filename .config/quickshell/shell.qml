import Quickshell
import QtQuick
import QtQuick.Layouts
import "bar" as BarModules
import "ControlCenter"
import "Scripts"

ShellRoot {
    id: root
    property alias controlCenter: ccLoader.item
    
    PanelWindow {
    anchors.top: true
    anchors.left: true
		anchors.right: true
		implicitHeight: 35
		margins {
			top: 3
		}
    color: "transparent"
		exclusiveZone: implicitHeight

    
    Item {
        anchors.fill: parent
        
        // Left side
        BarModules.Workspaces {
            anchors.left: parent.left
						anchors.leftMargin: 8
						anchors.verticalCenter: parent.verticalCenter
        }
        
        // Center
        BarModules.Window {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        
        // Right side
        BarModules.Right {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
						anchors.rightMargin: 8
        }
    }
}
    
    LazyLoader {
        id: ccLoader
        active: true
        component: ControlCenter {
            id: controlCenterInstance
        }
    }
}
