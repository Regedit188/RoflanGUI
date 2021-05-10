import QtQuick 2.0
import QtMultimedia 5.12

Rectangle {
    id: bullet
    width: 20
    height: 10
    color: "transparent"
    property real direction: playerArea.direction;
    NumberAnimation on x {
        from: x
        to: bullet.direction
        duration: 700
        running: true
    }

    Image {
        source: "qrc:/Cowboy/bullet/bullet.png"
        mirror: playerArea.bulletMirrored
    }

    Audio {
            id: playBullet
            source: "qrc:/sounds/shot.mp3"
            volume: 1.0
            autoLoad: true
            autoPlay: true
    }

    onXChanged: {
        if (x > 640){
            destroy()
        }

        if (bullet.x > playerArea.bossX && bullet.x < playerArea.bossX + 68)
        {
            if(bullet.y > playerArea.bossY)
            {
                playerArea.bossHealth -= 50;
                bullet.destroy()
            }
        }

        for (var i = 0; i < enemyList.length; i++){
            var en = enemyList[i]
                if (bullet.x > en.x && bullet.x < en.x + en.width){
                    if(bullet.y > en.y){
                        en.destroy()
                        playerArea.score += 50;
                        bullet.destroy()
                    }
                }
            }
        }
}
