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

function createTab(profile, focusOnNewTab = true, url = undefined) {
    var webview = pageContent.createObject(tabLayout, { profile: profile });
    var newTabButton = tab.createObject(tabBar, { tabTitle: Qt.binding(function () { return webview.title; }) });
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
