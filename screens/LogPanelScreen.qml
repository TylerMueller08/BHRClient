import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../widgets"

Rectangle {
    color: "lightgray"
    Layout.fillWidth: true
    Layout.fillHeight: true

    Timer {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Graph {
        anchors.top: parent.top
        anchors.topMargin: 125
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