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

    property var runFrame: 0;

    Image {
        id: playerTexture
        source: "qrc:/Cowboy/stand/stand.png"
        mirror: false
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
        if (root.y > 375){
            root.y = 375
        }
        else if (root.y < 350){
            root.y = 350
        }
    }

    function changeRunRightFrame()
    {
        if(runFrame == 0)
        {
            playerTexture.source = "qrc:/Cowboy/walk/walk1.png";
            runFrame = 1;
        }
        else
        {
            playerTexture.source = "qrc:/Cowboy/walk/walk2.png";
            runFrame = 0;
        }
    }

    Keys.onPressed: {
        switch(event.key) {
        case Qt.Key_Left:
            playerTexture.mirror = true;
            changeRunRightFrame();
            root.x-=5;            
            dragged();
            break;
        case Qt.Key_Right:
            playerTexture.mirror = false;
            changeRunRightFrame();
            root.x+=5;
            dragged();
            break;
        case Qt.Key_Up:
            root.y-=5;
            bla();
            playerTexture.source = "qrc:/Cowboy/jump/jump.png";
            dragged();
            break;
        case Qt.Key_Down:
            root.y+=5;
            bla();
            playerTexture.source = "qrc:/Cowboy/stand/stand.png";
            dragged();
            break;
        }
    }

    focus: true;
}}
