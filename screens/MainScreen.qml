import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    anchors.fill: parent

    GridLayout {
        anchors.fill: parent
        anchors.margins: 10

        columns: 2
        columnSpacing: 10
        rows: 3
        rowSpacing: 10

        LogPanelScreen {
            Layout.rowSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2
        }

        CameraScreen {
            Layout.fillWidth: true
            Layout.fillHeight: true

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
            Layout.fillWidth: true
            Layout.fillHeight: true

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
            id: controlPanel
            color: "gray"
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text {
                anchors.centerIn: parent
                text: "Control Panel"
            }
        }

        Rectangle {
            id: cam3
            color: "lightpink"
            Layout.fillWidth: true
            Layout.fillHeight: true

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
