import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../widgets"

Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: "#191a1b"
    radius: 10

    Timer {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Row {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 15
        
        Gauge {
            title: "Oxygen"
            value: 100
            minValue: 0
            maxValue: 100
            unit: "%"
            decimals: 1
            accentColor: "#004F98"
        }

        Gauge {
            title: "Fuel"
            value: 100
            minValue: 0
            maxValue: 100
            unit: "%"
            decimals: 1
            accentColor: "#004F98"
        }

        Gauge {
            title: "Nitrogen"
            value: 100
            minValue: 0
            maxValue: 100
            unit: "%"
            decimals: 1
            accentColor: "#004F98"
        }
    }
}