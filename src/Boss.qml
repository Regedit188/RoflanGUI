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
        interval: 100
        running: true
        repeat: true
        property var up: true

        onTriggered:
        {
            if(up)
            {
                boss.y+=4;
                if (boss.y < 375)
                {
                    root.y = 375
                    up = false;
                }
            }
            else
            {
                boss.y-=4;
                if (root.y > 300)
                {
                    root.y = 300
                    up = true;
                }
            }
        }
    }

    onXChanged:
    {
        playerArea.bossX = boss.x
        if (playerArea.x > boss.x && playerArea.x < boss.x + boss.width)
        {
            if(playerArea.y > boss.y)
            {
                playerArea.health -= 25;
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
