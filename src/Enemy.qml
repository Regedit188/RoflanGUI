import QtQuick 2.0

Rectangle {
    width: 60
    height: 60
    color: "green"
    NumberAnimation on x {
        from: x
        to: -60
        duration: 1000
        running: true
    }

}
