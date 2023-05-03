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

import QtWebEngine

import backend.logic

import "frontend"
import "frontend/TabBarFunctions.js" as TabBarFunctions

ApplicationWindow {
    id: root

    property Item currentWebView: tabLayout.children[tabBar.currentIndex]
    property int createdTabs: 0

    width: 1280
    height: 720

    visible: true

    Rectangle {
        id: topBar

        readonly property color topBarColor: "#383c49"

        width: root.width
        height: 48

        color: topBarColor

        RowLayout {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            PageControlButton {
                id: backButton
                iconPicture: "backIcon.svg"
                onPressed: {
                    if (currentWebView.canGoBack) {
                        currentWebView.goBack()
                    }
                }
            }
            PageControlButton {
                id: forwardButton
                iconPicture: "forwardIcon.svg"
                onPressed: {
                    if (currentWebView.canGoForward) {
                        currentWebView.goForward()
                    }
                }
            }
            PageControlButton {
                id: reloadButton
                iconPicture: "reloadIcon.svg"
                onPressed: currentWebView.reload()
            }
            BookmarkButton {}
            BookmarkAddButton {}
        }
        SearchBar {
            id: searchBar
        }
    }
    TabBar {
        id: tabBar

        contentHeight: 28

        anchors.top: topBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Component.onCompleted: TabBarFunctions.createTab(WebEngineProfile)

        PageContent {
            id: pageContent
        }
        Tab {
            id: tab
        }
    }
    StackLayout {
        id: tabLayout

        anchors.top: tabBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        currentIndex: tabBar.currentIndex
    }

    Action {
        shortcut: StandardKey.AddTab

        onTriggered: {
            TabBarFunctions.createTab(tabBar.count !== 0 ? currentWebView.profile : defaultProfile);
            searchBar.forceActiveFocus();
            searchBar.selectAll();
        }
    }
}
