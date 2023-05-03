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

import QtCore
import QtQml

import backend.logic
import "frontend"

ApplicationWindow {
    id: root

    property Item currentWebView: tabLayout.children[tabBar.currentIndex]
    property int createdTabs: 0

    width: 1280
    height: 720

    visible: true

    Rectangle {
        id: topBar

        width: root.width
        height: 48

        color: "#383c49"

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
                onPressed: {
                    currentWebView.reload()
                }
            }
            BookmarkButton {}
            BookmarkAddButton {}
        }
        SearchBar {
            id: searchBar
        }
    }

    Action {
        shortcut: StandardKey.AddTab
        onTriggered: {
            tabBar.createTab(tabBar.count !== 0 ? currentWebView.profile : defaultProfile);
            searchBar.forceActiveFocus();
            searchBar.selectAll();
        }
    }

    StackLayout {
        id: tabLayout
        currentIndex: tabBar.currentIndex

        anchors.top: tabBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Component {
        id: tabButtonComponent

        TabButton {
            property color frameColor: "#999"
            property color fillColor: "#eee"
            property color nonSelectedColor: "#ddd"
            property string tabTitle: "New Tab"

            id: tabButton
            contentItem: Rectangle {
                id: tabRectangle
                color: tabButton.down ? fillColor : nonSelectedColor
                border.width: 1
                border.color: frameColor
                implicitWidth: Math.max(text.width + 30, 80)
                height: Math.max(text.height + 10, 20)
                Rectangle { height: 1 ; width: parent.width ; color: frameColor}
                Rectangle { height: parent.height ; width: 1; color: frameColor}
                Rectangle { x: parent.width - 2; height: parent.height ; width: 1; color: frameColor}
                Text {
                    id: text
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 6
                    text: tabButton.tabTitle
                    elide: Text.ElideRight
                    color: tabButton.down ? "black" : frameColor
                    width: parent.width - button.background.width
                }
                Button {
                    id: button
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 4
                    height: 12
                    background: Rectangle {
                        implicitWidth: 12
                        implicitHeight: 12
                        color: button.hovered ? "#ccc" : tabRectangle.color
                        Text {text: "x"; anchors.centerIn: parent; color: "gray"}
                    }
                    onClicked: tabButton.closeTab()
                }
            }

            onClicked: searchBar.text = tabLayout.itemAt(TabBar.index).url;
            function closeTab() {
                tabBar.removeView(TabBar.index);
            }
        }
    }

    TabBar {
        id: tabBar
        anchors.top: topBar.bottom
        anchors.left: topBar.left
        anchors.right: topBar.right
        Component.onCompleted: createTab(WebEngineProfile)

        function createTab(profile, focusOnNewTab = true, url = undefined) {
            var webview = tabComponent.createObject(tabLayout, {profile: profile});
            var newTabButton = tabButtonComponent.createObject(tabBar, {tabTitle: Qt.binding(function () { return webview.title; })});
            tabBar.addItem(newTabButton);
            if (focusOnNewTab) {
                tabBar.setCurrentIndex(tabBar.count - 1);
            }
            if (url !== undefined) {
                webview.url = url;
            }
            return webview;
        }

        function removeView(index) {
            tabBar.removeItem(index);
            if (tabBar.count > 1) {
                tabBar.removeItem(tabBar.itemAt(index));
                tabLayout.children[index].destroy();
            } else {
                browserWindow.close();
            }
        }

        Component {
            id: tabComponent

            WebEngineView {
                id: webView
                focus: true

                url: "https://google.com"

                onUrlChanged: searchBar.text = url
                onCanGoBackChanged: backButton.icon.color = canGoBack ? backButton.activeIconColor : backButton.defaultIconColor
                onCanGoForwardChanged: forwardButton.icon.color = canGoForward ? forwardButton.activeIconColor : forwardButton.defaultIconColor
            }
        }
    }
}
