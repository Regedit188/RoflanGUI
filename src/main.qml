import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    property var enemyList: []
    property var elementsList: []
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
            var component = Qt.createComponent("Enemy.qml")
            if (component.status === Component.Ready && playerArea.isAlive){
                var e = component.createObject(root, {"x":510, "y":350})
                enemyList.push(e)
            }
        }
    }

    function createElement(x, y){
        var component = Qt.createComponent("Elements.qml")
        var e = component.createObject(root, {"x":x, "y":y})
        elementsList.push(e)
    }

    Player{
        id: playerArea
        x:40
        y:375
        property real health: 100;
        property real score: 0;
        property bool isAlive: true;

        onHealthChanged:
        {
            if(playerArea.health <= 0)
            {
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
                playerArea.dragged.connect(repaint)
                playerArea.shot.connect(shoot)
            }
            function shoot(){
                var component = Qt.createComponent("Bullet.qml")
                if (component.status === Component.Ready){
                    component.createObject(root, {"x":playerArea.x+77, "y":playerArea.y})
                }
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
        id: pointA
        x: 0
        y: 440
    }

    Point {
        id: pointB
        x: 640
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
