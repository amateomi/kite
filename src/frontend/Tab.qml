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

import "TabBarFunctions.js" as TabBarFunctions

Component {
    TabButton {
        id: tabButton

        required property string tabTitle

        readonly property color defaultTextColor: "#f0f4ff"
        readonly property color pressedTextColor: "#f0f4ff"
        readonly property color defaultTabButtonColor: "#505668"
        readonly property color defaultBackgroundColor: "#383c49"

        contentItem: Rectangle {
            width: parent.width
            height: parent.height

            color: tabButton.down ? defaultBackgroundColor : defaultTabButtonColor

            Text {
                id: tabName

                width: parent.width

                anchors.centerIn: parent
                anchors.leftMargin: 6
                elide: Text.ElideRight

                text: tabButton.tabTitle

                color: tabButton.down ? pressedTextColor : defaultTextColor
            }
            RoundButton {
                height: 12

                anchors.right: parent.right
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter

                background: Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: parent.height

                    color: parent.hovered ? defaultBackgroundColor : defaultTabButtonColor

                    Text {
                        anchors.centerIn: parent
                        text: "x"
                        color: tabButton.down ? pressedTextColor : defaultTextColor
                    }
                }

                onClicked: tabButton.closeTab()
            }
        }
        background: Rectangle {
            color: defaultBackgroundColor
        }

        onClicked: searchBar.text = tabLayout.itemAt(TabBar.index).url;

        function closeTab() {
            TabBarFunctions.removeView(TabBar.index);
        }
    }
}
