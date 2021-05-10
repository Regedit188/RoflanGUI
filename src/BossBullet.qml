import QtQuick 2.0
import QtMultimedia 5.12

Rectangle {
    id: boss_bullet
    width: 20
    height: 10
    color: "transparent"
    NumberAnimation on x {
        from: x
        to: -700
        duration: 700
        running: true
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

        if (playerArea.x > boss_bullet.x && playerArea.x < boss_bullet.x + boss_bullet.width)
        {
            if(playerArea.y < boss_bullet.y && playerArea.y > boss_bullet.y + boss_bullet.height)
            {
                boss_bullet.destroy();
                playerArea.health -= 5;
            }
        }
   }
}
