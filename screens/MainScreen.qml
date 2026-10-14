import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Item {
    anchors.fill: parent

    GridLayout {
        anchors.fill: parent
        anchors.margins: 10

        columns: 2
        columnSpacing: 10
        rowSpacing: 10

        Rectangle {
            color: "black"
            Layout.rowSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2.5
            
            Text {
                anchors.centerIn: parent
                text: "Empty"
                color: "white"
            }
        }

        Rectangle {
            id: cam1
            color: "lightgreen"
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text {
                anchors.centerIn: parent
                text: "Camera #1"
            }
        }

        Rectangle {
            id: cam2
            color: "orange"
            Layout.fillWidth: true
            Layout.fillHeight: true

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

            Text {
                anchors.centerIn: parent
                text: "Camera #3"
            }
        }
    }
}
