import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    property var enemyList: []
    id:root
    visible: true
    width: 640
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

    Timer{
        id: enemy_timer
        interval: 1300
        running: true
        repeat: true
        onTriggered: {
            var component = Qt.createComponent("Enemy.qml")
            if (component.status === Component.Ready){
                var e = component.createObject(root, {"x":510, "y":350})
                enemyList.push(e)
            }
        }
    }

    /*Timer{
        id: buller_time
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            var component = Qt.createComponent("Bullet.qml")
            if (component.status === Component.Ready){
                component.createObject(root, {"x":playerArea.x+77, "y":playerArea.y})
            }
        }
    }*/

    Player{
        id: playerArea
        x:40
        y:375
        property var health: 100;

        onHealthChanged:
        {
            /*if(playerArea.health <= 0)
            {
                playerArea.health = 0;
            }*/

            gameInfo.text = "Health: "+ playerArea.health;
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
                playerArea.dragged.connect(repaint)
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
