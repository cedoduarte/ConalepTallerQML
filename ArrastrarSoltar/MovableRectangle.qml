import QtQuick

Rectangle {
    id: rectItem

    property bool canMove: false

    function isUnderMouse(mouseX, mouseY) {
        return (mouseX >= rectItem.x && mouseX <= (rectItem.x + rectItem.width))
               && (mouseY >= rectItem.y && mouseY <= (rectItem.y + rectItem.height));
    }

    function moveIfCan(x, y) {
        if (canMove) {
            rectItem.x = x - rectItem.width / 2;
            rectItem.y = y - rectItem.height / 2;
        }
    }

    function setCanMoveIf(x, y) {
        canMove = isUnderMouse(x, y);
        return canMove;
    }
}
