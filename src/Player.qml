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

    property var yPMin: 250;
    property var yPMax: 375;
    property var runFrame: 0;
    property var jumping: false;

    Image {
        id: playerTexture
        source: "qrc:/Cowboy/stand/stand.png"
        mirror: false
    }

    Timer{
        id: jump_timer
        interval: 100
        running: false
        repeat: true

        property var yPMaxT: 375;
        property var yVelocity: 50;
        property var yAcceleration: 0;
        property var g: -9.8;

        onTriggered: {
            if(root.y == yPMaxT)//on ground
            {
                yVelocity = 50;
                yAcceleration = g;
            }
            root.y -= yVelocity + 0.5*yAcceleration;
            yVelocity += yAcceleration;
            if(root.y > yPMaxT)
            {
                root.y  = yPMaxT;
                running = false;
            }
        }
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
        if (root.y > yPMax){
            root.y = yPMax
        }
        else if (root.y < yPMin){
            root.y = yPMin
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

    function playerJump()
    {
        if(!jumping)
        {
            jumping = true;
            jump_timer.running = true;
            playerTexture.source = "qrc:/Cowboy/jump/jump.png";

        }
        if(jump_timer.running == false)
        {
            jumping = false;
            playerTexture.source = "qrc:/Cowboy/stand/stand.png";
            root.y = yPMax;
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
            playerJump();
            //root.y-=5;
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
