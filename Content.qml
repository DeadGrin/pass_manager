import QtQuick 2.0

Rectangle {
    id: content

    anchors{
        top: parent.top
        bottom: parent.bottom
    }

    width: parent.width - rightRect.width
    height: parent.height
    color: "#232323"//Style.mainbg


}
