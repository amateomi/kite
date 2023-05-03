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
        color: parent.hovered ? hoveredBackgroundColor : defaultBackgroundColor
        radius: 10
    }

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
                    color: parent.hovered ? hoveredTextColor : defaultBackgroundColor
                }

                onClicked: currentWebView.url = url
            }
        }
    }
}
