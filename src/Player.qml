import QtQuick 2.0

Item {
id: root

signal dragged()
signal shot()
signal heal()
property alias color :point.color
Rectangle {

    id:point
    anchors.centerIn: parent
    width: 80
    height: 110
    color: "blue"
    opacity: 0.8

    property real yPMin: 250;
    property real yPMax: 375;
    property real runFrame: 0;
    property bool jumping: false;
    property bool runningRight: false;
    property bool runningLeft: false;
    property bool pressedRight: false;
    property bool pressedLeft: false;
    property var componentBullet: Qt.createComponent("Bullet.qml");
    property var componentPlayer: Qt.createComponent("Player.qml");
    //property var componentElements: Qt.createComponent("Elemets.qml");
    property bool isAlive: true;

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

        property real yPMaxT: 375;
        property real yVelocity: 50;
        property real yAcceleration: 0;
        property real g: -9.8;
        property real dt: interval/100;


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

        property real yPMaxT: 375;
        property real xVelocity: 20;
        property real xVelocityMax: 100;
        property real xAcceleration: 2.8;
        property real g: -9.8;
        property real dt: interval/100;

        function  checkHeal()
        {
            for (var i = 0; i < elementsList.length; i++){
                var en = elementsList[i]
                    if (root.x > en.x){
                        if(root.y > en.y){
                            en.destroy()
                            heal();
                        }
                    }
                }
        }

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
            checkHeal();

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

    function die(){
        gameInfo.text = "\nCHECK: "
        playerTexture.source = "qrc:/Cowboy/lose/lose.png";
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
        case Qt.Key_F:
            var component = Qt.createComponent("Bullet.qml")
            if (component.status === Component.Ready){
                component.createObject(root, {"x":playerArea.x+77, "y":playerArea.y})
                shot();
            }
            break;
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
