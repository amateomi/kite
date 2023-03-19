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
            spacing: 10

            RoundButton {
                id: backButton
                palette.button: "#505168"

                icon.source: "images/backIcon.png"
                icon.height: 32
                icon.color: "#f0f4ff"
                radius: 2
                Layout.leftMargin: 10

                background: Rectangle {
                    width: backButton.width
                    height: backButton.height
                    color: "#383c49"
                    radius: 10
                }

                // UI logic stuff
                onHoveredChanged: {
                    backButton.background.color = backButton.hovered ? "#505668" : "#383c49"
                }

                onPressed: {
                    background.color = "#666d84"
                    if (webview.canGoBack){
                        webview.goBack()
                    }
                }
                onReleased: {
                    background.color = "#505668"
                }
            }

            RoundButton {
                id: fowardButton
                x: 10; y: 10
                palette.button: "#505168"

                icon.source: "images/forwardIcon.png"
                icon.height: 32
                icon.color: "#f0f4ff"
                radius: 2

                background: Rectangle {
                    width: fowardButton.width
                    height: fowardButton.height
                    color: "#383c49"
                    radius: 10
                }

                // UI logic stuff
                onHoveredChanged: {
                    fowardButton.background.color = fowardButton.hovered ? "#505668" : "#383c49"
                }

                onPressed: {
                    background.color = "#666d84"
                    if (webview.canGoForward){
                        webview.goForward()
                    }
                }
                onReleased: {
                    background.color = "#505668"
                }
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
