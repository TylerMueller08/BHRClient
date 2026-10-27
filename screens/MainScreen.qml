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
                    cameraKey: "vid_0408&pid_547e&mi_00"
                    label: "Laptop Cam"
                }

                CameraScreen {
                    width: parent.width
                    height: rightPanel.cameraHeight
                    cameraKey: "1d1eb0e8"
                    label: "C920 A"
                }

                CameraScreen {
                    width: parent.width
                    height: rightPanel.cameraHeight
                    cameraKey: "389a725b"
                    label: "C920 B"
                }
            }
        }
    }
}