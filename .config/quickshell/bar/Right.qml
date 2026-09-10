import QtQuick
import QtQuick.Layouts
import ".."
import "right_stuff" as RightStuff

Item {
    width: background.width
    height: Config.panelHeight
    
    Rectangle {
        id: background
        width: row.implicitWidth + 20  // Use the RowLayout's implicit width
        height: parent.height
        radius: 10
        color: "#c0313244"
        
        RowLayout {
            id: row
            anchors.centerIn: parent  // Center it instead of fill
            spacing: 10
            
						RightStuff.Clock {}
            RightStuff.Wifi {}
            RightStuff.Battery {}
        }
    }

		MouseArea {
                id: ccTriggerMa
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    if (root.controlCenter) {
                        root.controlCenter.toggle()
                    }
                }
            }
}
