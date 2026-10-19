import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../widgets"

Rectangle {
    color: "lightgray"
    Layout.fillWidth: true
    Layout.fillHeight: true

    Row {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 10

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