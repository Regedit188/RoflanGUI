import QtQuick 2.0

Item {
id: root

signal dragged()
property alias color :point.color
Rectangle {
    id:point
    anchors.centerIn: parent
    width: 60
    height: 60
    color: "blue"
    opacity: 0.8

    Image {
        source: "qrc:/Cowboy/stand/stand.png"
    }

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
    function bla(){
        if (root.y > 410){
            root.y = 410
        }
        else if (root.y < 350){
            root.y = 350
        }
    }
    Keys.onPressed: {
        switch(event.key) {
        case Qt.Key_Left:
            root.x-=5;
            dragged();
            break;
        case Qt.Key_Right:
            root.x+=5;
            dragged();
            break;
        case Qt.Key_Up:
            root.y-=5;
            bla();
            dragged();
            break;
        case Qt.Key_Down:
            root.y+=5;
            bla();
            dragged();
            break;
        }
    }

    focus: true;
}}
