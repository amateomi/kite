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

    /*
    Frame {
        // Just dummy frame to structurizing window sections
        // Perhaps need to delete 'cause have a cringe border
        id: top_bar
       

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
    */

    Rectangle {
        id: topBar
        height: 48
        width: root.width
        color: "#383c49"

        RowLayout {
            
            anchors.verticalCenter: parent.verticalCenter

            Button {
                id: backButton
                text: "←"
            }
            Button {
                id: fowardButton
                text: "→"
            }
            Button {
                id: refreshButton
                text: "o"
            }
            Button {
                id: bookmarks
                text: "b"
            }
            Button {
                id: addBookmarks
                text: "a"
            }
        }

        TextField {
            id: searchBar
            anchors.centerIn: parent
            width: parent.width / 2
            height: 40

            palette.placeholderText: "#f0f4ff"
            verticalAlignment: Text.AlignVCenter
            placeholderText: qsTr("Search with Google or enter address")

            background: Rectangle {
                color: "#505168"
                radius: 10
            }
        }
    }


    WebEngineView {
        id: webview
        anchors {
            bottom: parent.bottom 
            top: topBar.bottom
            left: parent.left
            right: parent.right
        }
        url: "https://google.com" 
    }

}
