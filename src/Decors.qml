  import QtQuick 2.0

Rectangle {
    id: decors
    width: 68
    height: 92
    color: "orange"
    property var idDec: 1;
    Image {
        id: elementTexture
        source: "qrc:/textures/decors/Decor" + 4 + ".png"
        width: 68
        height: 92
    }




}
