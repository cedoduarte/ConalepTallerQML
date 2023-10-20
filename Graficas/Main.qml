import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    width: 288
    height: 288*2
    visible: true
    title: qsTr("Gráficas")

    header: ToolBar {
        background: Rectangle {
            anchors.fill: parent
            color: "#3dd465"
        }
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: "<"
                onClicked: {
                    stackview.clear();
                }
            }
            Label {
                text: "Gráficas"
                elide: Label.ElideRight
                font.pointSize: 12
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                text: "..."
                onClicked: {
                    menu.open();
                }
            }
        }
    }

    QtObject {
        id: menuOption
        readonly property int plot1: 1
        readonly property int plot2: 2
        readonly property int plot3: 3
        readonly property int plot4: 4
    }

    property var options: [
        { value: menuOption.plot1, viewValue: "Gráfica 1" },
        { value: menuOption.plot2, viewValue: "Gráfica 2" },
        { value: menuOption.plot3, viewValue: "Gráfica 3" },
        { value: menuOption.plot4, viewValue: "Gráfica 4" }
    ]

    Menu {
        id: menu
        width: parent.width
        height: parent.height
        contentItem: ListView {
            clip: true
            anchors.fill: parent
            model: options
            delegate: Rectangle {
                id: rectItem
                width: parent.width
                height: 50
                color: "transparent"
                Text {
                    id: txt
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: modelData.viewValue
                    color: "black"
                    font.pointSize: 12
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        menu.close();
                        switch (modelData.value) {
                        case menuOption.plot1:
                            stackview.clearPush(plot1);
                            break;
                        case menuOption.plot2:
                            stackview.clearPush(plot2);
                            break;
                        case menuOption.plot3:
                            stackview.clearPush(plot3);
                            break;
                        case menuOption.plot4:
                            stackview.clearPush(plot4);
                            break;
                        }
                    }
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

    StackView {
        id: stackview
        anchors.fill: parent
        popEnter: null
        popExit: null
        pushEnter: null
        pushExit: null
        replaceEnter: null
        replaceExit: null

        function clearPush(page) {
            this.clear();
            this.push(page);
        }
    }

    Component {
        id: plot1
        Plot1 {}
    }

    Component {
        id: plot2
        Plot2 {}
    }

    Component {
        id: plot3
        Plot3 {}
    }

    Component {
        id: plot4
        Plot4 {}
    }
}
