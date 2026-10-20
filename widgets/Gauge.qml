import QtQuick

Item {
    id: gauge

    property string title
    property real value
    property real minValue
    property real maxValue
    property string unit
    property int decimals
    property color accentColor

    implicitWidth: 120
    implicitHeight: 120

    readonly property real fraction:
        maxValue > minValue
        ? Math.max(0, Math.min(1,
            (value - minValue) / (maxValue - minValue)))
        : 0

    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: gauge.title
        font.family: "Segoe UI"
        font.weight: Font.DemiBold
        font.pointSize: 14
        color: "#cccccc"
    }

    Canvas {
        id: dial
        width: parent.width * 0.84
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.2

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var cx = width / 2
            var cy = height / 2
            var r = width * 0.40
            var line = Math.max(8, width * 0.055)
            var strokeWidth = 2

            var start = Math.PI * 0.75
            var sweep = Math.PI * 1.5

            ctx.beginPath()
            ctx.arc(cx, cy, r, start,
                    start + sweep, false)
            ctx.strokeStyle = "#383838"
            ctx.lineWidth = line + strokeWidth
            ctx.lineCap = "round"
            ctx.stroke()

            if (gauge.fraction > 0) {
                ctx.beginPath()
                ctx.arc(cx, cy, r, start,
                    start + sweep * gauge.fraction, false)
                ctx.strokeStyle = gauge.accentColor
                ctx.lineWidth = line
                ctx.lineCap = "round"
                ctx.stroke()
            }
        }

        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.47
        text: Number(gauge.value).toFixed(gauge.decimals)
        color: "#cccccc"
        font.pixelSize: parent.width * 0.13
        font.family: "Segoe UI"
        font.weight: Font.DemiBold
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.61
        text: gauge.unit
        color: "#cccccc"
        font.pixelSize: parent.width * 0.1
        font.family: "Segoe UI"
        font.weight: Font.DemiBold
    }

    Text {
        x: parent.width * 0.25
        y: parent.height * 0.85
        text: gauge.minValue
        color: "#cccccc"
        font.pixelSize: 14
        font.family: "Segoe UI"
        font.weight: Font.DemiBold
    }

    Text {
        x: parent.width * 0.6
        y: parent.height * 0.85
        text: gauge.maxValue
        color: "#cccccc"
        font.pixelSize: 14
        font.family: "Segoe UI"
        font.weight: Font.DemiBold
    }

    onValueChanged: dial.requestPaint()
    onMinValueChanged: dial.requestPaint()
    onMaxValueChanged: dial.requestPaint()
    onAccentColorChanged: dial.requestPaint()
}
