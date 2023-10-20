import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.LocalStorage

Page {
    header: Label {
        text: "Agregar contacto"
        elide: Label.ElideRight
        font.pointSize: 12
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
    }

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
            text: "Contacto agregado correctamente"
        }
    }

    Button {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Agregar"
        onClicked: {
            try {
                db.transaction(tx => {
                    let name = txtName.text;
                    let email = txtEmail.text;
                    let phoneNumber = txtPhoneNumber.text;
                    tx.executeSql("INSERT INTO contact(name, email, phoneNumber) VALUES(?,?,?)", [ name, email, phoneNumber ]);
                });
                messageDialog.open();
            } catch (err) {
                console.log(err);
            }
        }
    }
}
