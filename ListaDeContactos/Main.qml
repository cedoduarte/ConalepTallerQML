import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage

ApplicationWindow {
    width: 288
    height: 288*2
    visible: true
    title: qsTr("Lista de contactos")

    header: ToolBar {
        background: Rectangle {
            anchors.fill: parent
            color : "#305fab"
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
                text: "Lista de contactos"
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

    property var db: LocalStorage.openDatabaseSync("ListaDeContactos2", "1.0", "ListaDeContactos", 1000000)

    Component.onCompleted: {
        try {
            db.transaction(tx => {
                tx.executeSql("CREATE TABLE IF NOT EXISTS contact(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(256) NOT NULL, email VARCHAR(256) UNIQUE NOT NULL, phoneNumber VARCHAR(256) UNIQUE NOT NULL)");
            })
        } catch (err) {
            console.log("Error creating table in database: " + err);
        };
    }


    QtObject {
        id: menuOption
        readonly property int addContact: 1
        readonly property int deleteContact: 2
        readonly property int editContact: 3
        readonly property int showContactList: 4
    }

    property var options: [
        { value: menuOption.addContact, viewValue: "Agregar contacto" },
        { value: menuOption.deleteContact, viewValue: "Eliminar contacto" },
        { value: menuOption.editContact, viewValue: "Editar contacto" },
        { value: menuOption.showContactList, viewValue: "Ver lista de contactos" }
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
                        case menuOption.addContact:
                            stackview.clearPush(addContact);
                            break;
                        case menuOption.deleteContact:
                            stackview.clearPush(deleteContact);
                            break;
                        case menuOption.editContact:
                            stackview.clearPush(editContact);
                            break;
                        case menuOption.showContactList:
                            stackview.clearPush(contactList);
                            break;
                        }
                    }
                    onEntered: {
                        rectItem.color = "gray";
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
        id: addContact
        AddContact {}
    }

    Component {
        id: deleteContact
        DeleteContact {}
    }

    Component {
        id: editContact
        EditContact {}
    }

    Component {
        id: contactList
        ContactList {}
    }

    Component {
        id: contactEditorPage
        ContactEditorPage {}
    }
}
