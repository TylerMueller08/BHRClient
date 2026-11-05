import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../widgets"

Rectangle {
    color: "#191a1b"
    radius: 10

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Rectangle {
            color: "#008000"
            radius: 10
            Layout.fillHeight: true
            Layout.preferredWidth: parent.height

            Text {
                anchors.centerIn: parent
                text: "Launch"
                font.family: "Segoe UI"
                font.weight: Font.Bold
                font.pointSize: 24
                color: "#cccccc"
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: telemetry.sendCommand("LAUNCH_SEQUENCE", "ARMED")
            }
        }

        Terminal {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2
        }

        Rectangle {
            color: "#CC0000"
            radius: 10
            Layout.fillHeight: true
            Layout.preferredWidth: parent.height

            Text {
                anchors.centerIn: parent
                text: "Abort"
                font.family: "Segoe UI"
                font.weight: Font.Bold
                font.pointSize: 24
                color: "#cccccc"
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: telemetry.sendCommand("ABORT", "EMERGENCY")
            }
        }
    }
}