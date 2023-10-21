import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

ApplicationWindow {
    width: 288
    height: 288*2
    visible: true
    title: qsTr("Color Picker")

    header: ToolBar {
        background: Rectangle {
            anchors.fill: parent
            color: "#3dd465"
        }
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "Color"
                onClicked: {
                    colorPickerDialog.open();
                }
            }
            Label {
                text: "Paint"
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

    property int lastX: 0
    property int lastY: 0

    Canvas {
        id: canvas
        anchors.fill: parent

        MouseArea {
            id: area
            anchors.fill: parent
            onPressed: {
                lastX = mouseX;
                lastY = mouseY;
            }
            onPositionChanged: {
                canvas.requestPaint();
            }
        }

        onPaint: {
            let ctx = this.getContext("2d");
            ctx.lineWidth = 5; // tamaño de pincel
            ctx.fillStyle = colorRect.color; // color de relleno
            ctx.strokeStyle = colorRect.color; // color del pincel
            ctx.beginPath(); // iniciar dibujado
            ctx.moveTo(lastX, lastY); // mover pincel
            lastX = area.mouseX;
            lastY = area.mouseY;
            ctx.lineTo(lastX, lastY); // pinta línea
            ctx.stroke(); // mostrar resultado
        }

        function clear() {
            let ctx = this.getContext("2d");
            ctx.reset();
            this.requestPaint();
        }
    }

    Dialog {
        id: colorPickerDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: "Color Picker"
        ColumnLayout {
            Rectangle {
                id: colorRect
                width: 50
                height: 50
                color: Qt.rgba(sliderR.value / 255.0, sliderG.value / 255.0, sliderB.value / 255.0, 1.0)
                Layout.alignment: Qt.AlignHCenter
                radius: 50
            }
            RowLayout {
                Label {
                    text: "R"
                }
                Slider {
                    id: sliderR
                    orientation: Qt.Horizontal
                    from: 0
                    to: 255
                    value: 0
                }
            }
            RowLayout {
                Label {
                    text: "G"
                }
                Slider {
                    id: sliderG
                    orientation: Qt.Horizontal
                    from: 0
                    to: 255
                    value: 0
                }
            }
            RowLayout {
                Label {
                    text: "B"
                }
                Slider {
                    id: sliderB
                    orientation: Qt.Horizontal
                    from: 0
                    to: 255
                    value: 0
                }
            }
        }
    }
}
