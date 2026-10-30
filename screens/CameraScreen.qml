import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Effects

Item {
    id: root
    property string cameraKey: ""
    property string label: "Camera"
    property bool running: true

    readonly property int camIndex: {
        if (!cameraFinder)
            return -1
        cameraFinder.revision
        return cameraFinder.indexOf(cameraKey)
    }
    readonly property bool found: camIndex >= 0
    property bool deviceBound: false
    property string errorText: ""
    
    function syncDevice() {
        if (found) {
            camera.cameraDevice = mediaDevices.videoInputs[camIndex]
            deviceBound = true
        } else {
            deviceBound = false
        }
    }

    onCamIndexChanged: {
        errorText = ""
        syncDevice()
    }

    Component.onCompleted: syncDevice()

    MediaDevices {
        id: mediaDevices
    }

    CaptureSession {
        id: captureSession
        camera: Camera {
            id: camera
            active: root.running && root.deviceBound
            onErrorOccurred: (error, errorString) => root.errorText = errorString
        }
        videoOutput: videoOutput
    }

    Rectangle {
        id: viewPanel
        anchors.fill: parent
        color: "#191a1b"
        radius: root.state === "fullscreen" ? 0 : 10

        VideoOutput {
            id: videoOutput
            anchors.fill: parent
            visible: false
        }
        MultiEffect {
            anchors.fill: videoOutput
            source: videoOutput
            maskEnabled: root.state !== "fullscreen"
            maskSource: maskRect
        }
        Rectangle {
            id: maskRect
            anchors.fill: parent
            radius: root.state === "fullscreen" ? 0 : 10
            color: "black"
            visible: false
            layer.enabled: true
        }
        Text {
            anchors.centerIn: parent
            width: parent.width-20
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            color: "#cccccc"
            font.family: "Segoe UI"
            font.weight: Font.DemiBold
            font.pixelSize: 14
            visible: !root.found || root.errorText !== ""
            text: !root.found ? root.label + " is Not Connected!"
                             :root.label + ": " + root.errorText
        }
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.state = (root.state === "fullscreen") ? "" : "fullscreen"
        }
    }

    states: State {
        name: "fullscreen"
        ParentChange {target: viewPanel; parent: root.Window.window.fullscreenLayer}
    }
}