import QtQuick
import QtQuick.Controls

import "TabBarFunctions.js" as TabBarFunctions

Component {
    TabButton {
        id: tabButton

        required property string tabTitle

        readonly property color defaultTextColor: "#f0f4ff"
        readonly property color pressedTextColor: "#f0f4ff"
        readonly property color defaultTabButtonColor: "#505668"
        readonly property color defaultBackgroundColor: "#383c49"

        contentItem: Rectangle {
            width: parent.width
            height: parent.height

            color: tabButton.down ? defaultBackgroundColor : defaultTabButtonColor

            Text {
                id: tabName

                width: parent.width

                anchors.centerIn: parent
                anchors.leftMargin: 6
                elide: Text.ElideRight

                text: tabButton.tabTitle

                color: tabButton.down ? pressedTextColor : defaultTextColor
            }
            RoundButton {
                height: 12

                anchors.right: parent.right
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter

                background: Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: parent.height

                    color: parent.hovered ? defaultBackgroundColor : defaultTabButtonColor

                    Text {
                        anchors.centerIn: parent
                        text: "x"
                        color: tabButton.down ? pressedTextColor : defaultTextColor
                    }
                }

                onClicked: tabButton.closeTab()
            }
        }
        background: Rectangle {
            color: defaultBackgroundColor
        }

        onClicked: searchBar.text = tabLayout.itemAt(TabBar.index).url;

        function closeTab() {
            TabBarFunctions.removeView(TabBar.index);
        }
    }
}
