import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GridLayout {
    anchors.margins: 10

    columns: 2
    columnSpacing: 5

    Rectangle {
        color: "lightgray"
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
    
    Rectangle {
        color: "lightgray"
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}