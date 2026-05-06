import QtQuick
import QtQuick.Layouts
import "../Scripts"

Item {
    id: root

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        Text {
            text: "Notifications"
            font.pixelSize: 18
            font.bold: true
            color: "#cdd6f4"
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 8
            clip: true

            model: NotificationService.notifications

            delegate: Rectangle {
                required property var modelData
                required property int index

                width: ListView.view.width
                height: Math.max(80, notifContent.implicitHeight + 24)
                radius: 12
                color: "#313244"

                RowLayout {
                    id: notifContent
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 12

                    // App Icon
                    Rectangle {
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40
                        Layout.alignment: Qt.AlignTop
                        color: "#45475a"
                        radius: 8

                        Image {
                            id: delegateImage
                            anchors.fill: parent
                            anchors.margins: modelData.image ? 0 : 6
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                            cache: false
                            source: {
                                var img = modelData.image || "";
                                if (img !== "") {
                                    if (img.startsWith("file://")) return img;
                                    if (img.startsWith("/"))       return "file://" + img;
                                    if (img.startsWith("http") || img.startsWith("data:")) return "";
                                    return img;
                                }
                                var icon = modelData.appIcon || "";
                                if (icon !== "") {
                                    if (icon.startsWith("file://")) return icon;
                                    if (icon.startsWith("/"))       return "file://" + icon;
                                    return "image://icon/" + icon;
                                }
                                return "";
                            }
                            visible: delegateImage.status === Image.Ready
                        }

                        Text {
                            anchors.centerIn: parent
                            text: "󰂚"
                            font.family: "Symbols Nerd Font"
                            font.pixelSize: 20
                            color: "#6c7086"
                            visible: delegateImage.status !== Image.Ready
                        }

                        // Last child = top of z-order, receives clicks over Image
                        MouseArea {
                            anchors.fill: parent
                            onClicked: NotificationService.focusOrLaunchApp(modelData)
                        }
                    }

                    // Wrap ColumnLayout in Item so MouseArea can anchors.fill properly
                    Item {
                        Layout.fillWidth: true
                        implicitHeight: textCol.implicitHeight

                        ColumnLayout {
                            id: textCol
                            width: parent.width
                            spacing: 4

                            Text {
                                text: modelData.summary || "Notification"
                                font.bold: true
                                font.pixelSize: 14
                                color: "#cdd6f4"
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }

                            Text {
                                text: modelData.body || ""
                                font.pixelSize: 12
                                color: "#a6adc8"
                                Layout.fillWidth: true
                                wrapMode: Text.WordWrap
                                visible: text !== ""
                            }
                        }

                        // Last child = on top of text, receives clicks
												MouseArea {
														anchors.fill: parent
														onClicked: {
																console.log("Clicked notification:", modelData.appName, JSON.stringify(modelData))
																NotificationService.focusOrLaunchApp(modelData)
														}
												}
										}

                    Text {
                        text: "✕"
                        color: "#f38ba8"
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignTop

                        MouseArea {
                            anchors.fill: parent
                            onClicked: NotificationService.closeNotification(modelData)
                        }
                    }
                }
            }
        }
    }
}
