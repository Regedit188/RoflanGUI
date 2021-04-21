  import QtQuick 2.0

Rectangle {
    id: enemy
    width: 68
    height: 92
    color: "transparent"
    NumberAnimation on x {
        from: x
        to: -80
        duration: 1000
        running: false
    }

    onXChanged:
    {
        if (playerArea.x > enemy.x && playerArea.x < enemy.x + enemy.width){
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

        property real alienFrameNum: 1;

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
