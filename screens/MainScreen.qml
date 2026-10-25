import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    anchors.fill: parent

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            MainPanel {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            ControlPanel {
                Layout.fillWidth: true
                Layout.preferredHeight: rightPanel.cameraHeight
            }
        }

        Item {
            id: rightPanel
            Layout.fillHeight: true
            Layout.preferredWidth: (height > 20) ? (height - 20) * 16 / 27 : 200
            readonly property real cameraHeight: width * 9 / 16

            Column {
                anchors.fill: parent
                spacing: 10

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
                    color: "#191a1b"
                    width: parent.width
                    height: rightPanel.cameraHeight
                    radius: 10

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
                        text: "Camera Not Connected"
                        font.family: "Segoe UI"
                        font.weight: Font.DemiBold
                        font.pointSize: 11
                        color: "#cccccc"
                    }
                }

                Rectangle {
                    id: cam3
                    color: "#191a1b"
                    width: parent.width
                    height: rightPanel.cameraHeight
                    radius: 10

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
                        text: "Camera Not Connected"
                        font.family: "Segoe UI"
                        font.weight: Font.DemiBold
                        font.pointSize: 11
                        color: "#cccccc"
                    }
                }
            }
        }
    }
}