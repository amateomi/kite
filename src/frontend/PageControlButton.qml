import QtQuick
import QtQuick.Controls

RoundButton {
    required property url iconPicture

    readonly property color defaultIconColor: "#606166"
    readonly property color activeIconColor: "#f0f4ff"
    readonly property color defaultBackgroundColor: "#383c49"
    readonly property color hoveredBackgroundColor: "#505668"

    icon.height: 20
    icon.width: 20
    icon.source: "images/" + iconPicture
    icon.color: defaultIconColor

    background: Rectangle {
        width: parent.width
        height: parent.height
        color: defaultBackgroundColor
        radius: 10
    }

    onHoveredChanged: background.color = hovered ? hoveredBackgroundColor : defaultBackgroundColor
}
