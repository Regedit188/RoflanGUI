import QtQuick 2.0

Rectangle {
    width: 68
    height: 92
    color: "green"
    NumberAnimation on x {
        from: x
        to: -60
        duration: 1000
        running: true
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
