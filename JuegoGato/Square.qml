import QtQuick

Rectangle {
    id: rectItem
    color: "white"
    width: 80
    height: 80
    border.width: 1
    border.color: "black"

    signal markedo()

    function isMarked() {
        return txto.visible || txtx.visible;
    }

    function marko() {
        txto.visible = true;
        this.markedo();
    }

    function markx() {
        txtx.visible = true;
    }

    function unmark() {
        txto.visible = false;
        txtx.visible = false;
    }

    Text {
        id: txto
        text: "O"
        visible: false
        anchors.centerIn: parent
        font.pointSize: 50
    }
    Text {
        id: txtx
        text: "X"
        visible: false
        anchors.centerIn: parent
        font.pointSize: 50
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (!isMarked()) {
                marko();
            }
        }
    }
}
