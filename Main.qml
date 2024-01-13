import QtQuick
import QtQuick.Window
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 6.3

import "./data/qml/appControls"
import "./data/qml/themes"
import "./data/qml/pageStyle"

Window {

    // ------------------------------------------------------------------
    // Private internal functions.
    // ------------------------------------------------------------------



    QtObject {
        id: internal

        // Private
        // APP FUNCTIONALITY PROPERTIES
        property int windowStatus: 0            // Tracks if app window is on fullscreen state (1) or not (0)
        property int defaultAppMargin: 20
        property int currentMouseX: 0
        property int currentMouseY: 0

        property int mouseUpdate: 10

        property int currentStep: 0             // Tracks te current application step to show. Managed by backend.
        property string pageStyleToParse: ""    // Tracks which is the next expected page style template.


        // Private
        // BASIC MOD_INFO CONTAINER PROPERTIES
        property string modNameShrt: ""
        property string modNameLong: ""
        property string modAuthor: ""
        property string modVersion: ""
        property string modGame: ""
        property url modLogoImgUrl: ""
        property string expectedModInstallDir: ""
        property string modInstallDir: ""


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

        // This function handles the margins used to generate the DropShadow effect on the app background.
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
                appFullscreen.imageUrl = "qrc:/img/res/system/app_minimize.png"
                appBackground.radius = 0

                toggleResizeAreas(false)

                // If fullscreen mode, sets windowed.
            } else {
                windowStatus = 0
                window.showNormal()
                appFullscreen.imageUrl = "qrc:/img/res/system/app_maximize.png"
                appBackground.radius = currentTheme.universalAppRadius

                toggleResizeAreas(true)
            }
        }

        // gets path to step data JSON. Step 0 contains basic MOD_INFO used for the main app view.
        function getModDataUrl()
        {
            return "qrc:/json/data/json/step/0/modStep.json";
        }

        // gets data from JSON and defines PRIVATE properties with it.
        function loadModData() {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        var modData = JSON.parse(xhr.responseText);

                        // MOD INFORMATION
                        modNameShrt = modData.MOD_INFO.modNameShort
                        modNameLong = modData.MOD_INFO.modNameLong
                        modVersion = modData.MOD_INFO.modVersion
                        internal.modAuthor = modData.MOD_INFO.modAuthor
                        modGame = modData.MOD_INFO.modGame
                        expectedModInstallDir = modData.MOD_INFO.
                        modInstallDir = modData.MOD_INFO.modInstallDir

                        // ** //
                    }
                }
            };
            xhr.open("GET", getModDataUrl());
            xhr.send();
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



    // FUNCTIONS TO PARSE ON APP INIT
    Component.onCompleted: {
        internal.loadModData()
    }




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
            // Mid/central application area container.
            // ------------------------------------------------------------------

            // This area is used to contain the video background.
            // Qt Creator does not have support for Video playback, so
            // a placeholder image is used instead on the development process.

            Rectangle {
                id: midAreaContainer
                color: "Transparent"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topToolBar.bottom
                anchors.bottom: botToolbar.top

                ParallaxImage {
                    id: parallaxBck

                    NumberAnimation on deltaX {
                        id: animationSmootherX

                        from: parallaxBck.deltaX
                        to: internal.currentMouseX
                        duration: internal.mouseUpdate
                    }

                    NumberAnimation on deltaY {
                        id: animationSmootherY

                        from: parallaxBck.deltaY
                        to: internal.currentMouseY
                        duration: internal.mouseUpdate
                    }
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


                // WINDOW DECORATION ELEMENTS
                Text {
                    id: modName
                    color: "#cccccc"
                    text: internal.modNameLong.toUpperCase()
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    font.letterSpacing: 3
                    font.pixelSize: 14
                    anchors.leftMargin: 25
                    anchors.verticalCenterOffset: -9

                }

                Text {
                    id: developedBy
                    color: "#cccccc"
                    text: qsTr("DEVELOPED BY")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    font.letterSpacing: 1.5
                    font.pixelSize: 10
                    anchors.leftMargin: 25
                    anchors.verticalCenterOffset: 9
                }

                Text {
                    id: poweredBySIA
                    x: 811
                    y: 88
                    color: "#cccccc"
                    text: qsTr("POWERED BY SIA | PUBLIC")
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    font.letterSpacing: 1.5
                    font.pixelSize: 10
                    anchors.bottomMargin: 10
                    anchors.rightMargin: 15
                }

                Text {
                    id: modAuthor
                    color: "#cccccc"
                    text: internal.modAuthor.toUpperCase()
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: developedBy.right
                    font.letterSpacing: 3
                    font.pixelSize: 14
                    anchors.leftMargin: 6
                    anchors.verticalCenterOffset: 9
                }


                // SYSTEM EVENT HANDLERS
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

                    imageUrl: "qrc:/img/res/system/app_maximize.png"

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

                    imageUrl: "qrc:/img/res/system/app_hide.png"

                    onClicked: window.showMinimized()
                }
            }




            // ------------------------------------------------------------------
            // StackView / Application page container.
            // ------------------------------------------------------------------

            // All QML pages are loaded inside this Stack View.

            StackView {
                id: contentStack

                MouseArea {
                    id: mouseTracker

                    anchors.fill: parent
                    hoverEnabled: true
                    x: 0

                    onPositionChanged: {
                        internal.currentMouseX = Math.round(mouseX)
                        internal.currentMouseY = Math.round(mouseY)
                    }

                    onClicked: {
                        internal.currentMouseX = Math.round(mouseX)
                        internal.currentMouseY = Math.round(mouseY)
                    }
                }

                Timer {
                    interval: internal.mouseUpdate

                    running: true
                    repeat: true

                    onTriggered: {
                        if (mouseTracker.x < 1) { mouseTracker.x = 1 } else { mouseTracker.x = 0 }
                        animationSmootherX.start()
                        animationSmootherY.start()
                    }
                }

                Timer {
                    id: resetTimer
                    interval: internal.mouseUpdate
                    onTriggered: {
                        parallaxBck.deltaX = internal.currentMouseX
                        parallaxBck.deltaY = internal.currentMouseY
                    }
                }

                anchors.top: topToolBar.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

//                Rectangle {
//                    anchors.fill: parent
//                    color: "BLACK"
//                }

                initialItem: "qrc:/qml/data/qml/pageStyle/BasicIntroPage.qml"

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

    Connections {
        target: stepManager

        function onStepUpdateRequest( backendStep ) {
            console.log("STEP UPDATE REQUEST, Step Count = " + backendStep)
            internal.currentStep = backendStep

            function getModDataUrl()
            {
                return "qrc:/json/data/json/step/" + backendStep.toString() + "/modStep.json";
            }

            console.log(getModDataUrl())

            // gets which page style template should be used on next step from JSON.
            // also pushes the content stack.
            function loadModData() {
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            var modData = JSON.parse(xhr.responseText);

                            // Step title and description
                            internal.pageStyleToParse = modData.STEP.pageStyle
                            console.log("PAGE TO PARSE: " + internal.pageStyleToParse)
                            // ** //

                            backendStep = "qrc:/qml/data/qml/pageStyle/" + internal.pageStyleToParse
                            contentStack.push(backendStep)
                        }
                    }
                };
                xhr.open("GET", getModDataUrl());
                xhr.send();
            }

            loadModData()

        }

        function onTerminate_app_request()
        {
            appExit.clicked()
        }
    }
}
