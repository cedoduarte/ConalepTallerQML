import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    width: 288
    height: 288*2
    visible: true
    title: qsTr("Ejemplo Drawer")

    header: ToolBar {
        background: Rectangle {
            anchors.fill: parent
            color: "#3dd465"
        }
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "..."
                onClicked: {
                    drawer.open();
                }
            }
            Label {
                text: "Ejemplo Drawer"
                elide: Label.ElideRight
                font.pointSize: 12
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                text: "x"
                onClicked: {
                    Qt.quit();
                }
            }
        }
    }

    Rectangle {
        anchors.centerIn: parent
        color: "#3dd465"
        width: 100
        height: 100
        radius: 10
        RotationAnimation on rotation {
            loops: Animation.Infinite
            from: 0
            to: 360
            duration: 800
        }
    }

    Drawer {
        id: drawer
        y: header.height
        width: root.width * 0.6
        height: root.height - root.header.height
        ListView {
            anchors.fill: parent
            clip: true
            spacing: 2
            model: ["Usuario","Registro","Configuración","Resultados","Ver perfil"]
            delegate: Rectangle {
                id: rectItem
                color: "transparent"
                width: parent.width
                height: 50
                Text {
                    id: txt
                    text: modelData
                    font.pointSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        rectItem.color = "#3dd465";
                        txt.color = "white";
                    }
                    onExited: {
                        rectItem.color = "transparent";
                        txt.color = "black";
                    }
                }
            }
        }
    }

    Rectangle {
        id: sliderPanel
        width: parent.width
        height: parent.height - header.height
        x: 0
        y: header.height
        color: "white"
        radius: 10
        Rectangle {
            id: holdRect
            color: "transparent"
            width: parent.width
            height: 25
            radius: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            Rectangle {
                color: "gray"
                radius: 10
                width: 40
                height: 5
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        function isUnderMouse(x, y) {
            return x >= this.x && y >= this.y && (y <= this.y + holdRect.height);
        }

        Rectangle {
            id: rectContainer
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: holdRect.bottom
            height: parent.height

            GridView {
                id: gridview
                clip: true
                anchors.fill: parent
                cellWidth: 50
                cellHeight: 50
                anchors.leftMargin: 20
                model: 40
                delegate: Rectangle {
                    color: "#3dd465"
                    width: gridview.cellWidth*0.9
                    height: gridview.cellHeight*0.9
                    radius: 5
                    Text {
                        anchors.centerIn: parent
                        text: modelData
                        font.pointSize: 15
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        property bool slidePanel: false
        onPressed: {
            slidePanel = sliderPanel.isUnderMouse(mouseX, mouseY);
        }
        onReleased: {
            slidePanel = false;
        }
        onPositionChanged: {
            if (slidePanel) {
                if (mouseY >= header.height && mouseY <= root.height - 80) {
                    sliderPanel.y = mouseY;
                }
            }
        }
    }
}
