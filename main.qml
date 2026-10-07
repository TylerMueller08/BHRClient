import QtQuick
import QtQuick.Controls
import "screens/themes"

Window {
    visible: true
    width: 960; height: 540
    title: "Blue Horizon Rocketry Application"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "screens/MainScreen.qml"
        background: Rectangle { color: Theme.backgroundColor }
    }

    Label {
        text: "Blue Horizon Rocketry"
        anchors.top: parent.top
        anchors.topMargin: 75
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: Theme.fontFamily
        font.pointSize: Theme.titleSize
        font.bold: true
    }
}