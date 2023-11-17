import QtQuick
import QtQuick.Window
import Qt5Compat.GraphicalEffects

import "./data/qml/appControls"
import "./data/qml/themes"

Window {

    // ------------------------------------------------------------------
    // Private internal functions.
    // ------------------------------------------------------------------

    QtObject {
        id: internal

        property int windowStatus: 0        // Tracks if app window is on fullscreen state (1) or not (0)
        property int defaultAppMargin: 20

        // This function shows or hides resize and drag areas.
        function toggleResizeAreas(show) {

            // Shows or hide the window drag/move area based on parameter 'show'.
            windowDragArea.visible = show

            // Shows or hide the window resize areas based on parameter 'show'.
            resizeLeft.visible = show
            resizeRight.visible = show
            resizeBottom.visible = show
            resizeTop.visible = show
            resizeWindowBotLeft.visible = show
            resizeWindowBotRight.visible = show
            resizeWindowTopLeft.visible = show
            resizeWindowTopRight.visible = show
        }

        function toggleShadowMargins() {
            // If fullscreen, disables shadow margins.
            if (windowStatus == 1) {
                appBackground.anchors.leftMargin   = 0
                appBackground.anchors.rightMargin  = 0
                appBackground.anchors.bottomMargin = 0
                appBackground.anchors.topMargin    = 0

                // If windowed mode, sets shadow margins.
            } else {
                appBackground.anchors.leftMargin   = defaultAppMargin
                appBackground.anchors.rightMargin  = defaultAppMargin
                appBackground.anchors.bottomMargin = defaultAppMargin
                appBackground.anchors.topMargin    = defaultAppMargin
            }
        }

        // This function checks if app window is on fullscreen and sets windowed, and vice versa.
        function maximizeRestore() {

            // If windowed mode, sets fullscreen.
            if (windowStatus == 0) {
                windowStatus = 1
                window.showMaximized()
                appFullscreen.imageUrl = "./res/system/app_minimize.png"
                appBackground.radius = 0

                toggleResizeAreas(false)

                // If fullscreen mode, sets windowed.
            } else {
                windowStatus = 0
                window.showNormal()
                appFullscreen.imageUrl = "./res/system/app_maximize.png"
                appBackground.radius = currentTheme.universalAppRadius

                toggleResizeAreas(true)
            }
        }
    }



    // ------------------------------------------------------------------
    // Initial window settings setup.
    // ------------------------------------------------------------------

    // ThemeManager handles the application color scheme.
    ThemeManager{ id: currentTheme }

    // All default values are set based on "safe" window size values.
    // These values are not supposed to be tweaked.

    id: window
    visible: true
    title: qsTr("SIA")

    width : 970         // Default size +20 because of shadow margins.
    height: 570
    minimumWidth : 970
    minimumHeight: 570

    color: "#00000000"  // Transparent because of rounded window borders.
    flags: Qt.Window | Qt.FramelessWindowHint




    // ------------------------------------------------------------------
    // Main application container.
    // ------------------------------------------------------------------

    // The app container is used to generate a shadow effect behind
    // the undecorated window. It contains the main app background.

    // The DropShadow is at the end of this container definition for
    // hierarchy purposes.

    Rectangle {
        id: appContainer
        color: "Transparent"
        anchors.fill: parent


        // This rectangle generates the sahdow effect on the app background.
        Rectangle {
            id: shadowContainer
            color: appBackground.color
            radius: appBackground.radius

            anchors.fill: parent
            anchors.margins: ( internal.defaultAppMargin + 1 ) // To prevent clipping.

            layer.enabled: true

            // All default values were set to go in line with Windows default style.
            layer.effect: DropShadow {
                horizontalOffset: 3
                verticalOffset: 3
                radius: 15.0
                samples: 17
                color: "#40000000"
                transparentBorder: true
            }
        }



        // This is the actual application background
        Rectangle {
            id: appBackground
            color: currentTheme.backgroundWindowColor
            anchors.fill: parent
            anchors.margins: internal.defaultAppMargin

            radius: currentTheme.universalAppRadius

            layer.enabled: true
            layer.effect:
                OpacityMask {
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



            // ------------------------------------------------------------------
            // Top application tool bar.
            // ------------------------------------------------------------------

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


                // Event handler for window drag and move.
                MouseArea {
                    id: windowDragArea
                    height: 30
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0

                    DragHandler {
                        onActiveChanged: if (active){ window.startSystemMove() }
                    }

                }


                // Button to close the application.
                Button_solidSwap {
                    id: appExit

                    width: 45
                    height: 30
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    buttonBorderRadius: 0

                    default_button_color: "White"
                    hovered_button_color: "#ff002a"
                    hovered_textColor: "White"

                    onClicked: window.close()
                }

                // Button to toggle fullscreen for application window.
                Button_solidSwap {
                    id: appFullscreen

                    width: 45
                    height: 30
                    anchors.right: appExit.left
                    anchors.top: parent.top
                    buttonBorderRadius: 0
                    anchors.topMargin: 0
                    anchors.rightMargin: 0

                    default_button_color: "White"
                    hovered_button_color: "#f3f3f3"

                    imageUrl: "./res/system/app_maximize.png"

                    onClicked: {
                        internal.maximizeRestore()
                        internal.toggleShadowMargins()
                    }
                }

                // Button to hide the application window.
                Button_solidSwap {
                    id: appHide

                    width: 45
                    height: 30
                    anchors.right: appFullscreen.left
                    anchors.top: parent.top
                    buttonBorderRadius: 0
                    anchors.topMargin: 0
                    anchors.rightMargin: 0

                    default_button_color: "White"
                    hovered_button_color: "#f3f3f3"

                    imageUrl: "./res/system/app_hide.png"

                    onClicked: window.showMinimized()
                }
            }




            // ------------------------------------------------------------------
            // Bottom application tool bar.
            // ------------------------------------------------------------------

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




            // ------------------------------------------------------------------
            // Window resize mouse areas.
            // ------------------------------------------------------------------

            // These Mouse Areas handle Window Resize interactions.
            // Anchors were set in a specific way so they do not conflict with each other.



            // ********************************* Unidirectional Resize Areas:

            // Resize area for left window side.
            MouseArea {
                id: resizeLeft
                width: 10
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 25
                anchors.bottomMargin: 25
                anchors.leftMargin: 0
                cursorShape: Qt.SizeHorCursor

                onPressed: {
                    window.startSystemResize(Qt.LeftEdge)
                }
            }

            // Resize area for right window side.
            MouseArea {
                id: resizeRight
                width: 10
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 30
                anchors.bottomMargin: 25
                anchors.rightMargin: 0
                cursorShape: Qt.SizeHorCursor

                onPressed: {
                    window.startSystemResize(Qt.RightEdge)
                }
            }

            // Resize area for top window side.
            MouseArea {
                id: resizeTop
                height: 5
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.leftMargin: 25
                cursorShape: Qt.SizeVerCursor
                anchors.rightMargin: 10

                onPressed: {
                    window.startSystemResize(Qt.TopEdge)
                }
            }

            // Resize area for bottom window side.
            MouseArea {
                id: resizeBottom
                height: 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.rightMargin: 25
                anchors.leftMargin: 25
                cursorShape: Qt.SizeVerCursor

                onPressed: {
                    window.startSystemResize(Qt.BottomEdge)
                }
            }



            // ********************************* Bidirectional Resize Areas:

            // Resize area for bottom-right window corner.
            MouseArea {
                id: resizeWindowBotRight
                x: -15
                y: 500
                width: 25
                height: 25
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                cursorShape: Qt.SizeFDiagCursor

                onPressed: {
                    window.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                }
            }

            // Resize area for bottom-left window corner.
            MouseArea {
                id: resizeWindowBotLeft
                x: 1
                y: 524
                width: 25
                height: 25
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                cursorShape: Qt.SizeBDiagCursor

                onPressed: {
                    window.startSystemResize(Qt.LeftEdge | Qt.BottomEdge)
                }
            }

            // Resize area for top-left window corner.
            MouseArea {
                id: resizeWindowTopLeft
                x: 7
                width: 25
                height: 25
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.leftMargin: 0
                cursorShape: Qt.SizeFDiagCursor
                anchors.rightMargin: 0

                onPressed: {
                    window.startSystemResize(Qt.LeftEdge | Qt.TopEdge)
                }
            }

            // Resize area for top-right window corner.
            MouseArea {
                id: resizeWindowTopRight
                x: 925
                width: 10
                height: 10
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 0
                cursorShape: Qt.SizeBDiagCursor
                anchors.rightMargin: 0

                onPressed: {
                    window.startSystemResize(Qt.RightEdge | Qt.TopEdge)
                }
            }
        }
    }
}
