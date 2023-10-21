import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: root
    width: 288
    height: 288*2
    visible: true
    title: qsTr("Animación curva")
    background: Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Rectangle {
        id: circleItem
        width: 50
        height: 50
        radius: 50
        color: "red"
        x: 0
        y: 0
        NumberAnimation on x {
            from: 0
            to: 200
            duration: 1000
            loops: Animation.Infinite
        }
    }

    Rectangle {
        id: rectItem
        color: "green"
        width: 100
        height: 100
        x: 30
        y: 100
        RotationAnimation on rotation {
            loops: Animation.Infinite
            from: 0
            to: 360
        }
    }

    Rectangle {
        id: rectItem2
        width: 50
        height: 50
        x: 0
        y: 300

        property double dx: 1.0
        property double dy: 0.5
        readonly property double ay: 0.5
        property int colorIndex: 0
        readonly property var colorList: ["red","green","blue","cyan","yellow"]
        color: colorList[colorIndex]

        NumberAnimation on colorIndex {
            from: 0
            to: 4
            duration: 1000
            loops: Animation.Infinite
        }

        RotationAnimation on rotation {
            loops: Animation.Infinite
            from: 0
            to: 360
        }

        function move() {
            x += dx;
            y += dy;
            dy += ay;
        }

        function checkLimits() {
            if ((x + width) >= root.width || x <= 0) {
                dx = -dx;
            }
            if ((y + height) >= root.height) {
                dy = -dy;
            }
        }
    }

    Timer {
        interval: 50
        repeat: true
        running: true
        onTriggered: {
            rectItem2.move();
            rectItem2.checkLimits();
        }
    }
}
