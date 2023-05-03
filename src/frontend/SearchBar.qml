import QtQuick
import QtQuick.Controls

import backend.logic

TextField {
    readonly property color textColor: "#f0f4ff"
    readonly property color backgroundColor: "#505668"

    width: parent.width / 2
    height: 32

    anchors.centerIn: parent

    placeholderText: "Search with Google or enter address"
    placeholderTextColor: textColor
    palette.text: textColor
    font.pixelSize: 16
    selectByMouse: true

    background: Rectangle {
        color: backgroundColor
        radius: 5
    }

    SearchBarManager {
        id: searchBarManager
    }

    onAccepted: {
        searchBarManager.receiveNewUrl(text, currentWebView)
        focus = false
    }
}
