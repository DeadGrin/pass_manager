import QtQuick 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Controls
import TableModel

Rectangle {
    id: filesPage
    anchors.fill:  parent
    color: Style.mainbg
    Text{
        id: filesText
        text: "Files:"
        font.family: "Helvetica"
        font.pointSize: 18
        color: "#cccccc"
        width: rectWithFilesList.width
        anchors {
            left: rectWithFilesList.left
            bottom: rectWithFilesList.top
            bottomMargin: 10
        }
    }
    Rectangle{
        id: rectWithFilesList
        width: 180
        anchors {
            topMargin:  60
            leftMargin: 40
            bottomMargin: 70
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        color: "#111111"
        radius: 8

        ListView {
            id: fileList
            anchors.fill: parent
            model: fileOperator.getFileList()
            delegate: Text {
                id: delegateText
                font.family: "Helvetica"
                font.pointSize: 18
                color: ListView.isCurrentItem ? "#111111" : Style.maincolor
                text: modelData
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        fileList.currentIndex = index
                        fileOperator.setCurrentFileName(modelData)
                        fileOperator.readToVector() ? tableOperator.setTable(fileOperator.getVector()) : tableOperator.askToAddPassTable()
                        //call func to decode file
                        //call method to display passwords in table

                        textcurrentFile.text = modelData
                    }
                }
            }
            highlight: Rectangle {
                id: highlightRectangle
                anchors{
                    left: parent.left
                    right: parent.right
                }
                color: Style.maincolor
                radius: rectWithFilesList.radius
            }
            highlightMoveDuration: 150
            focus: true
            clip: true
        }
    }
    Rectangle {
        id: rectAddNewFile
        anchors{
            left: rectWithFilesList.left
            right: rectWithFilesList.right
            top: rectWithFilesList.bottom
        }
        height: 30
        color: "#363636"
        radius:  rectWithFilesList.radius
        MouseArea{
            id: addNewFile
            anchors.fill: parent
            hoverEnabled: true
            onEntered:parent.color = "#444444"
            onExited:parent.color = "#363636"
            onPressed:parent.color = "#202020"
            onReleased:parent.color = "#363636"
            onClicked: popupForInputFileName.open()
        }
        Rectangle{
            anchors.centerIn: parent
            height:  12
            width:  2
            color:  Style.maincolor
        }
        Rectangle{
            anchors.centerIn: parent
            height:  2
            width:  12
            color:  Style.maincolor
        }
    }

    Text {
        // name of current file on top of content table
        id: textcurrentFile
        color: "#DDDDDD"
        text: ""
        font.family: "Helvetica"
        font.pointSize: 18
        anchors{
            bottom: filesText.bottom
            left:  passwordsHeader.left
        }
    }

    TextEdit{
            id: textEdit
            visible: true
            color: "transparent"
            font.family: "Helvetica"
            font.pointSize: 18
            anchors{
                bottom: filesText.bottom
                right:  passwordsHeader.right
            }
            selectionColor: "transparent"
            selectedTextColor:"#307438"
            selectByMouse: true
        }
    Timer{
        id: timerForTextEdit
        repeat: false
        interval: 1000
        onTriggered: textEdit.text = ""
    }

    Rectangle{
        id: passwordsHeader
        color: Style.maincolor
        height: 30
        anchors{
            left :rectWithPasswords.left
            right: rectWithPasswords.right
            top: rectWithFilesList.top
        }
        radius: 8
        Text{
            id: serviceText
            font.family: "Helvetica"
            font.pointSize: 18
            text: "Service"
            width: tableview.width/3.01
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
        Text{
            id: loginText
            font.family: "Helvetica"
            font.pointSize: 18
            text: "Login"
            width: tableview.width/3
            anchors.left: serviceText.right
            anchors.verticalCenter: parent.verticalCenter
        }
        Text{
            id: passwordText
            font.family: "Helvetica"
            font.pointSize: 18
            text: "Password"
            width: tableview.width/3
            anchors.left: loginText.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle{
        id: rectWithPasswords
        anchors {
            leftMargin: 40
            rightMargin: 40
            right: parent.right
            left: rectWithFilesList.right
            top: passwordsHeader.bottom
            bottom: rectWithFilesList.bottom
        }
        color: "#111111"
        radius: 8
        TableView {
            id: tableview
            anchors.fill: parent
            columnSpacing: 1
            rowSpacing: 1
            clip: true

            model: tableOperator

            delegate: Rectangle {
                id: delegateRectanglePassword
                implicitWidth: tableview.width/3
                implicitHeight: 20
                border.width: 0
                radius: 3
                color: Style.mainbg
                MouseArea{
                    hoverEnabled: true
                    anchors.fill: parent
                    onEntered: delegateRectanglePassword.color = "#444444"
                    onExited: delegateRectanglePassword.color = Style.mainbg
                    onDoubleClicked: {
                       textEdit.text = delegateTextPasswordsTable.text
                       textEdit.selectAll()
                       textEdit.copy()
                        timerForTextEdit.start()
                       delegateRectanglePassword.color = "#41cd52"
                    }
                }

                Text {
                    id: delegateTextPasswordsTable
                    color: "#DDDDDD"
                    text: display
                    anchors.left: parent.left
                    anchors.leftMargin: 2
                    font.family: "Helvetica"
                    font.pointSize: 13
                }
            }
        }
    }
    Rectangle {
        id: rectAddNewPasswordButton
        anchors{
            left:  rectWithPasswords.left
            top: rectWithPasswords.bottom
        }
        width: rectWithPasswords.width/2
        height: 30
        color: "#363636"
        radius:  rectWithPasswords.radius
        MouseArea{
            id: addNewPasswordButton
            anchors.fill: parent
            hoverEnabled: true
            onEntered:parent.color = "#444444"
            onExited:parent.color = "#363636"
            onPressed:parent.color = "#202020"
            onReleased:parent.color = "#363636"
            onClicked: popupForCreateNewPassword.open()
        }
        Rectangle{
            anchors.centerIn: parent
            height:  12
            width:  2
            color:  Style.maincolor
        }
        Rectangle{
            anchors.centerIn: parent
            height:  2
            width:  12
            color:  Style.maincolor
        }
    }




    Popup {
        id: popupForInputFileName
        anchors.centerIn: parent
        width: rectWithFilesList.width + 40
        height: 100
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        background:Rectangle{
            color: Style.mainbg
            radius: 8
            border.width: 1
            border.color: Style.maincolor
        }
        Text{
            id:textPopupAsksToEnter
            anchors.left : rectNewFileName.left
            text: "Enter new file name"
            font.family: "Helvetica"
            font.pointSize: 15
            color: "#cccccc"
        }
        Rectangle{
            id: rectNewFileName
            width: rectWithFilesList.width
            height: 30
            color: "#111111"
            radius: 8
            anchors.centerIn: parent
            TextInput{
                id: newFileName
                anchors.fill:parent
                clip: true
                font.family: "Helvetica"
                font.pointSize: 20
                color: "#dddddd"
            }
        }
        Rectangle {
            id: rectConfirmAdd
            anchors{
                bottom: parent.bottom
                bottomMargin: 2
                horizontalCenter: rectNewFileName.horizontalCenter
            }
            width:  parent.width/2
            height: 20
            color: "#363636"
            radius:  rectWithFilesList.radius
            Text{
                text: "Add"
                anchors.centerIn: parent
                color: "#dddddd"
            }
            MouseArea{
                id: addNewFileButtonInPopup
                anchors.fill: parent
                hoverEnabled: true
                onEntered:parent.color = "#444444"
                onExited:parent.color = "#363636"
                onPressed:parent.color = "#202020"
                onReleased:parent.color = "#363636"
                onClicked:
                {
                    if(fileOperator.addNewFile(newFileName.text))
                    {
                        fileList.model = fileOperator.getFileList()
                        popupForInputFileName.close()
                    }
                    else
                    {
                        textPopupAsksToEnter.text = "Error"
                        textPopupAsksToEnter.color = "#e67575"
                    }
                }
            }
        }
    }

    Popup {
        id: popupForCreateNewPassword
        anchors.centerIn: parent
        width: rectWithPasswords.width + 40
        height: 100
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        background:Rectangle{
            color: Style.mainbg
            radius: 8
            border.width: 1
            border.color: Style.maincolor
        }
        Text{
            id:textService
            anchors.left : rectNewPass.left
            width: rectWithPasswords.width/3 + 6
            anchors.bottom:  rectNewPass.top
            anchors.bottomMargin:  7
            text: "Service"
            font.family: "Helvetica"
            font.pointSize: 15
            color: "#aaaaaa"
        }
        Text{
            id: textLogin
            width: textService.width
            anchors.left : textService.right
            anchors.bottom: textService.bottom
            text: "Login"
            font.family: "Helvetica"
            font.pointSize: 15
            color: "#aaaaaa"
        }
        Text{
            id: textPassword
            anchors.left : textLogin.right
            anchors.bottom: textService.bottom
            width: textLogin.width
            text: "Password"
            font.family: "Helvetica"
            font.pointSize: 15
            color: "#aaaaaa"
        }
        Rectangle{
            id: rectNewPass
            width: rectWithPasswords.width
            height: 22
            color: "#111111"
            radius: 8
            anchors.centerIn: parent
            TextInput{
                id: newService
                anchors.left: parent.left
                anchors.leftMargin: 2
                width:  parent.width/3
                clip: true
                font.family: "Helvetica"
                font.pointSize: 15
                color: "#dddddd"
            }
            Rectangle{id: dividerServ; anchors{left:newService.right; verticalCenter: parent.verticalCenter; leftMargin: 2} width: 2; height: rectNewPass.height-4; color:Style.mainbg}
            TextInput{
                id: newLogin
                anchors.left: dividerServ.right
                anchors.leftMargin: 2
                width:  parent.width/3
                clip: true
                font.family: "Helvetica"
                font.pointSize: 15
                color: "#dddddd"
            }
            Rectangle{id: dividerServ2; anchors{left:newLogin.right; verticalCenter: parent.verticalCenter; leftMargin: 2} width: 2; height: rectNewPass.height-4; color:Style.mainbg}
            TextInput{
                id: newPassword
                anchors.left: dividerServ2.right
                anchors.leftMargin: 2
                anchors.right: parent.right
                clip: true
                font.family: "Helvetica"
                font.pointSize: 15
                color: "#dddddd"
            }
        }
        Rectangle {
            id: rectConfirmAddnewPass
            anchors{
                bottom: parent.bottom
                bottomMargin: 2
                horizontalCenter: parent.horizontalCenter
            }
            width:  parent.width/2
            height: parent.height/4
            color: "#363636"
            radius:  rectWithPasswords.radius
            Text{
                text: "Add"
                anchors.centerIn: parent
                color: "#dddddd"
            }
            MouseArea{
                id: addNewPassButtonInPopup
                anchors.fill: parent
                hoverEnabled: true
                onEntered:parent.color = "#444444"
                onExited:parent.color = "#363636"
                onPressed:parent.color = "#202020"
                onReleased:parent.color = "#363636"
                onClicked:
                {
                    fileOperator.addNewPasswordToVector(newService.text, newLogin.text, newPassword.text)
                    newService.text = ""
                    newLogin.text = ""
                    newPassword.text = ""
                    fileOperator.readToVector() ? tableOperator.setTable(fileOperator.getVector()) : textcurrentFile.text = modelData
                    popupForCreateNewPassword.close()
                }
            }
        }
    }


}



