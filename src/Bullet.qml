import QtQuick 2.0

Rectangle {
    id: bullet
    width: 10
    height: 10
    color: "black"
    NumberAnimation on x {
        from: x
        to: 700
        duration: 700
        running: true
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
                        bullet.destroy()
                    }
                }
            }
        }
}
