import QtQuick
import QtQuick3D

Node {
    id: root
    objectName: "Root"

    property alias rotateNode: pivot
    property alias wasdNode: wasd

    // Resources
    PrincipledMaterial {
        id: principledMaterial_material
        objectName: "PrincipledMaterial"
        metalness: 0
        roughness: 1
        baseColor: "white"
        cullMode: Material.NoCulling
        alphaMode: PrincipledMaterial.Opaque
        lighting: PrincipledMaterial.NoLighting
    }


    // Nodes:
    Node{
        id: wasd
        Node {
            id: pivot
            Node {
                id: ship
                position: Qt.vector3d(0,-100,0)

                Model {
                    id: body
                    objectName: "body"
                    source: "meshes/body_mesh.mesh"
                    materials: [
                        principledMaterial_material
                    ]
                }
                Model {
                    id: nose
                    objectName: "nose"
                    source: "meshes/nose_mesh.mesh"
                    materials: [
                        principledMaterial_material
                    ]
                }
                Model {
                    id: nozzle
                    objectName: "nozzle"
                    source: "meshes/nozzle_mesh.mesh"
                    materials: [
                        principledMaterial_material
                    ]
                }
                Model {
                    id: fins
                    objectName: "fins"
                    source: "meshes/fins_mesh.mesh"
                    materials: [
                        principledMaterial_material
                    ]
                }
            }
            
        }
    }

    
    // Animations:
}
