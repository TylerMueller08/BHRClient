import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import TelemetryGraph 1.0
import "../widgets"

Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: "#191a1b"
    radius: 10

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 15

        Timer {
            Layout.alignment: Qt.AlignHCenter
        }

        PyQtGraphItem {
            id: graphItem
            Layout.preferredWidth: 400
            Layout.preferredHeight: 280
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Component.onCompleted: telemetryController.registerGraph(graphItem)
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 15
            
            Gauge {
                title: "Oxygen"
                value: telemetryController.oxygen
                minValue: 0
                maxValue: 100
                unit: "%"
                decimals: 1
                accentColor: "#004F98"
                selected: telemetryController.activeGauge === title
                onClicked: telemetryController.selectGauge(title)
            }

            Gauge {
                title: "Fuel"
                value: telemetryController.fuel
                minValue: 0
                maxValue: 100
                unit: "%"
                decimals: 1
                accentColor: "#00984F"
                selected: telemetryController.activeGauge === title
                onClicked: telemetryController.selectGauge(title)
            }

            Gauge {
                title: "Nitrogen"
                value: telemetryController.nitrogen
                minValue: 0
                maxValue: 100
                unit: "%"
                decimals: 1
                accentColor: "#D97706"
                selected: telemetryController.activeGauge === title
                onClicked: telemetryController.selectGauge(title)
            }
        }
    }
}