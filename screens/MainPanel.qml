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
        RowLayout {

            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            spacing: 30
            ColumnLayout {
                RocketView {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    id: rocketView
                }

                Rectangle {
                    height: 40
                    width: 200
                    color: "#121314"
                    
                    Text {
                        anchors.centerIn: parent
                        text: "Reset"
                        font.family: "Segoe UI"
                        font.weight: Font.Bold
                        font.pointSize: 8
                        color: "#cccccc"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: rocketView.resetOrientation()
                    }
                }
            }
            

            PyQtGraphItem {
                id: graphItem

                Layout.alignment: Qt.AlignHCenter | Qt.AlignRight
                Layout.fillHeight: true
                width: mainPanel.width * 0.45

                Component.onCompleted: telemetry.registerGraph(graphItem)
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