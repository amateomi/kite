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
    required property url iconPicture

    readonly property color iconColor: "#f0f4ff"
    readonly property color defaultBackgroundColor: "#383c49"
    readonly property color hoveredBackgroundColor: "#505668"

    icon.height: 20
    icon.width: 20
    icon.source: "images/" + iconPicture
    icon.color: iconColor

    background: Rectangle {
        width: parent.width
        height: parent.height
        color: parent.hovered ? hoveredBackgroundColor : defaultBackgroundColor
        radius: 10
    }
}
