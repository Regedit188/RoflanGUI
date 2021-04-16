import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    property var enemyList: []
    property var elementsList: []
    property var decorsList: []

    id:root
    visible: true
    width: 790
    height: 480
    title: qsTr("Cowboys against the aliens")

    Image {
        id: backgroundTexture
        source: "qrc:/textures/background/4/background.png"
        mirror: false
        width: 640
        height: 480
        z: 0
    }

    Text {
        id: gameInfo
        text: qsTr("Health: 100")
        leftPadding: 700
        topPadding: 50
    }

    Text {
        id: scoreInfo
        text: qsTr("Score: 0")
        leftPadding: 700
        topPadding: 60
    }


    Timer{
        id: enemy_timer
        interval: 1300
        running: true
        repeat: true
        onTriggered: {
//            if(playerArea.isAlive == false)
//            {
//                running = false;
//            }

            var component = Qt.createComponent("Enemy.qml")
            if (component.status === Component.Ready && playerArea.isAlive){
                var e = component.createObject(root, {"x":510, "y":350})
                enemyList.push(e)
            }
        }
    }



    Rectangle {
               //anchors.centerIn: parent
               id: buttonQuit
               x: 5
               y: 3
               width: 50;
               height: 40;
               radius: 5;
               color: "lightgray"
               z:11;
               
               Text { 
                   anchors.centerIn: buttonQuit;
                   text: "Quit";
                   color: "black"
               }

               MouseArea {
                   anchors.fill: parent
                   onClicked: Qt.quit()
               }
       }

    Rectangle {

               id: buttonRestart
               x: 62
               y: 3
               width: 90;
               height: 40;
               radius: 5;
               color: "lightgray"

               z:11;

               Text {
                   anchors.centerIn: buttonRestart;
                   text: "Restart game";
                   color: "black"
               }

               MouseArea {
                   anchors.fill: parent
                   onClicked: {
                        restart()
                   }

               }
       }
           


    function createElement(x, y){
        var component = Qt.createComponent("Elements.qml")
        var e = component.createObject(root, {"x":x, "y":y})
        elementsList.push(e)
    }

    function createDecors(x, y, idDec2){
        var component = Qt.createComponent("Decors.qml")
        var e = component.createObject(root, {"x":x, "y":y})
        e.idDec = idDec2;
        decorsList.push(e)
    }

    function restart(){
       if(playerArea.isAlive== false){
            playerArea.isAlive = true;
            playerArea.health = 100;
            playerArea.score = 0;
            backgroundTexture.source = "qrc:/textures/background/4/background.png";
            backgroundTexture.z  = 0;
        }
    }




    Player{
        id: playerArea
        x:40
        y:375
        property var health: 100;
        property var score: 0;
        property var isAlive: true;

        onHealthChanged:
        {

            if(playerArea.health <= 0)
            {
                playerArea.isAlive = false;
                backgroundTexture.source = "qrc:/Cowboy/lose/loseScreen.png";
                backgroundTexture.z  = 10;


                //playerArea.destroy();
                //playerTexture.source = "qrc:/Cowboy/lose/lose.png";

            }


            gameInfo.text = "Health: "+ playerArea.health;
            scoreInfo.text = "Score: "+ playerArea.score;
        }
    }


    Rectangle{
        id: player
        color: "blue"

        Canvas {
            id: canvas2
            anchors.fill: parent
            onPaint: {
                var ctx = canvas2.getContext('2d');
                ctx.moveTo(playerArea.x, playerArea.y);
                ctx.stroke();
            }
            Component.onCompleted: {
                createElement(310, 350);

                playerArea.dragged.connect(repaint);
                playerArea.shot.connect(shoot);
                playerArea.heal.connect(healing);
                
                createDecors(210, 250);
                createDecors(110, 120);
                createDecors(520, 220);
            }

            function shoot(){
                var component = Qt.createComponent("Bullet.qml")
                if (component.status === Component.Ready){
                    component.createObject(root, {"x":playerArea.x+77, "y":playerArea.y})
                }
            }

            function damaging()
            {
                playerArea.health -= 25;
            }

            function scoring()
            {
                playerArea.score += 10;
            }

            function healing()
            {
                playerArea.health += 50;
            }

            function repaint() {
                var ctx = getContext("2d");
                ctx.clearRect(0, 0, canvas2.width, canvas2.height);
                ctx.beginPath();
                requestPaint();
            }
        }
    }

    Point {
        id: pointB
        x: 640
        y: 440
    }


    Point {
        id: pointA
        x: 0
        y: 440
    }


    Item {
        anchors.fill: parent


        Canvas {
            id: canvas
            anchors.fill: parent
            onPaint: {
                var ctx = canvas.getContext('2d');
                ctx.moveTo(pointA.x, pointA.y);
                ctx.lineTo(pointB.x, pointB.y);
                ctx.stroke();
            }
            Component.onCompleted: {
                pointA.dragged.connect(repaint)
                pointB.dragged.connect(repaint)
            }

            function repaint() {
                var ctx = getContext("2d");
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.beginPath();
                requestPaint()
            }
        }
    }
}

