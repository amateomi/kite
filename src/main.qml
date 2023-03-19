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

        TextField {
            id: searchBar
            anchors.centerIn: parent
            height: 40
            width: parent.width / 2

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
