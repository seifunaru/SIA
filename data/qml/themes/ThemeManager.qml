import QtQuick 2.15



Item {
    property string currentTheme: "Light"

    function setTheme(theme) {
        currentTheme = theme;
    }

    function getThemeUrl() {
        return "data/qml/themes/" + currentTheme + "/Theme.json";
    }

    // New properties to store theme colors. By default, Light theme.
    property color backgroundWindowColor: "Black"
    property color foregroundWindowColor: "White"

    property color default_ButtonColor: "#f1f1f1"
    property color hovered_ButtonColor: "#f9f9f9"
    property color pressed_ButtonColor: "#24afff"
    property color default_textButtonColor: "Black"
    property color hovered_textButtonColor: "Black"
    property color pressed_textButtonColor: "Black"
    property  int  default_textSize: 9
    property  int  default_letterSpacing: 3
    property  int  button_colorTransitionTimeMs: 250

    property  int  dialogueBoxOpacity: 50
    property color dialogueBackgroundColor: "Black"
    property color dialogueBoxColor: "White"
    property color dialoguTextColor: "White"

    property int universalAppRadius: 10 //Default value for all app corners. Do not change.

    Component.onCompleted: {
        // Cargar el tema actual al inicializar
        loadTheme();
    }

    function loadTheme() {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    var themeData = JSON.parse(xhr.responseText);

                    // Assigns theme properties
                    backgroundWindowColor = themeData.MAIN_SETTINGS.BackgroundWindowColor;
                    foregroundWindowColor = themeData.MAIN_SETTINGS.ForegroundWindowColor;

                    default_ButtonColor = themeData.MAIN_SETTINGS.default_ButtonColor;
                    hovered_ButtonColor = themeData.MAIN_SETTINGS.hovered_ButtonColor;
                    pressed_ButtonColor = themeData.MAIN_SETTINGS.pressed_ButtonColor;
                    default_textButtonColor = themeData.MAIN_SETTINGS.default_textButtonColor;
                    hovered_textButtonColor = themeData.MAIN_SETTINGS.hovered_textButtonColor;
                    pressed_textButtonColor = themeData.MAIN_SETTINGS.pressed_textButtonColor;
                    default_textSize = themeData.MAIN_SETTINGS.default_textSize;
                    default_letterSpacing = themeData.MAIN_SETTINGS.default_letterSpacing;
                    button_colorTransitionTimeMs = themeData.MAIN_SETTINGS.button_colorTransitionTimeMs;

                    dialogueBoxOpacity = themeData.MAIN_SETTINGS.dialogueBoxOpacity;
                    dialogueBackgroundColor = themeData.MAIN_SETTINGS.dialogueBackgroundColor;
                    dialogueBoxColor = themeData.MAIN_SETTINGS.dialogueBoxColor;
                    dialoguTextColor = themeData.MAIN_SETTINGS.dialoguTextColor;
                    // ** //
                }
            }
        };
        xhr.open("GET", getThemeUrl());
        xhr.send();
    }
}
