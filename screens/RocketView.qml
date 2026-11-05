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

        function resetOrientation() {
            originNode.position = Qt.vector3d(0, 0, 0);
            originNode.eulerRotation = Qt.vector3d(90,0,0);
        }
        
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
                
            }


            FrameAnimation {
                running: true
                property real phase: Math.random() * 6.28
                onTriggered: {
                    const t = elapsedTime
                    const a = view.degPerSec * frameTime
                    if (view.held[Qt.Key_W]) rocket.rotate(a, Qt.vector3d(1,0,0), Node.LocalSpace)
                    if (view.held[Qt.Key_S]) rocket.rotate(-a, Qt.vector3d(1,0,0), Node.LocalSpace)
                    if (view.held[Qt.Key_D]) rocket.rotate(-a, Qt.vector3d(0,0,1), Node.LocalSpace)
                    if (view.held[Qt.Key_A]) rocket.rotate(a, Qt.vector3d(0,0,1), Node.LocalSpace)
                    if (view.held[Qt.Key_Q]) rocket.rotate(a, Qt.vector3d(0,1,0), Node.LocalSpace)
                    if (view.held[Qt.Key_E]) rocket.rotate(-a, Qt.vector3d(0,1,0), Node.LocalSpace)
                    if (view.held[Qt.Key_R]) {
                        rocketView.resetOrientation();
                    } 

                    rocket.rotateNode.eulerRotation = Qt.vector3d(4 * Math.sin(t * 2.0 + phase), (90 * t) % 360, 4 * Math.sin(t * 2.6))
                    

                }
            }

            RocketMesh {
                id: rocket
                scale: Qt.vector3d(5, 5, 5)
                eulerRotation: Qt.vector3d(90,0,0)
            }

            camera: cameraNode
            Node {
                id: originNode
                eulerRotation: Qt.vector3d(90,0,0)
                PerspectiveCamera {
                    id: cameraNode
                    position: Qt.vector3d(0, 250, 650)
                    eulerRotation.x: -15
                    fieldOfView: 90
                }
            }
            OrbitCameraController {
                anchors.fill: parent
                origin: originNode
                camera: cameraNode
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
