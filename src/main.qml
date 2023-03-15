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
import QtWebEngine
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: root
    width: 1280
    height: 720
    visible: true

    
    Frame {
        // Just dummy frame to structurizing window sections
        // Perhaps need to delete 'cause have a cringe border
        id: top_bar
        height: topbar_shape.height + 1 
        width: topbar_shape.width + 1

        Rectangle {
            id: topbar_shape
            color: "blue"
            width: root.width
            height: 41;

            GridLayout {
                id: top_bar_grid
                anchors.centerIn: parent
                columns: 5
                Button{text: "button1"}
                Text{text: "button2"}
                Text{text: "searchbar"; color:"red"}
            }
        }
        
    }

    WebEngineView {
        id: webview
        anchors.bottom: parent.bottom 
        anchors.top: top_bar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        url: "https://google.com" 
    }

}
