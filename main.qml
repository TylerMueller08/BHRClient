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

        pushEnter: Transition {
            PropertyAnimation { property: "x"; from: stackView.width; to: 0; duration: 400; easing.type: Easing.OutQuad }
            PropertyAnimation { property: "opacity"; from: 0; to: 1; duration: 400 }
        }
    }

    Connections {
        target: stackView.currentItem
        function onGoToCamera1() {
            stackView.push("screens/Camera1.qml")
        }
        function onGoToCamera2() {
            stackView.push("screens/Camera2.qml")
        }
        function onGoToCamera3() {
            stackView.push("screens/Camera3.qml")
        }
    }
}