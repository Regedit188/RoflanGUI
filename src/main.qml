import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0

Window {
    property var enemyList: []
    property var elementsList: []
    property var decorsList: []
    property var platformList: []


    id:root
    visible: true
    width: 790
    height: 480
    title: qsTr("Cowboys against the aliens")

    Rectangle
    {
        width: 640
        height: 480
        layer.enabled: true
        Image {
            id: backgroundTexture
            source: "qrc:/textures/background/4/background.png"
            mirror: false
            width: 640
            height: 480
            clip: true
            //fillMode: Image.TileHorizontally
            z: 0
            property int position: 0
            x: -backgroundTexture.position * 10
        }
        Image {
            id: backgroundTexture2
            source: "qrc:/textures/background/4/background.png"
            mirror: false
            width: 640
            height: 480
            clip: true
            z: 0
            property int position: -64
            x: -backgroundTexture2.position * 10
        }
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

    function createPlatform(x, y){
        var component = Qt.createComponent("Platform.qml")
        var e = component.createObject(root, {"x":x + playerArea.platformDirection, "y":y})
        platformList.push(e)
    }

    function restart(){
        if(playerArea.isAlive==false){
            playerArea.isAlive = true;
            playerArea.health = 100;
            playerArea.score = 0;
            playerArea.x = 40;
            playerArea.y = 375;
            backgroundTexture.source = "qrc:/textures/background/4/background.png";
            backgroundTexture.z  = 0;
            createElement(310, 350);
        } else {
            return;
        }
    }

    function clearElements()
    {
        for (var i = 0; i < elementsList.length; i++)
        {
            var en = elementsList[i]
            en.destroy()
        }
    }

    function clearPlatform()
    {
        for (var i = 0; i < platformList.length; i++)
        {
            var en = platformList[i]
            en.destroy()
        }
    }

    function clearDecors()
    {
        for (var i = 0; i < decorsList.length; i++)
        {
            var en = decorsList[i]
            en.destroy()
        }
    }

    function clearEnemy()
    {
        for (var i = 0; i < enemyList.length; i++)
        {
            var en = enemyList[i]
            en.destroy()
        }
    }



    Player{
        id: playerArea
        x:40
        y:375
        z:9
        property var health: 1000;
        property var score: 0;
        property var isAlive: true;
        property var direction: 700;
        property var deltaX: 50;
        property var bulletMirrored: false;
        property var platformDirection: 0

        onPlatformDirectionChanged:
        {
            for (var i = 0; i < platformList.length; i++)
            {
                var en = platformList[i];
                en.x += playerArea.platformDirection;
                if(en.x <= -640)
                {
                    en.x = 1280;
                }
            }

            for (var i = 0; i < decorsList.length; i++)
            {
                var en = decorsList[i];
                en.x += playerArea.platformDirection;elementsList
            }

            for (var i = 0; i < elementsList.length; i++)
            {
                var en = elementsList[i];
                en.x += playerArea.platformDirection;
            }

            for (var i = 0; i < enemyList.length; i++)
            {
                var en = enemyList[i];
                en.x += playerArea.platformDirection;
            }

        }

        onScoreChanged:
        {
            if(playerArea.score >= 20){
                playerArea.isAlive = false;
                backgroundTexture.source = "qrc:/Cowboy/win/win.png";
                backgroundTexture.z  = 20;
                backgroundTexture.x = 0;
            }

            gameInfo.text = "Health: "+ playerArea.health;
            scoreInfo.text = "Score: "+ playerArea.score;
        }

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
                playerArea.changeR.connect(changeDirectionRight);
                playerArea.changeL.connect(changeDirectionLeft);
                
                //createDecors(210, 250);
                //createDecors(110, 120);
                //createDecors(520, 220);

                createPlatform(110, 320);
                createPlatform(310, 120);
            }

            function shoot(){
                var component = Qt.createComponent("Bullet.qml")
                if (component.status === Component.Ready){
                    component.createObject(root, {"x":playerArea.x+playerArea.deltaX, "y":playerArea.y})
                }
            }

            function damaging()
            {
                playerArea.health -= 25;
            }

            function changeDirectionRight()
            {
                playerArea.direction = 700;
                playerArea.deltaX = 50;
                playerArea.bulletMirrored = false;
                backgroundTexture.position++;
                backgroundTexture2.position++;
                //console.log("1:"+backgroundTexture.position);
                //console.log("2:"+backgroundTexture2.position);

                if(backgroundTexture.position >= 64)
                {
                    backgroundTexture.position = -64;
                }

                if(backgroundTexture2.position >= 64)
                {
                    backgroundTexture2.position = -64;
                }
            }

            function changeDirectionLeft()
            {
                playerArea.direction = -700;
                playerArea.deltaX = -77;
                playerArea.bulletMirrored = true;
                backgroundTexture.position--;
                backgroundTexture2.position--;
                //console.log("1:"+backgroundTexture.position);
                //console.log("2:"+backgroundTexture2.position);

                if(backgroundTexture.position <= -64)
                {
                    backgroundTexture.position = 64;
                }

                if(backgroundTexture2.position <= -64)
                {
                    backgroundTexture2.position = 64;
                }
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

