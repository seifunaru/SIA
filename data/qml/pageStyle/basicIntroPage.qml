
// BasicIntroPage.qml

// A basic page with a mod-logo, a button to install, and a button to
// uninstall the mod.

import QtQuick 2.15

Item {

    // ------------------------------------------------------------------
    // Page Properties
    // ------------------------------------------------------------------

    // PUBLIC properties

    property string modNameShrt: ""
    property string modNameLong: ""
    property string modAuthor: ""
    property string modVersion: ""
    property string modGame: ""
    property url modLogoImgUrl: ""
    property string expectedModInstallDir: ""
    property string modInstallDir: ""

    property int modLogoWidth:  690 // Default values,
    property int modLogoHeight: 145 // can be tweaken on construction




    // PRIVATE properties : Handled by QtObject / Internal

    QtObject {
        id: internal

        property int defaultWidth: 950
        property int defaultHeight: 440
        property string modInfoUrl: "../../../data/modData.json"
    }


    // Minimum page size. Expected to be handled by StackView.
    width: internal.defaultWidth
    height: internal.defaultHeight
    anchors.fill: parent

    Component.onCompleted: {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", internal.modInfoUrl);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                var modInfo = JSON.parse(xhr.responseText);

                modNameShrt = modInfo.MOD_INFO.modNameShort
                modNameLong = modInfo.MOD_INFO.modNameLong
                modVersion = modInfo.MOD_INFO.modVersion
                modAuthor = modInfo.MOD_INFO.modAuthor
                modGame = modInfo.MOD_INFO.modGame
                modLogoImgUrl = modInfo.MOD_INFO.modLogoImgUrl
                expectedModInstallDir = modInfo.MOD_INFO.expectedModInstallDir
                modInstallDir = modInfo.MOD_INFO.modInstallDir

                console.log("CHECK THIS OUT: ")
                console.log(modLogoImgUrl)
                modLogo.source = ("../../../" + modLogoImgUrl)
            }
        }

        xhr.send();
    }




    // ------------------------------------------------------------------
    // Page Container
    // ------------------------------------------------------------------

    // This rectangle contains all the page information.

    Rectangle {

        id: pageContainer
        color: "Transparent"          // Can be set to "Black" for page preview.
        anchors.fill: parent




        // ------------------------------------------------------------------
        // Middle Area Container
        // ------------------------------------------------------------------

        // This is the middle area. Usually contains media files related to
        // the page.

        Rectangle {

            id: midArea
            color: "Transparent"

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: botToolbar.top
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0

            Rectangle {
                id: midAreaBorder
                color: "Transparent"
                radius: 10
                border.color: "#ffffff"
                border.width: 5

                anchors.fill: parent
                anchors.margins: 10

                Image {
                    id: modLogo
                    source: ""

                    x: 114
                    y: 72
                    width: 690
                    height: 145
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    fillMode: Image.PreserveAspectFit
                }
            }

        }




        // ------------------------------------------------------------------
        // Bot Page Toolbar
        // ------------------------------------------------------------------

        // This bottom toolbar overwrites the Main.qml toolbar. It contains
        // page-specific buttons and interactions.

        Rectangle {

            id: botToolbar

            height: 110
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0



        }

    }

}
