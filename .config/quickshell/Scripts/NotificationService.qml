pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Io

Item {
    id: root
    
    property var popupComponent: Qt.createComponent("NotificationPopup.qml")
    
    NotificationServer {
        id: server
        
        onNotification: (notification) => {
            notification.tracked = true
            
            // Create popup
            var popup = popupComponent.createObject(null, {
                summary: notification.summary,
                body: notification.body,
                appIcon: notification.appIcon || notification.appName || "",
                notification: notification
            })
        }
    }
    
    readonly property var notifications: server.trackedNotifications
    
    // Processes for focusing/launching
    property var findWindowProc: Process {
        id: findProc
        property string appClass: ""
        property string windowAddress: ""
        command: ["sh", "-c", "hyprctl clients -j | jq -r '.[] | select(.class == \"" + appClass + "\") | .address' | head -1"]
        
        onRunningChanged: {
            if (!running && windowAddress === "") {
                // Process finished but no output, try launching
                launchAppProc.running = true
            }
        }
        
        stdout: SplitParser {
            onRead: function(line) {
                findProc.windowAddress = line.trim()
                if (findProc.windowAddress) {
                    findProc.running = false
                    focusWindowProc.windowAddr = findProc.windowAddress
                    focusWindowProc.running = true
                }
            }
        }
    }
    
    property var focusWindowProc: Process {
        id: focusProc
        property string windowAddr: ""
        command: ["hyprctl", "dispatch", "focuswindow", "address:" + windowAddr]
    }
    
    property var launchAppProc: Process {
        id: launchProc
        property string desktopEntry: ""
        command: ["gtk-launch", desktopEntry]
    }
    
    function focusOrLaunchApp(notification) {
        var desktopEntry = notification.desktopEntry || notification.appName || ""
        
        if (desktopEntry) {
            // Reset state
            findProc.windowAddress = ""
            
            launchAppProc.desktopEntry = desktopEntry
            findWindowProc.appClass = desktopEntry
            findWindowProc.running = true
        }
    }
    
    function closeNotification(notif) {
        notif.tracked = false
        notif.close(NotificationCloseReason.DismissedByUser)
    }
}
