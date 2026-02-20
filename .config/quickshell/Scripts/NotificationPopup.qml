import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Notifications

PanelWindow {
    id: popup
    
    property string summary: ""
    property string body: ""
    property string appIcon: ""
    property var notification: null
    property int lifetime: 5000  // 5 seconds
    
    visible: true
    
    anchors {
        top: true
        right: true
    }
    
    margins {
        top: 40
        right: 12
    }
    
    implicitWidth: 350
    implicitHeight: Math.max(80, content.implicitHeight + 24)
    color: "transparent"
    
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell-notification-popup"
    
    // Auto-close timer
    Timer {
        interval: popup.lifetime
        running: true
        onTriggered: popup.destroy()
    }
    
    // Process to find and focus window
       Process {
        id: findWindowProc
        property string appClass: ""
        command: ["sh", "-c", "hyprctl clients -j | jq -r '.[] | select(.class == \"" + appClass + "\") | .address' | head -1"]
        property string windowAddress: ""
        
        stdout: SplitParser {
            onRead: function(line) {
                findWindowProc.windowAddress = line.trim()
            }
        }
        
        onExited: {
            if (windowAddress) {
                focusProc.windowAddr = windowAddress
                focusProc.running = true
            } else {
                launchProc.running = true
            }
        }
    }
    
    Process {
        id: focusProc
        property string windowAddr: ""
        command: ["hyprctl", "dispatch", "focuswindow", "address:" + windowAddr]
    }
    
    Process {
        id: launchProc
        property string desktopEntry: ""
        command: ["gtk-launch", desktopEntry]
    } 

		Timer {
    id: destroyTimer
    interval: 500
    onTriggered: popup.destroy()
		}

    function handleClick() {
    if (!notification) {
        popup.destroy()
        return
    }
    
    var desktopEntry = notification.desktopEntry || notification.appName || ""
    
    if (desktopEntry) {
        launchProc.desktopEntry = desktopEntry
        findWindowProc.appClass = desktopEntry
        findWindowProc.running = true
    }
    
    popup.destroy()
}
    
    Rectangle {
        id: background
        anchors.fill: parent
        radius: 12
        color: "#313244"
        border.color: "#45475a"
        border.width: 1
        
        // Slide in animation
        NumberAnimation on x {
            from: 400
            to: 0
            duration: 200
            easing.type: Easing.OutCubic
        }
        
        Row {
            id: content
            anchors.fill: parent
            anchors.margins: 12
            spacing: 12
            
            // App Icon
            Rectangle {
                width: 40
                height: 40
                color: "#45475a"
                radius: 8
                anchors.verticalCenter: parent.verticalCenter
                
                Image {
                    id: iconImage
                    anchors.fill: parent
                    anchors.margins: modelData.image ? 0 : 6
                    fillMode: Image.PreserveAspectCrop
                    source: {
											if (notification && notification.image) {
													var img = notification.image;
													if (img.startsWith("/") || img.startsWith("file://"))
															return img.startsWith("file://") ? img : "file://" + img;
													return img;
											}
											
											var icon = popup.appIcon || (notification ? notification.appIcon : "") || "";
											if (icon) {
													if (icon.startsWith("/") || icon.startsWith("file://"))
															return icon.startsWith("file://") ? icon : "file://" + icon;
													return "image://icon/" + icon;
											}
											return "";
										}
                    visible: status === Image.Ready
                }
                
                Text {
                    anchors.centerIn: parent
                    text: "󰂚"
                    font.family: "Symbols Nerd Font"
                    font.pixelSize: 20
                    color: "#6c7086"
                    visible: iconImage.status !== Image.Ready
                }
            }
            
            Column {
                spacing: 6
                width: parent.width - 64  // Account for icon and spacing
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: popup.summary
                    font.bold: true
                    font.pixelSize: 14
                    color: "#cdd6f4"
                    width: parent.width
                    elide: Text.ElideRight
                }
                
                Text {
                    text: popup.body
                    font.pixelSize: 12
                    color: "#a6adc8"
                    width: parent.width
                    wrapMode: Text.WordWrap
                    visible: text !== ""
                }
            }
        }
        
        // Close button
        Rectangle {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 8
            width: 20
            height: 20
            radius: 10
						color: closeMouse.containsMouse ? "#f38ba8" : "transparent"
						z: 10
            
            Text {
                anchors.centerIn: parent
                text: "✕"
                color: "#cdd6f4"
                font.pixelSize: 12
            }
            
            MouseArea {
							id: closeMouse
							anchors.fill: parent
							hoverEnabled: true
							onClicked: function(mouse) {  // Add function(mouse) here
									mouse.accepted = true
									if (popup.notification) {
											popup.notification.tracked = false
									}
									popup.destroy()
							}
					}
        }
        
        MouseArea {
            anchors.fill: parent
            onClicked: popup.handleClick()
        }
    }
}
