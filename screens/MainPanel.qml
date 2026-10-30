import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import TelemetryGraph 1.0
import "../widgets"

Rectangle {
    id: mainPanel

    Layout.fillWidth: true
    Layout.fillHeight: true
    color: "#191a1b"
    radius: 10

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 15

        Timer {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        }

        PyQtGraphItem {
            id: graphItem

            Layout.alignment: Qt.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.fillHeight: true
            width: mainPanel.width * 0.45

            Component.onCompleted: telemetry.registerGraph(graphItem)
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            spacing: 15
            
            Gauge {
                title: "Oxygen"
                value: telemetry.oxygen
                minValue: 0
                maxValue: 100
                unit: "%"
                decimals: 1
                accentColor: "#004F98"
                selected: telemetry.activeGauge === title
                onClicked: telemetry.selectGauge(title)
            }

            Gauge {
                title: "Fuel"
                value: telemetry.fuel
                minValue: 0
                maxValue: 100
                unit: "%"
                decimals: 1
                accentColor: "#00984F"
                selected: telemetry.activeGauge === title
                onClicked: telemetry.selectGauge(title)
            }

            Gauge {
                title: "Nitrogen"
                value: telemetry.nitrogen
                minValue: 0
                maxValue: 100
                unit: "%"
                decimals: 1
                accentColor: "#D97706"
                selected: telemetry.activeGauge === title
                onClicked: telemetry.selectGauge(title)
            }
        }
    }
}