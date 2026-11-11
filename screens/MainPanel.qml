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

        RowLayout {
            id: topRow
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

            Timer { }
        }

        Item {
            id: middleRow
            Layout.fillWidth: true
            Layout.fillHeight: true

            readonly property int gap: 15

            PyQtGraphItem {
                id: graphItem
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                width: Math.max(0, Math.min(implicitWidth,
                       middleRow.width - 2 * (Math.max(rocketView.width, barChart.width) + middleRow.gap)))

                Component.onCompleted: telemetry.registerGraph(graphItem)
            }

            Item {
                anchors.left: parent.left
                anchors.right: graphItem.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                RocketView {
                    id: rocketView
                    anchors.centerIn: parent
                }
            }

            Item {
                anchors.left: graphItem.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                BarChart {
                    id: barChart
                    anchors.centerIn: parent

                    title: "Altitude"
                    value: telemetry ? telemetry.altitude : 0
                    minValue: 0
                    maxValue: 100
                    accentColor: "#ababab"
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            spacing: 15

            Gauge {
                title: "Oxygen"
                value: telemetry ? telemetry.oxygen : 0
                minValue: 0
                maxValue: 100
                unit: "%"
                decimals: 1
                accentColor: "#004F98"
                selected: telemetry ? telemetry.activeGauge === title : false
                onClicked: telemetry.selectGauge(title)
            }

            Gauge {
                title: "Fuel"
                value: telemetry ? telemetry.fuel : 0
                minValue: 0
                maxValue: 100
                unit: "%"
                decimals: 1
                accentColor: "#00984F"
                selected: telemetry ? telemetry.activeGauge === title : false
                onClicked: telemetry.selectGauge(title)
            }

            Gauge {
                title: "Nitrogen"
                value: telemetry ? telemetry.nitrogen : 0
                minValue: 0
                maxValue: 100
                unit: "%"
                decimals: 1
                accentColor: "#D97706"
                selected: telemetry ? telemetry.activeGauge === title : false
                onClicked: telemetry.selectGauge(title)
            }
        }
    }
}