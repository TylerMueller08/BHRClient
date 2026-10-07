import QtQuick
import QtQuick.Controls

Window {
    visible: true
    width: 960; height: 540
    title: "Blue Horizon Rocketry Application"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "screens/MainScreen.qml"
    }
}