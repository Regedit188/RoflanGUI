import QtQuick 2.0
Rectangle {
    signal score()
    signal damage()
    id: enemy
    width: 68
    height: 92
    color: "green"

    NumberAnimation on x {
        from: x
        to: -80
        duration: 1000
        running: true
    }

    onXChanged:
    {
        if (playerArea.x > enemy.x){
            if(playerArea.y > enemy.y){
                enemy.destroy();
                playerArea.health -= 25;
            }
        }
    }

    Image {
        id: alienTexture
        source: "qrc:/textures/alien/alien_1.png"
        mirror: false
        width: 68
        height: 92
    }

    Timer{
        id: alien_frame_timer
        interval: 100
        running: true
        repeat: true

        property var alienFrameNum: 1;

        onTriggered: {
            alienFrameNum  += 1;
            if(alienFrameNum > 6)
            {

                alienFrameNum = 1;

            }
            alienTexture.source = "qrc:/textures/alien/alien_" + alienFrameNum +".png"
        }
    }

}
