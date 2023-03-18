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

Window {
    id: root

    width: 1280
    height: 720

    visible: true

    ListModel {
        id: bookmarkListModel
        ListElement {
            name: "google"
            url: "https://google.com"
        }
        ListElement {
            name: "youtube"
            url: "https://youtube.com"
        }
        ListElement {
            name: "vk"
            url: "https://vk.com"
        }
    }

    Rectangle {
        id: topBar
        height: 48
        width: root.width
        color: "#383c49"

        RowLayout {
            spacing: 4
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

            BookmarkManager {
                id: bookmarkManager
            }
            Button {
                id: bookmarks
                text: "bookmarks"

                onClicked: menu.open()

                Menu {
                    id: menu
                    y: bookmarks.height
                    height: 20 * bookmarkListModel.count < root.height ? 20 * bookmarkListModel.count : root.height - 40
                    width: 100

                    contentItem: ListView {
                        anchors.fill: parent
                        model: bookmarkListModel
                        delegate: Button {
                            height: 20
                            width: menu.width
                            text: name
                            onClicked: {
                                console.log(url)
                            }
                        }
                    }
                }
            }
            Button {
                id: bookmarkAdder
                text: "add"
                onClicked: {
                    bookmarkManager.addBookmark(webView.url)
                }
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
        id: webView
        anchors {
            bottom: parent.bottom
            top: topBar.bottom
            left: parent.left
            right: parent.right
        }
        url: "https://google.com"
    }
}
