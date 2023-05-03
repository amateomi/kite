import QtQuick

import QtWebEngine

Component {
    WebEngineView {
        url: "https://google.com"

        onUrlChanged: searchBar.text = url
        onCanGoBackChanged: backButton.icon.color = canGoBack ? backButton.activeIconColor : backButton.defaultIconColor
        onCanGoForwardChanged: forwardButton.icon.color = canGoForward ? forwardButton.activeIconColor : forwardButton.defaultIconColor
    }
}
