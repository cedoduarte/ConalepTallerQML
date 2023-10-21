import QtQuick
import QtQuick.Controls

ApplicationWindow {
    width: 288
    height: 288*2
    visible: true
    title: qsTr("Hello World")

    property var itemList: [rectItem, circleItem, rectItem2, circleItem2, rectItem3, circleItem3]

    MouseArea {
        anchors.fill: parent

        MovableRectangle {
            x: 0
            y: 0
            id: rectItem
            width: 50
            height: 50
            color: "red"
        }

        MovableRectangle {
            x: 70
            y: 0
            id: circleItem
            width: 50
            height: 50
            color: "green"
            radius: 50
        }

        MovableRectangle {
            x: 140
            y: 0
            id: rectItem2
            width: 80
            height: 80
            color: "orange"
        }

        MovableRectangle {
            x: 0
            y: 100
            id: circleItem2
            width: 80
            height: 80
            color: "blue"
            radius: 50
        }

        MovableRectangle {
            x: 100
            y: 100
            id: rectItem3
            width: 60
            height: 60
            color: "brown"
        }

        MovableRectangle {
            x: 0
            y: 300
            id: circleItem3
            width: 30
            height: 30
            color: "cyan"
            radius: 50
        }

        onPressed: {
            let canMoveCount = 0;
            for (let ia = 0; ia < itemList.length; ia++) {
                if (itemList[ia].setCanMoveIf(mouseX, mouseY)) {
                    canMoveCount++;
                }
            }
            if (canMoveCount > 1) {
                for (let ib = 0; ib < itemList.length; ib++) {
                    itemList[ib].canMove = false;
                }
                itemList[0].canMove = true;
            }
        }
        onReleased: {
            for (let ia = 0; ia < itemList.length; ia++) {
                itemList[ia].canMove = false;
            }
        }

        onPositionChanged: {
            for (let ia = 0; ia < itemList.length; ia++) {
                itemList[ia].moveIfCan(mouseX, mouseY);
            }
        }
    }
}
