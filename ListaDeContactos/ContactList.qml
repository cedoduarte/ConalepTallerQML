import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage

Page {
    header: Label {
        text: "Lista de contactos"
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
                        id: rs.rows.item(i).id,
                        name: rs.rows.item(i).name,
                        email: rs.rows.item(i).email,
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
        anchors.fill: parent
        model: contactList
        delegate: Rectangle {
            id: rectItem
            width: parent.width
            height: 50
            color: "transparent"
            Text {
                id: txt
                text: modelData.name + " - " + modelData.phoneNumber
                font.pointSize: 12
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
            }
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
            }
        }
    }
}
