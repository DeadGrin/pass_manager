import QtQuick 2.0

Rectangle {
    id: startWindow
    color: Style.mainbg
    anchors{
        left: parent.left
        right: parent.right
        top: parent.top
        bottom: parent.bottom
    }
    function sendKey()
    {

    }

    Rectangle{
        id: invisebleRectForKeyInput
        color: "transparent"
        anchors.centerIn: parent
        height: 65
        width: 240
        Text{
            id: keyLabel
            text: "key:"
            font.family: "Helvetica"
            font.pointSize: 20
            color: "white"
            anchors.top: invisebleRectForKeyInput.top
            anchors.left: invisebleRectForKeyInput.left
        }
        Text{
            id: wrongkeyLabel
            text: "wrong key"
            font.family: "Helvetica"
            font.pointSize: 20
            color: "transparent"
            anchors.top: invisebleRectForKeyInput.top
            anchors.left: keyLabel.right
            anchors.leftMargin: 10

            ColorAnimation {
                target:wrongkeyLabel
                id: disappearingText
                properties: "color"
                from: "#c95757";
                to:"transparent" ;
                duration: 3000
                easing.type:  Easing.InExpo
            }
        }
        Rectangle{
            id: inputRectangle
            anchors.top: keyLabel.bottom
            anchors.left: invisebleRectForKeyInput.left
            anchors.right: invisebleRectForKeyInput.right
            anchors.bottom: invisebleRectForKeyInput.bottom
            color: "black"
            border.color: Style.maincolor
            border.width: 1


            TextInput{
                id: keyAES
                width: parent.width
                anchors.fill:parent
                font.family: "Helvetica"
                font.pointSize: 20
                color: "white"
                clip: true
                selectionColor: "#aaaaaa"
                Keys.onReturnPressed: {
                    fileOperator.setKey(text)
                    if (fileOperator.verifyKey())
                    {
                        startKeyWindow.visible = false;
                    }
                    else
                    {
                        disappearingText.start()
                        text =""
                    }

                }


            }
        }


    }

}


