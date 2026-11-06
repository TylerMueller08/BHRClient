import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    color: "#121314"
    radius: 10

    ScrollView {
        anchors.fill: parent
        anchors.margins: 10
        clip: true

        TextArea {
            id: terminal
            width: parent.width
            height: parent.height
            
            color: "#cccccc"
            font.family: "Segoe UI"
            font.pixelSize: 14
            wrapMode: TextEdit.WrapAnywhere
            selectByMouse: true
            
            property string prompt: "user@terminal:~$ "
            text: "Welcome to Blue Horizon Rocketry!\n\n" + prompt
            
            Component.onCompleted: forceActiveFocus()
            onCursorPositionChanged: {
                var promptIndex = text.lastIndexOf(prompt) + prompt.length
                if (cursorPosition < promptIndex) {
                    cursorPosition = text.length
                }
            }

            Keys.onPressed: (event) => {
                var promptIndex = text.lastIndexOf(prompt) + prompt.length

                if (event.key === Qt.Key_Backspace && cursorPosition <= promptIndex) {
                    event.accepted = true
                    return
                }

                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    var command = text.substring(promptIndex, text.length).trim()
                    processCommand(command) 
                    event.accepted = true
                }
            }

            function processCommand(cmd) {
                var response = ""
                
                if (cmd === "clear") {
                    text = prompt
                    return
                } else if (cmd === "help") {
                    response = "\nAvailable Commands: help, clear"
                } else if (cmd === "meow") {
                    response = "\nMeow!"
                } else if (cmd !== "") {
                    response = "\n" + cmd + ": command not found"
                }

                text += response + "\n\n" + prompt
                cursorPosition = text.length
            }
            background: null
        }
    }
}