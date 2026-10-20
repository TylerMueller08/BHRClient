import QtQuick
import QtQuick.Controls
import QtMultimedia

Item {
    MediaDevices {
        id: mediaDevices
    }

    CaptureSession {
        id: captureSession
        camera: Camera {
            id: camera
            cameraDevice: mediaDevices.defaultVideoInput
        }
        videoOutput: videoOutput
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }

    Component.onCompleted: {
        camera.start()
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            stackView.pop()
        }
    }
}