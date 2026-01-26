import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.UPower
import "../.."

Item {
    id: root
    implicitWidth: row.implicitWidth
    implicitHeight: 30
    
    readonly property UPowerDevice device: UPower.displayDevice
    readonly property bool batteryAvailable: device && device.ready && device.isLaptopBattery
    readonly property real batteryLevel: batteryAvailable ? device.percentage : 0
    readonly property bool isCharging: batteryAvailable && device.state === UPowerDeviceState.Charging
    
    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 4
        
        // Battery icon
        Text {
            text: {
                let pct = Math.round(batteryLevel * 100)
                if (isCharging) return "󰂄"
                if (pct >= 80) return "󰁹"
                if (pct >= 60) return "󰂁"
                if (pct >= 40) return "󰁿"
                if (pct >= 20) return "󰁼"
                return "󰁺"
            }
            font.pixelSize: 16
						color: {
                let pct = Math.round(batteryLevel * 100)
                if (isCharging) return "#a6e3a1"
                if (pct >= 50) return "#a6e3a1"
                if (pct >= 30) return "#f9e2af"
                if (pct >= 20) return "#f38ba8"
                return "#ff0000"
            }

        }
        
        // Percentage text
        Text {
            text: Math.round(batteryLevel * 100) + "%"
						font.pixelSize: 14
						font.family: Config.fontFamily
            color: {
                let pct = Math.round(batteryLevel * 100)
                if (isCharging) return "#a6e3a1"
                if (pct >= 50) return "#a6e3a1"
                if (pct >= 30) return "#f9e2af"
                if (pct >= 20) return "#f38ba8"
                return "#FF0000"
            }
        }
    }
}
