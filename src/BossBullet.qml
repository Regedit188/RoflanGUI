import QtQuick 2.0
import QtMultimedia 5.12

Rectangle {
    id: boss_bullet
    width: 30
    height: 20
    color: "transparent"
    NumberAnimation on x {
        from: x
        to: -700
        duration: 700
        running: true
    }
    Audio {
            id: playBullet
            source: "qrc:/sounds/bossPredatorShot.mp3"
            volume: 1.0
            autoLoad: true
            autoPlay: true
    }

    Image {
        source: "qrc:/textures/boss/fire.png"
        mirror: true
    }


    onXChanged:
    {
        if (x <= -700)
        {
            destroy()
        }

        if (playerArea.x > boss_bullet.x && playerArea.x + playerArea.width < boss_bullet.x)
        {
            if(playerArea.y > boss_bullet.y && playerArea.y + playerArea.height < boss_bullet.y)
            {
                boss_bullet.destroy();
                playerArea.health -= 50;
            }
        }
   }
}
