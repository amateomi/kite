import QtQuick
import QtQuick.Controls

RoundButton {
    readonly property color defaultTextColor: "#f0f4ff"
    readonly property color hoveredTextColor: "#606166"
    readonly property color defaultBackgroundColor: "#383c49"
    readonly property color hoveredBackgroundColor: "#505668"

    contentItem: Text {
        text: "bookmarks"
        color: defaultTextColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        width: parent.width
        height: parent.height
        color: defaultBackgroundColor
        radius: 10
    }

    onHoveredChanged: background.color = hovered ? hoveredBackgroundColor : defaultBackgroundColor
    onClicked: bookmarkMenu.open()

    Menu {
        id: bookmarkMenu

        y: parent.height

        height: 20 * bookmarkListView.count
        width: 100

        contentItem: bookmarkListView

        ListView {
            id: bookmarkListView

            anchors.fill: parent

            interactive: false

            model: bookmarkListModel

            delegate: Button {
                width: bookmarkMenu.width
                height: 20

                contentItem: Text {
                    text: name
                    color: defaultTextColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    width: parent.width
                    height: parent.height
                    color: defaultBackgroundColor
                }

                onHoveredChanged: contentItem.color = hovered ? hoveredTextColor : defaultTextColor
                onClicked: currentWebView.url = url
            }
        }
    }
}
