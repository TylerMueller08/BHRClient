import QtQuick
import QtQuick3D
import QtQuick3D.Helpers
import QtQuick.Layouts

ColumnLayout {
    Item {
        Layout.preferredHeight: 260
        Layout.preferredWidth: 200
        
        id: rocketView
        Component.onCompleted: console.log(typeof rocketView.resetOrientation)
        function resetOrientation() {rocket.eulerRotation = Qt.vector3d(0, 0, 0)}
        
        View3D {
            id: view
            focus: true
            anchors.fill: parent
        
            Component.onCompleted: forceActiveFocus()
            TapHandler { onTapped: view.forceActiveFocus() }

            

            property var held: ({})
            property real degPerSec: 90

            Keys.onPressed: (e) => { if (!e.isAutoRepeat) held[e.key] = true}
            Keys.onReleased: (e) => { if (!e.isAutoRepeat) held[e.key] = false}

            environment: SceneEnvironment {
                backgroundMode: SceneEnvironment.Color
                clearColor: "#191a1b"
                antialiasingMode: SceneEnvironment.MSAA
            }

            PerspectiveCamera {
                position: Qt.vector3d(0, 250, 650)
                id: camera
                eulerRotation.x: -15 
                fieldOfView: 90
            }


            FrameAnimation {
                running: true
                onTriggered: {
                    const pitch = Math.sin(elapsedTime * (Math.random() + 5))
                    const yaw = Math.sin(elapsedTime * (Math.random() + 5) + 1) * 0.5
                    const roll = (view.degPerSec * frameTime) * 2
                    const a = view.degPerSec * frameTime
                    if (view.held[Qt.Key_W]) rocket.rotate(a, Qt.vector3d(1,0,0), Node.LocalSpace)
                    if (view.held[Qt.Key_S]) rocket.rotate(-a, Qt.vector3d(1,0,0), Node.LocalSpace)
                    if (view.held[Qt.Key_D]) rocket.rotate(a, Qt.vector3d(0,0,1), Node.LocalSpace)
                    if (view.held[Qt.Key_A]) rocket.rotate(-a, Qt.vector3d(0,0,1), Node.LocalSpace)
                    if (view.held[Qt.Key_Q]) rocket.rotate(a, Qt.vector3d(0,1,0), Node.LocalSpace)
                    if (view.held[Qt.Key_E]) rocket.rotate(-a, Qt.vector3d(0,1,0), Node.LocalSpace)
                    if (view.held[Qt.Key_R]) rocket.eulerRotation = Qt.vector3d(0, 0, 0); rocket.bodyNode.eulerRotation = Qt.vector3d(0,0,0)

                    rocket.bodyNode.rotate(pitch, Qt.vector3d(1, 0 , 0), Node.LocalSpace)
                    rocket.bodyNode.rotate(yaw, Qt.vector3d(0, 0, 1), Node.LocalSpace)
                    rocket.bodyNode.rotate(roll, Qt.vector3d(0, 1 , 0), Node.LocalSpace)

                }
            }

            RocketMesh {
                id: rocket
                scale: Qt.vector3d(5, 5, 5)
            }
        }
    }

    Rectangle {
        Layout.preferredHeight: 30
        Layout.preferredWidth: 200
        color: "#121314"
        
        Text {
            anchors.centerIn: parent
            text: "Reset"
            font.family: "Segoe UI"
            font.weight: Font.Bold
            font.pointSize: 8
            color: "#cccccc"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: rocketView.resetOrientation()
        }
    }
}
