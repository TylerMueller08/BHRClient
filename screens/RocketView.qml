import QtQuick
import QtQuick3D
import QtQuick3D.Helpers

Item {
    width: 200
    height: 300
    
    
    View3D {
        id: view
        focus: true
        Component.onCompleted: forceActiveFocus()
        TapHandler { onTapped: view.forceActiveFocus() }

        property var held: ({})
        property real degPerSec: 90

        Keys.onPressed: (e) => { if (!e.isAutoRepeat) held[e.key] = true}
        Keys.onReleased: (e) => { if (!e.isAutoRepeat) held[e.key] = false}

        anchors.fill: parent

        environment: SceneEnvironment {
            backgroundMode: SceneEnvironment.Color
            clearColor: "#191a1b"
            antialiasingMode: SceneEnvironment.MSAA
        }

        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(0, 250, 650)
            eulerRotation.x: -15 
            fieldOfView: 90

        }


        FrameAnimation {
            running: true
            onTriggered: {
                const pitch = Math.sin(elapsedTime * (Math.random() + 5)) * 0.5
                const yaw = Math.sin(elapsedTime * (Math.random() + 5) + 1) * 0.5
                const roll = (view.degPerSec * frameTime) * 2
                const a = view.degPerSec * frameTime
                if (view.held[Qt.Key_W]) rocket.rotate(a, Qt.vector3d(1,0,0), Node.LocalSpace)
                if (view.held[Qt.Key_S]) rocket.rotate(-a, Qt.vector3d(1,0,0), Node.LocalSpace)
                if (view.held[Qt.Key_D]) rocket.rotate(a, Qt.vector3d(0,0,1), Node.LocalSpace)
                if (view.held[Qt.Key_A]) rocket.rotate(-a, Qt.vector3d(0,0,1), Node.LocalSpace)
                if (view.held[Qt.Key_Q]) rocket.rotate(a, Qt.vector3d(0,1,0), Node.LocalSpace)
                if (view.held[Qt.Key_E]) rocket.rotate(-a, Qt.vector3d(0,1,0), Node.LocalSpace)
                if (view.held[Qt.Key_R]) rocket.eulerRotation = Qt.vector3d(0, 0, 0)

                rocket.rotate(pitch, Qt.vector3d(1, 0 , 0), Node.LocalSpace)
                rocket.rotate(yaw, Qt.vector3d(0, 0, 1), Node.LocalSpace)
                rocket.rotate(roll, Qt.vector3d(0, 1 , 0), Node.LocalSpace)

            }
        }

        RocketMesh {
            id: rocket
            scale: Qt.vector3d(5, 5, 5)
        }
    }
}