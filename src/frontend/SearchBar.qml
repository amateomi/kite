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
