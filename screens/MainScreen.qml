import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    anchors.fill: parent

    RowLayout {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 5

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 5

            LogPanelScreen {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: controlPanel
                color: "gray"
                Layout.fillWidth: true
                Layout.preferredHeight: rightPanel.cameraHeight

                Text {
                    anchors.centerIn: parent
                    text: "Control Panel"
                }
            }
        }

        Item {
            id: rightPanel
            Layout.fillHeight: true
            Layout.preferredWidth: (height > 10) ? (height - 10) * 16 / 27 : 200
            readonly property real cameraHeight: width * 9 / 16

            Column {
                anchors.fill: parent
                spacing: 5

                CameraScreen {
                    width: parent.width
                    height: rightPanel.cameraHeight

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            stackView.push("CameraScreen.qml")
                        }
                    }
                }

                Rectangle {
                    id: cam2
                    color: "orange"
                    width: parent.width
                    height: rightPanel.cameraHeight

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            stackView.push("CameraScreen.qml")
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "Camera #2"
                    }
                }

                Rectangle {
                    id: cam3
                    color: "lightpink"
                    width: parent.width
                    height: rightPanel.cameraHeight

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            stackView.push("CameraScreen.qml")
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "Camera #3"
                    }
                }
            }
        }
    }
}