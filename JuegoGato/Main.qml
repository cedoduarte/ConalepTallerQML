import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.juegogato

ApplicationWindow {
    width: 288
    height: 288*2
    visible: true
    title: qsTr("Juego Gato")

    property var squares: [square1,square2,square3,square4,square5,square6,square7,square8,square9];

    header: ToolBar {
        background: Rectangle {
            anchors.fill: parent
            color: "#3dd465"
        }
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "Nuevo"
                onClicked: {
                    for (let i = 0; i < squares.length; i++) {
                        squares[i].unmark();
                    }
                }
            }
            Label {
                text: "Juego Gato"
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

    GridLayout {
        anchors.fill: parent
        rows: 3
        columns: 3
        columnSpacing: 0
        rowSpacing: 0
        Square {
            id: square1
            Layout.fillWidth: true
            Layout.fillHeight: true
            onMarkedo: {
                markRandomSquare();
            }
        }
        Square {
            id: square2
            Layout.fillWidth: true
            Layout.fillHeight: true
            onMarkedo: {
                markRandomSquare();
            }
        }
        Square {
            id: square3
            Layout.fillWidth: true
            Layout.fillHeight: true
            onMarkedo: {
                markRandomSquare();
            }
        }
        Square {
            id: square4
            Layout.fillWidth: true
            Layout.fillHeight: true
            onMarkedo: {
                markRandomSquare();
            }
        }
        Square {
            id: square5
            Layout.fillWidth: true
            Layout.fillHeight: true
            onMarkedo: {
                markRandomSquare();
            }
        }
        Square {
            id: square6
            Layout.fillWidth: true
            Layout.fillHeight: true
            onMarkedo: {
                markRandomSquare();
            }
        }
        Square {
            id: square7
            Layout.fillWidth: true
            Layout.fillHeight: true
            onMarkedo: {
                markRandomSquare();
            }
        }
        Square {
            id: square8
            Layout.fillWidth: true
            Layout.fillHeight: true
            onMarkedo: {
                markRandomSquare();
            }
        }
        Square {
            id: square9
            Layout.fillWidth: true
            Layout.fillHeight: true
            onMarkedo: {
                markRandomSquare();
            }
        }
    }

    JuegoUtil {
        id: util
    }

    function markRandomSquare() {
        let randomIndex = util.getRandom(0, squares.length);
        let attempts = 1; // intentos
        while (squares[randomIndex].isMarked()) {
            randomIndex = util.getRandom(0, squares.length);
            attempts++;
            if (attempts > 1000) {
                return;
            }
        }
        squares[randomIndex].markx();
    }
}
