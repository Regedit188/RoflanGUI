import QtQuick 2.0

import QtQuick 2.0
import QtQml 2.12

Rectangle {
    id: boss
    width: 68
    height: 92
    color: "transparent"
    property var health: 100
    z:0

    onYChanged:
    {
        playerArea.bossY = boss.y
        playerArea.bossX = boss.x
        if (playerArea.x > boss.x && playerArea.x < boss.x + boss.width)
        {
            if(playerArea.y > boss.y && playerArea.y < boss.y + boss.height)
            {
                playerArea.health -= 25;
            }
        }
    }

    Timer
    {
        id: boss_shooting
        interval: 1000
        running: true
        repeat: true
        onTriggered:
        {
            var component = Qt.createComponent("BossBullet.qml")
            if (component.status === Component.Ready && playerArea.isAlive)
            {
                var e = component.createObject(root, {"x":boss.x, "y":boss.y})
            }
        }
    }

    Timer
    {
        id: boss_moving_timer
        interval: 50
        running: true
        repeat: true
        property var up: true

        onTriggered:
        {
            if(boss.y < 50)
            {
                up = true;
            }
            else if(boss.y > 375)
            {
                up = false;
            }

            if(up)
            {

                boss.y+=4;
                playerArea.bossY = boss.y
                if (boss.y > 375)
                {
                    boss.y = 375
                    up = false;
                }
            }
            else
            {
                boss.y-=4;
                playerArea.bossY = boss.y
                if (root.y < 50)
                {
                    boss.y = 50
                    up = true;
                }
            }
        }
    }


    Image {
        id: bossTexture
        source: "qrc:/textures/boss/predator.png"
        mirror: true
        width: 68
        height: 92
    }
}
