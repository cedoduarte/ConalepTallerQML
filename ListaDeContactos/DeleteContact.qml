import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage

Page {
    header: Label {
        text: "Eliminar contacto"
        elide: Label.ElideRight
        font.pointSize: 12
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
    }

    property var contactList: []

    function populate() {
        try {
            db.transaction(tx => {
                let rs = tx.executeSql("SELECT * FROM contact");
                contactList = [];
                for (let i = 0; i < rs.rows.length; i++) {
                    contactList.push({
                        checked: false,
                        id: rs.rows.item(i).id,
                        name: rs.rows.item(i).name,
                        phoneNumber: rs.rows.item(i).phoneNumber
                    });
                }
                contactListChanged();
            });
        } catch (err) {
            console.log(err);
        }
    }

    Component.onCompleted: {
        this.populate();
    }

    ListView {
        clip: true
        anchors.topMargin: 10
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: deleteButton.top
        model: contactList
        delegate: Rectangle {
            id: rectItem
            width: parent.width
            height: 50
            color: "transparent"            
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    rectItem.color = "#305fab";
                    txt.color = "white";
                }
                onExited: {
                    rectItem.color = "transparent";
                    txt.color = "black";
                }

                RowLayout {
                    anchors.fill: parent
                    CheckBox {
                        Layout.alignment: Qt.AlignVCenter
                        onCheckedChanged: {
                            contactList[index].checked = (this.checkState === Qt.Checked);
                        }
                    }
                    Text {
                        id: txt
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                        Layout.fillWidth: true
                        text: modelData.name + " - " + modelData.phoneNumber
                        font.pointSize: 12
                    }
                }
            }
        }
    }

    Button {
        id: deleteButton
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Eliminar"
        onClicked: {
            try {
                db.transaction(tx => {
                    for (let i = 0; i < contactList.length; i++) {
                        if (contactList[i].checked) {
                            tx.executeSql("DELETE FROM contact WHERE id = ?", [contactList[i].id]);
                        }
                    }
                });
                populate();
            } catch (err) {
                console.log(err);
            }
        }
    }
}
