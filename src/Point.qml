import QtQuick 2.0

Item {
id: root

signal dragged()
property alias color :point.color
Rectangle {
    id:point
    anchors.centerIn: parent
    width: 20
    height: 20

    opacity: 0.2

    MouseArea {
        anchors.fill: parent
        drag.target: root
        onPositionChanged: {
            if(drag.active) {
                dragged()
            }
        }
        onClicked: point.focus=true;
    }
    focus: true;
}}
