import QtQuick
import QtQuick.Controls

RoundButton {
    readonly property color textColor: "#f0f4ff"
    readonly property color backgroundColor: "#383c49"
    readonly property color headerColor: "#505668"

    contentItem: Text {
        text: "+"
        color: textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        width: parent.width
        height: parent.height
        color: backgroundColor
        radius: 10
    }

    onHoveredChanged: background.color = hovered ? backgroundColor : headerColor
    onClicked: bookmarkAddDialog.open()

    Dialog {
        id: bookmarkAddDialog

        height: 60
        width: 120

        focus: true

        header: Rectangle {
            width: parent.width
            height: 20
            color: headerColor

            Text {
                text: "Add Bookmark"
                color: textColor
                anchors.centerIn: parent
            }
        }
        background: Rectangle {
            width: parent.width
            height: parent.height
            color: backgroundColor
            radius: 10
        }

        TextField {
            height: 20
            width: 100

            focus: true

            anchors.centerIn: parent

            placeholderText: qsTr("Name")

            onAccepted: {
                bookmarkManager.addBookmark(text, currentWebView.url)
                text = ""
            }
        }
    }
}
