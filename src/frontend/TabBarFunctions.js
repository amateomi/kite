function createTab(profile, focusOnNewTab = true, url = undefined) {
    var webview = pageContent.createObject(tabLayout, {profile: profile});
    var newTabButton = tab.createObject(tabBar, {tabTitle: Qt.binding(function () { return webview.title; })});
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
