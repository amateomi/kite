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

import backend.logic

Window {
    id: root
    width: 1280
    height: 720
    visible: true

    Rectangle {
        id: topBar
        height: 48
        width: root.width
        color: "#383c49"

        RowLayout {
            
            anchors.verticalCenter: parent.verticalCenter

            RoundButton {
                id: backButton
                icon.name: "backButtonIcon"
                icon.source: "images/backIcon.png"
                icon.height: 30
                icon.width: 50
                icon.color: "red"

                radius: 10
                background: Rectangle{
                    width: backButton.width
                    height: backButton.height
                    color: "#000000"
                    radius: 10
                }

                onPressed: {
                    background.color = "#ffffff"
                }

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
                background: Rectangle {
                    color: "#505168"
                    radius: 5
                }
                id: addBookmarks
                text: "a"
            }
        }

        SearchBar {
            id: searchBarManager
        }

        TextField {
            // UI settings
            id: searchBar
            anchors.centerIn: parent
            width: parent.width / 2
            height: 32

            palette.text: "#f0f4ff"
            verticalAlignment: TextArea.AlignVCenter

            placeholderText: "Search with Google or enter address"

            selectByMouse: true
            font.pixelSize: 16

            background: Rectangle {
                color: "#505168"
                radius: 5
            }

            // Logic
            onAccepted: {
                searchBarManager.receiveNewUrl(text, webview)
                searchBar.focus = false
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
        url: "https://www.google.com/"

        onUrlChanged: searchBar.text = url
    }
}
