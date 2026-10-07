import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GridLayout {
    anchors.fill: parent
    anchors.margins: 10

    columns: 2
    columnSpacing: 10
    rowSpacing: 10

    WindowContainer {
        Layout.rowSpan: 3
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: 2.5

        window: synnaxApp
    }

    Rectangle {
        color: "lightgreen"

        Layout.fillWidth: true
        Layout.fillHeight: true

        Text {
            anchors.centerIn: parent
            text: "Camera #1"
        }
    }

    Rectangle {
        color: "orange"

        Layout.fillWidth: true
        Layout.fillHeight: true

        Text {
            anchors.centerIn: parent
            text: "Camera #2"
        }
    }

    Rectangle {
        color: "lightpink"

        Layout.fillWidth: true
        Layout.fillHeight: true

        Text {
            anchors.centerIn: parent
            text: "Camera #3"
        }
    }
}