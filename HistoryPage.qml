import QtQuick 2.0

Rectangle {
    id: historyPage
    anchors.fill:  parent
    color: Style.mainbg
    Rectangle{
        color: "#111111"
        radius: 8
        anchors {
            margins: 40
            fill: parent
        }
        ListView{
            id: historyList
            anchors.fill: parent
            model: fileOperator.getLOG()
            delegate: Text {
                font.family: "Helvetica"
                font.pointSize: 12
                color: Style.maincolor
                text: modelData

            }
            clip: true
        }
    }
}
