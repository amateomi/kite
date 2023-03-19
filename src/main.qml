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
import QtQuick.Layouts
import QtQuick.Controls

import QtQml.Models

import QtWebEngine

import backend.logic

ApplicationWindow {
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

            // TODO: Move common functionality to other .qml files
            // TODO: fix hoverable, when can't go back or forward
            // Go back
            RoundButton {
                id: backButton
                palette.button: "#505168"

                icon.source: "images/backIcon.svg"
                // IDK WHY 20. IF I SET 32 - BUTTON SIZES WILL BE 44?? 44-32 = 12, SO 32-12=20 AND IT WORKS!!!
                icon.height: 20
                icon.width: 20
                icon.color: "#606166"
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
                    if (webView.canGoBack) {
                        background.color = "#666d84"
                        webView.goBack()
                    }
                }
                
                onReleased: {
                    background.color = "#505668"
                }
            }

            // Go forward
            RoundButton {
                id: forwardButton
                palette.button: "#505168"

                icon.source: "images/forwardIcon.svg"
                icon.height: 20
                icon.width: 20
                icon.color: "#606166"
                radius: 2

                background: Rectangle {
                    width: forwardButton.width
                    height: forwardButton.height
                    color: "#383c49"
                    radius: 10
                }

                // UI logic stuff
                onHoveredChanged: {
                    forwardButton.background.color = forwardButton.hovered ? "#505668" : "#383c49"
                }

                onPressed: {
                    if (webView.canGoForward) {
                        background.color = "#666d84"
                        webView.goForward()
                    }
                }
                
                onReleased: {
                    background.color = "#505668"
                }
            }

            // Reload
            RoundButton {
                id: reloadButton
                palette.button: "#505168"

                icon.source: "images/reloadIcon.svg"
                icon.height: 20
                icon.width: 20
                icon.color: "#f0f4ff"
                radius: 2


                background: Rectangle {
                    width: reloadButton.width
                    height: reloadButton.height
                    color: "#383c49"
                    radius: 10
                }

                // UI logic stuff
                onHoveredChanged: {
                    reloadButton.background.color = reloadButton.hovered ? "#505668" : "#383c49"
                }

                onPressed: {
                    background.color = "#666d84"
                    webView.reload()
                }
                
                onReleased: {
                    background.color = "#505668"
                }
            }

            Button {
                id: bookmarkButton
                text: "bookmarks"

                onClicked: bookmarkMenu.open()

                Menu {
                    id: bookmarkMenu

                    y: bookmarkButton.height
                    width: 100
                    height: 20 * bookmarkListView.count

                    contentItem: bookmarkListView
                    ListView {
                        id: bookmarkListView

                        anchors.fill: parent

                        interactive: false

                        model: bookmarkListModel

                        delegate: Button {
                            width: bookmarkListView.width; height: 20

                            text: name

                            onClicked: {
                                webView.url = url
                            }
                        }
                    }
                }
            }
            Button {
                id: bookmarkAddButton
                text: "+"

                onClicked: bookmarkAddDialog.open()

                Dialog {
                    id: bookmarkAddDialog
                    title: "Add Bookmark"
                    height: 60
                    width: 120

                    TextField {
                        id: bookmarkAddField

                        height: 20
                        width: 100

                        verticalAlignment: Text.AlignVCenter
                        placeholderText: qsTr("Name")

                        onAccepted: {
                            bookmarkManager.addBookmark(text, webView.url)
                            text = ""
                        }
                    }
                }
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
                searchBarManager.receiveNewUrl(text, webView)
                searchBar.focus = false
            }
        }
    }

    WebEngineView {
        id: webView
        anchors {
            bottom: parent.bottom
            top: topBar.bottom
            left: parent.left
            right: parent.right
        }
        
        url: "https://google.com"

        onUrlChanged: searchBar.text = url

        onCanGoBackChanged: {
            backButton.icon.color = canGoBack ? "#f0f4ff" : "#606166"
            backButton.enabled = canGoBack ? true : false
            backButton.hoverEnabled = canGoBack ? true : false
        }
        onCanGoForwardChanged: {
            forwardButton.icon.color = canGoForward ? "#f0f4ff" : "#606166"
            forwardButton.enabled = canGoForward ? true : false
            forwardButton.hoverEnabled = canGoForward ? true : false
        }
    }
}
