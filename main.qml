import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
import "."

Window {
    //flags: Qt.CustomizeWindowHint
    id: mainWindow
    width: 800
    height: 480
    visible: true
    //color: Style.mainbg

    RightRect{
        id: rightRect
    }


    Loader{
        id: mainLoader
        anchors{
            top: parent.top
            bottom: parent.bottom
            right:  parent.right
            left:  rightRect.right
        }
        source: "Content.qml"
    }
    StartInputKey{
        id:startKeyWindow
        visible: true
    }



}


