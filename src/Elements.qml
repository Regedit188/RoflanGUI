  import QtQuick 2.0

Rectangle {
    id: elemets
    width: 68
    height: 92
    color: "orange"

    Image {
        id: elementTexture
        source: "qrc:/textures/elements/bonus1.png"
        width: 68
        height: 92
    }
    property real bonusFrameNum: 1;

}
