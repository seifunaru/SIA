import QtQuick
import QtQuick.Window
import Qt5Compat.GraphicalEffects

import "./data/qml/appControls"
import "./data/qml/themes"

Window {

    //## INTERNAL FUNCTIONS
    QtObject {
        id: internal

        property int windowStatus: 0

        function maximizeRestore() {
            if (windowStatus == 0) {
                windowStatus = 1
                window.showMaximized()
                appFullscreen.imageUrl = "./res/system/app_minimize.png"
                appBackground.radius = 0
            } else {
                windowStatus = 0
                window.showNormal()
                appFullscreen.imageUrl = "./res/system/app_maximize.png"
                appBackground.radius = currentTheme.universalAppRadius
            }
        }
    }

    ThemeManager{ id: currentTheme }

    id: window
    visible: true
    title: qsTr("Hello World")

    width : 950
    height: 550
    minimumWidth : 950
    minimumHeight: 550

    color: "#00000000"
    flags: Qt.FramelessWindowHint

    Rectangle {
        id: appBackground
        color: currentTheme.backgroundWindowColor
        anchors.fill: parent
        radius: currentTheme.universalAppRadius

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: appBackground.width
                height: appBackground.height
                Rectangle {
                    anchors.centerIn: parent
                    width: appBackground.width
                    height: appBackground.height
                    radius: appBackground.radius
                }
            }
        }

        Rectangle {
            id: topToolBar
            height: 110
            color: currentTheme.foregroundWindowColor
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0

            Button_solidSwap {
                id: appExit

                width: 45
                height: 30
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.topMargin: 0
                buttonBorderRadius: 0

                hovered_button_color: "#ff0030"
                hovered_textColor: "White"

            }

            Button_solidSwap {
                id: appFullscreen

                width: 45
                height: 30
                anchors.right: appExit.left
                anchors.top: parent.top
                buttonBorderRadius: 0
                anchors.topMargin: 0
                anchors.rightMargin: 0

                imageUrl: "./res/system/app_maximize.png"

                onClicked: {
                    internal.maximizeRestore()
                }
            }

            Button_solidSwap {
                id: appHide

                width: 45
                height: 30
                anchors.right: appFullscreen.left
                anchors.top: parent.top
                buttonBorderRadius: 0
                anchors.topMargin: 0
                anchors.rightMargin: 0

                imageUrl: "./res/system/app_hide.png"
            }
        }
        Rectangle {
            id: botToolbar
            x: 0
            y: 440
            height: 110
            color: currentTheme.foregroundWindowColor
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0
        }
    }

}
