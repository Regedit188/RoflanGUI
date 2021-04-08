import QtQuick 2.0

Rectangle {
    id: bullet
    width: 20
    height: 10
    color: "transparent"
    NumberAnimation on x {
        from: x
        to: 700
        duration: 700
        running: true
    }

    Image {
        source: "qrc:/Cowboy/bullet/bullet.png"
    }

    onXChanged: {
        if (x > 640){
            destroy()
        }
        for (var i = 0; i < enemyList.length; i++){
            var en = enemyList[i]
                if (bullet.x > en.x){
                    if(bullet.y > en.y){
                        en.destroy()
                        playerArea.score += 10;
                        bullet.destroy()
                    }
                }
            }
        }
}
