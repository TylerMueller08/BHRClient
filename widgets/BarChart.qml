import QtQuick

Item {
    id: barChart

    property string title
    property real value
    property real minValue
    property real maxValue
    property string unit
    property color accentColor

    property int majorCount: 5
    property int minorCount: 4
    property color tickColor: "gray"

    implicitWidth: 200
    implicitHeight: 300

    readonly property int stepsPerMajor: minorCount + 1
    readonly property int totalTicks: (majorCount - 1) * stepsPerMajor + 1

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
        font.weight: Font.Bold
        font.pointSize: 13
        color: "#cccccc"
    }

    Item {
        id: chartArea
        y: parent.height * 0.1
        width: parent.width * 0.3
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

        Repeater {
            model: barChart.totalTicks

            delegate: Rectangle {
                readonly property bool major: index % barChart.stepsPerMajor === 0
                readonly property real frac: index / (barChart.totalTicks - 1)

                width: major ? 16 : 8
                height: major ? 2 : 1
                color: barChart.tickColor
                anchors.right: parent.left
                anchors.rightMargin: 4
                y: chartArea.height * (1 - frac) - height / 2
            }
        }
    }

    Text {
        x: parent.width * 0.32
        y: parent.height * 0.9
        text: barChart.minValue
        color: "#cccccc"
        font.pixelSize: 15
        font.family: "Segoe UI"
        font.weight: Font.DemiBold
    }

    Text {
        x: parent.width * 0.60
        y: parent.height * 0.9
        text: barChart.maxValue
        color: "#cccccc"
        font.pixelSize: 15
        font.family: "Segoe UI"
        font.weight: Font.DemiBold
    }
}