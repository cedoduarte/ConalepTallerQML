import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.LocalStorage

Page {
    header: Label {
        text: "Editor de contacto"
        elide: Label.ElideRight
        font.pointSize: 12
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
    }

    property int id
    property alias name: txtName.text
    property alias email: txtEmail.text
    property alias phoneNumber: txtPhoneNumber.text

    GridLayout {
        rows: 3
        columns: 2
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right

        Label {
            text: "Nombre"
            font.pointSize: 12
        }
        TextField {
            id: txtName
            Layout.fillWidth: true
        }

        Label {
            text: "Correo"
            font.pointSize: 12
        }
        TextField {
            id: txtEmail
            Layout.fillWidth: true
        }

        Label {
            text: "Teléfono"
            font.pointSize: 12
        }
        TextField {
            id: txtPhoneNumber
            Layout.fillWidth: true
        }
    }

    Dialog {
        id: messageDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: "Mensaje"
        Label {
            text: " Contacto editado correctamente"
        }
    }

    Button {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Editar"
        onClicked: {
            try {
                db.transaction(tx => {
                    tx.executeSql("UPDATE contact SET name = ?, email = ?, phoneNumber = ? WHERE id = ?", [ name, email, phoneNumber, id ]);
                });
                messageDialog.open();
            } catch (err) {
                console.log(err);
            }
        }
    }
}
