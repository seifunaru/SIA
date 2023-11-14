import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import "../themes"

Button {

    // Loads current app color theme data.

    ThemeManager {
        id: currentTheme
    }




    // Button internal properties.

    id: button
    flat: true                      // for non-standard behaviors.
    Material.theme: Material.Light // to prevent uggly blue square.




    // The button can be either an image button, or a text button.
    states: [

        State {
            name: "image"
            PropertyChanges { target: button_logo_container ; visible: true  }
            PropertyChanges { target: text_container        ; visible: false }
        },

        State {
            name: "text"
            PropertyChanges { target: button_logo_container ; visible: false }
            PropertyChanges { target: text_container        ; visible: true  }
        }

    ]




    // General button color definitions.
    property color default_button_color: currentTheme.default_ButtonColor
    property color hovered_button_color: currentTheme.hovered_ButtonColor
    property color pressed_button_color: currentTheme.pressed_ButtonColor
    property  int  buttonBorderRadius: currentTheme.universalAppRadius

    // These properties are for the "image" state of the button. They are placeholders.
    property  int  imageSize: 10
    property  url  imageUrl: "./res/system/app_close.png"

    // These settings are for the "text" state of the button. Based on the standard application values.
    property int   textSize: currentTheme.default_textSize
    property int   textLetterSpacing: currentTheme.default_letterSpacing
    property color default_textColor: currentTheme.default_textButtonColor
    property color hovered_textColor: currentTheme.hovered_textButtonColor
    property color pressed_textColor: currentTheme.pressed_textButtonColor

    // Placeholder values, expected to be tweaken once constructed.
    state: "image"
    implicitWidth: 200
    implicitHeight: 40




    // Button background Item definitions:

    background: Rectangle {
        id: button_background
        color: default_button_color
        radius: buttonBorderRadius
        anchors.fill: parent
        opacity: 1

        states: [ "mouseIn" , "mouseOut" ]
        state: "mouseOut"


        // Color animations for mouse interactions

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
            id: pressAnimation
            target: button_background
            property: "color"
            from: hovered_button_color
            to: pressed_button_color
            duration: currentTheme.button_colorTransitionTimeMs
        }


        // Text and Image definitions for both button states.

        Text {
            id: text_container
            text: "dummie"
            anchors.verticalCenter: parent.verticalCenter
            font.letterSpacing: 3
            font.pointSize: 9
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Arial"
        }

        Image {
            id: button_logo_container
            width: imageSize
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: "../../../" + imageUrl
            fillMode: Image.PreserveAspectFit
        }


        // Makes the mouse icon a pointing hand.

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }
    }




    // Cursor animation triggers on Item hover and click.

    onHoveredChanged: {
        if (button.hovered) {
                    hoverAnimation.start()
                } else {
                    exitAnimation.start()
                }
    }

    onClicked: {
        pressAnimation.start()
    }
}
