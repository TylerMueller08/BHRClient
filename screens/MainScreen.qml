import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Item {
    id: rootWindow
    anchors.fill: parent

    property string activeCameraName: ""
    property color activeCameraColor: "transparent"

    GridLayout {
        id: grid
        anchors.fill: parent
        anchors.margins: 10
        columns: 2
        columnSpacing: 10
        rowSpacing: 10

        Rectangle {
            color: "black"
            Layout.rowSpan: 3
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2.5
            
            Text {
                anchors.centerIn: parent
                text: "Synnax Application"
                color: "white"
            }
        }

        Rectangle {
            id: cam1
            color: "lightgreen"
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text { anchors.centerIn: parent; text: "Camera #1" }
            
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    rootWindow.activeCameraName = "Camera #1"
                    rootWindow.activeCameraColor = cam1.color
                }
                HoverHandler { cursorShape: Qt.PointingHandCursor }
            }
        }

        Rectangle {
            id: cam2
            color: "orange"
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text { anchors.centerIn: parent; text: "Camera #2" }
            
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    rootWindow.activeCameraName = "Camera #2"
                    rootWindow.activeCameraColor = cam2.color
                }
                HoverHandler { cursorShape: Qt.PointingHandCursor }
            }
        }

        Rectangle {
            id: cam3
            color: "lightpink"
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text { anchors.centerIn: parent; text: "Camera #3" }
            
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    rootWindow.activeCameraName = "Camera #3"
                    rootWindow.activeCameraColor = cam3.color
                }
                HoverHandler { cursorShape: Qt.PointingHandCursor }
            }
        }
    }

    Rectangle {
        id: fullscreenOverlay
        anchors.fill: parent
        anchors.margins: 10
        color: rootWindow.activeCameraColor
        
        visible: rootWindow.activeCameraName !== ""
        z: 999 

        Text {
            anchors.centerIn: parent
            text: rootWindow.activeCameraName
            font.pixelSize: 18
            horizontalAlignment: Text.AlignHCenter
            color: "black"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                rootWindow.activeCameraName = ""
                rootWindow.activeCameraColor = "transparent"
            }
            HoverHandler { cursorShape: Qt.PointingHandCursor }
        }
    }
}
