import QtQuick
import QtQuick.Controls

Window {
    visible: true
    width: 1440; height: 810
    title: "Blue Horizon Rocketry Application"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "screens/MainScreen.qml"
        background: Rectangle { color: "#121314" }
    }
}