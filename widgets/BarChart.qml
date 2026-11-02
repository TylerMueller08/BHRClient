import QtQuick

Item {
    id: barChart

    property string title
    property real value
    property real minValue
    property real maxValue
    property string unit
    property int decimals
    property color accentColor

    implicitWidth: 140
    implicitHeight: 300

    readonly property real fraction:
        maxValue > minValue
        ? Math.max(0, Math.min(1,
            (value - minValue) / (maxValue - minValue)))
        : 0

    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: barChart.title
        font.family: "Segoe UI"
        font.weight: Font.DemiBold
        font.pointSize: 12
        color: "#cccccc"
    }

    Item {
        id: chartArea
        y: parent.height * 0.1
        width: parent.width * 0.45
        height: parent.height * 0.8
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: fill
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: parent.height * barChart.fraction
            color: barChart.accentColor
        }

        Canvas {
            id: chart
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset()

                ctx.strokeStyle = "#000000"
                ctx.lineWidth = 5
                ctx.strokeRect(0, 0, width, height)
            }

            onWidthChanged: requestPaint()
            onHeightChanged: requestPaint()
        }
    }

    Text {
        x: parent.width * 0.16
        y: parent.height * 0.9
        text: barChart.minValue
        color: "#cccccc"
        font.pixelSize: 14
        font.family: "Segoe UI"
        font.weight: Font.DemiBold
    }

    Text {
        x: parent.width * 0.75
        y: parent.height * 0.9
        text: barChart.maxValue
        color: "#cccccc"
        font.pixelSize: 14
        font.family: "Segoe UI"
        font.weight: Font.DemiBold
    }
}