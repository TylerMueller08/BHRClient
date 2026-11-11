import QtQuick
import QtQuick.Controls

Window {
    visible: true
    width: 1600; height: 900
    title: "Blue Horizon Rocketry Application"

    minimumWidth: 1600
    minimumHeight: 900

    property alias fullscreenLayer: fullscreenLayer

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "screens/MainScreen.qml"
        background: Rectangle { color: "#121314" }
    }

    Item {
        id: fullscreenLayer
        anchors.fill: parent
        z: 1
    }
}