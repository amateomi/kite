/****************************************************************************
 * Copyright (c) 2022 Andrey Sikorin, Ivan Grigorik                         *
 *                                                                          *
 * This program is free software: you can redistribute it and/or modify     *
 * it under the terms of the GNU General Public License as published by     *
 * the Free Software Foundation, version 3.                                 *
 *                                                                          *
 * This program is distributed in the hope that it will be useful, but      *
 * WITHOUT ANY WARRANTY; without even the implied warranty of               *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU         *
 * General Public License for more details.                                 *
 *                                                                          *
 * You should have received a copy of the GNU General Public License        *
 * along with this program. If not, see <http://www.gnu.org/licenses/>.     *
 ****************************************************************************/

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
        color: parent.hovered ? headerColor : backgroundColor
        radius: 10
    }

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
