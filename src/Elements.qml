  import QtQuick 2.0

Rectangle {
    id: elemets
    width: 68
    height: 92
    color: "orange"

    onXChanged:
    {
        if (playerArea.x > elemets.x){
            if(playerArea.y > elemets.y){
                elemets.destroy();
                playerArea.health += 5;
                playerArea.score += 15;
            }
        }
    }

    Image {
        id: elementTexture
        source: "qrc:/textures/elements/bonus1.png"
        width: 68
        height: 92
    }
    property var bonusFrameNum: 1;

//    Timer{
//        id: elements_frame_timer
//        interval: 1600
//        running: true
//        repeat: true

//        property var bonusFrameNum: 1;

//        onTriggered: {
//            bonusFrameNum  += 1;
//            if(bonusFrameNum > 4)
//            {
//                bonusFrameNum = 1;
//            }
//            elementTexture.source = "qrc:/textures/elements/bonus" + bonusFrameNum +".png"
//        }
//    }

}
