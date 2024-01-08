import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import "../themes"

Button {

    // PRIVATE
    QtObject {

        id: internal

        property int gradValue: 0

    }




    // PUBLIC

    // General button color definitions.
    property color default_button_color: currentTheme.default_ButtonColor
    property color hovered_button_color: currentTheme.hovered_ButtonColor
    property color pressed_button_color: currentTheme.pressed_ButtonColor
    property  int  buttonBorderRadius: currentTheme.universalAppRadius

    // These properties are for the "image" state of the button. They are placeholders.
    property bool  isImageButton: true
    property  int  imageSize: 10
    property  url  imageUrl: "qrc:/img/res/system/app_close.png"

    // These settings are for the "text" state of the button. Based on the standard application values.
    property int   textSize: currentTheme.default_textSize
    property int   textLetterSpacing: currentTheme.default_letterSpacing
    property color default_textColor: currentTheme.default_textButtonColor
    property color hovered_textColor: currentTheme.hovered_textButtonColor
    property color pressed_textColor: currentTheme.pressed_textButtonColor
    property string btnText: "Dummie"

    // This setting turns the button into a toggleable or a click button.
    property bool isClicked: false // when  toggleable, tracks if it's clicked or not.
    property int gradientSpeed: 100 // background gradient speed for toggle mode.

    function setClicked(){
        if (isClicked) { isClicked = false; default_button_color = currentTheme.default_ButtonColor}
        else { isClicked = true; default_button_color = currentTheme.foregroundWindowColor}
    }





    // Loads current app color theme data.

    ThemeManager {
        id: currentTheme
    }




    // Button internal properties.

    id: button
    flat: true                      // for non-standard behaviors.
    Material.theme: Material.Light // to prevent uggly blue square.




    states: [

            State {
                name: "default"
                PropertyChanges { target: button_background; anchors.margins: 0 }
            },

            State {
                name: "toggleable"
                PropertyChanges { target: buttonBorder; color: currentTheme.foregroundWindowColor }
                PropertyChanges { target: button_background; anchors.margins: 2 }
            }

        ]
        state: "default"




    // Placeholder values, expected to be tweaken once constructed.
    implicitWidth: 200
    implicitHeight: 40




    // Button background Item definitions:

    background: Rectangle {
        id: buttonBorder
        radius: (buttonBorderRadius + button_background.anchors.margins)
        anchors.fill: parent
        color: "Transparent"

        LinearGradient {

            id: grad1
            visible: isClicked
            source: buttonBorder
            anchors.fill: parent
            start: Qt.point (0, 0)
            end: Qt.point (button.width, 0)

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#49b8ff" }
                GradientStop { position: 0.1; color: "#ff8bd1" }
                GradientStop { position: 0.5; color: "#ff9600" }
                GradientStop { position: 0.9; color: "#ff8bd1" }
                GradientStop { position: 1.0; color: "#49b8ff" }
            }
        }

        Rectangle {
            id: button_background
            color: default_button_color
            radius: buttonBorderRadius
            anchors.fill: parent
            anchors.margins: 0
            opacity: 1

            // Color animations for mouse interactions on Button Background

            ColorAnimation {
                id: hoverAnimation
                target: button_background
                property: "color"
                from: default_button_color
                to: hovered_button_color
                duration: currentTheme.button_colorTransitionTimeMs
            }

            ColorAnimation {
                id: exitAnimation
                target: button_background
                property: "color"
                from: hovered_button_color
                to: default_button_color
                duration: currentTheme.button_colorTransitionTimeMs
            }

            ColorAnimation {
                id: pressAnimationInit
                target: button_background
                property: "color"
                from: hovered_button_color
                to: pressed_button_color
                duration: (currentTheme.button_colorTransitionTimeMs / 2)
            }

            ColorAnimation {
                id: pressAnimationEnd
                target: button_background
                property: "color"
                from: pressed_button_color
                to: default_button_color
                duration: (currentTheme.button_colorTransitionTimeMs / 2)
            }


            // Color animations for mouse interactions on Button image

            ColorAnimation {
                id: imageHoverAnimation
                target: imageColor
                property: "color"
                to: hovered_textColor
                duration: currentTheme.button_colorTransitionTimeMs
            }

            ColorAnimation {
                id: imageExitAnimation
                target: imageColor
                property: "color"
                to: default_textColor
                duration: currentTheme.button_colorTransitionTimeMs
            }


            // Text and Image definitions for both button states.

            Text {
                id: text_container
                text: btnText
                anchors.verticalCenter: parent.verticalCenter
                font.letterSpacing: 3
                font.pointSize: 9
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Arial"
                visible: !isImageButton
            }

            Image {
                id: buttonImage
                width: imageSize
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                source: imageUrl
                fillMode: Image.PreserveAspectFit
                visible: isImageButton
            }

            ColorOverlay {
                id: imageColor
                anchors.fill: buttonImage
                source: buttonImage
                color: default_textColor
                visible: isImageButton
            }


            // Makes the mouse icon a pointing hand.

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
            }
        }
    }

    // Cursor animation triggers on Item hover and click.

    onHoveredChanged: {
        if (button.hovered) {
            hoverAnimation.start()

            if (buttonImage.visible) {
                imageHoverAnimation.start()
            }

        } else {
            exitAnimation.start()

            if (buttonImage.visible) {
                imageExitAnimation.start()
            }
        }
    }

    onClicked: {
        pressAnimationInit.start()
        pressAnimationEnd.start()
    }

    Timer {
        id: togglemodeGradientTimer

        interval: gradientSpeed; running: isClicked; repeat: true
        onTriggered: {
            if (internal.gradValue < button.width) {
                internal.gradValue += 1
                grad1.start = Qt.point(internal.gradValue, 0)
                grad1.end = Qt.point(button.width + internal.gradValue, 0)
            } else {
                internal.gradValue = -button.width
                grad1.start = Qt.point(-button.width, 0)
                grad1.end = Qt.point(0, 0)
            }
        }
    }
}
