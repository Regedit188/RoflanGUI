import QtQuick 2.0

Item {
id: root

signal dragged()
property alias color :point.color
Rectangle {
    id:point
    anchors.centerIn: parent
    width: 80
    height: 110
    color: "blue"
    opacity: 0.8

    property var yPMin: 250;
    property var yPMax: 375;
    property var runFrame: 0;
    property var jumping: false;
    property var runningRight: false;
    property var runningLeft: false;
    property var pressedRight: false;
    property var pressedLeft: false;
    property var componentBullet: Qt.createComponent("Bullet.qml");

    onXChanged:
    {
        if(playerArea.health <= 0)
        {
            playerTexture.source = "qrc:/Cowboy/lose/lose.png";
        }
    }



    Image {
        id: playerTexture
        source: "qrc:/Cowboy/stand/stand.png"
        mirror: false
    }

    Timer{
        id: jump_timer
        interval: 10
        running: false
        repeat: true

        property var yPMaxT: 375;
        property var yVelocity: 50;
        property var yAcceleration: 0;
        property var g: -9.8;
        property var dt: interval/100;


        onTriggered: {
            if(point.pressedRight == true)
            {
                root.x += 2;
            }

            if(point.pressedLeft == true)
            {
                root.x -= 2;
            }

            if(root.y == yPMaxT)//on ground
            {
                yVelocity = 50;
                yAcceleration = g;
            }
            root.y -= yVelocity*dt + 0.5*yAcceleration*dt*dt;
            yVelocity += yAcceleration*dt;
            if(root.y > yPMaxT)
            {
                root.y  = yPMaxT;
                running = false;
            }
        }
    }

    Timer{
        id: run_timer
        interval: 10
        running: false
        repeat: true

        property var yPMaxT: 375;
        property var xVelocity: 20;
        property var xVelocityMax: 100;
        property var xAcceleration: 2.8;
        property var g: -9.8;
        property var dt: interval/100;

        onTriggered: {
            if(xVelocity > xVelocityMax)
            {
               xVelocity = xVelocityMax;
            }

            if(point.pressedRight == false && point.pressedLeft == false)
            {
                //playerTexture.source = "qrc:/Cowboy/stand/stand.png";
                xVelocity = 20;
                running: false;
            }

            if(point.pressedRight == true)
            {
                root.x += xVelocity*dt + 0.5*xAcceleration*dt*dt;
            }
            else if(point.pressedLeft == true)
            {
                root.x -= xVelocity*dt + 0.5*xAcceleration*dt*dt;
            }
            xVelocity += xAcceleration*dt;

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

    function playerRun()
    {
        if(run_timer.running == false)
        {
            run_timer.running = true;
        }
    }

    Keys.onPressed: {
        switch(event.key) {
        case Qt.Key_Left:
            point.pressedLeft = true;
            playerTexture.mirror = true;
            if(!jumping)
            {
                changeRunRightFrame();
                playerRun();
                dragged();
            }


            break;
        case Qt.Key_Right:
            point.pressedRight = true;
            playerTexture.mirror = false;
            if(!jumping)
            {
                changeRunRightFrame();
                playerRun();
                dragged();
            }
            break;
        case Qt.Key_Up:
            playerJump();
            bla();
            dragged();
            break;
        /*case Qt.Key_F:
            var component = Qt.createComponent("Bullet.qml")
            if (componentBullet.status === Component.Ready){
                componentBullet.createObject(root, {"x":playerArea.x+77, "y":playerArea.y})
                dragged();
            }
            break;*/
        }
    }

    Keys.onReleased:
    {
        switch(event.key) {
        case Qt.Key_Left:
            point.pressedLeft = false;
            break;
        case Qt.Key_Right:
            point.pressedRight = false;
            break;
        }
    }

    focus: true;
}}