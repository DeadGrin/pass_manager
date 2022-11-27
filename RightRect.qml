import QtQuick 2.0

Rectangle{
    id: rightRect
    anchors{
        left: parent.left
        top: parent.top
        bottom: parent.bottom
    }
    width: 60
    color: Style.mainbg

    Image{
        id: fileBtnIcon
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            margins: 25
        }
        width: 40
        fillMode: Image.PreserveAspectFit
        source: ( appManager.files ? "qrc:/assets/fileIconActive.png" : "qrc:/assets/fileIcon.png"  )
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
            fbtr.color = "#aaaaaa"
            }
            onExited: {
            fbtr.color = Style.maincolor
            }
            onClicked: {

                mainLoader.source = "FilesPage.qml"
                appManager.setfiles(true)
                appManager.sethistory(false)
                appManager.setsettings(false) 
            }
        }
    }

    Image{
        id: historyBtnIcon
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: fileBtnIcon.bottom
            margins: 25
        }
        smooth: true
        width: 40
        fillMode: Image.PreserveAspectFit
        source: ( appManager.history ? "qrc:/assets/historyIconActive.png" : "qrc:/assets/historyIcon.png"  )
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
            hbtr.color = "#aaaaaa"
            }
            onExited: {
            hbtr.color = Style.maincolor
            }
            onClicked: {
                mainLoader.source = "HistoryPage.qml"
                appManager.setfiles(false)
                appManager.setsettings(false)
                appManager.sethistory(true)
            }
        }
    }


    Image{
        id: settingsBtnIcon
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: historyBtnIcon.bottom
            margins: 25
        }
        width: 40
        fillMode: Image.PreserveAspectFit
        source: ( appManager.settings ? "qrc:/assets/settingsIconActive.png" : "qrc:/assets/settingsIcon.png"  )
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
            sbtr.color = "#aaaaaa"
            }
            onExited: {
            sbtr.color = Style.maincolor
            }
            onClicked: {
                mainLoader.source = "SettingsPage.qml"
                appManager.setfiles(false)
                appManager.sethistory(false)
                appManager.setsettings(true)
            }
        }
    }

    Rectangle   {
        id: fbtr
        color : Style.maincolor
        height : 1
        anchors{
            top: fileBtnIcon.bottom
            left: parent.left
            right: parent.right
            topMargin: 10
        }
    }
    Rectangle   {
        id: hbtr
        color : Style.maincolor
        height : 1
        anchors{
            top: historyBtnIcon.bottom
            left: parent.left
            right: parent.right
            topMargin: 10
        }
    }
    Rectangle   {
        id: sbtr
        color : Style.maincolor
        height : 1
        anchors{
            top: settingsBtnIcon.bottom
            left: parent.left
            right: parent.right
            topMargin: 10

        }
    }

}
