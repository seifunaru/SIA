// ParallaxImage.qml

import QtQuick
import "qrc:/qml/data/qml/appControls"

Item {

    id: itemContainer
    anchors.fill: parent

    // default values, subject to main window values.
    width: 950
    height: 440
    implicitWidth: 950
    implicitHeight: 440

    // On Component created, starts loading HQ web images
    Component.onCompleted:
    {
        internal.loadModData()
        stepManager.checkCurrentModules()
    }

    // PRIVATE
    QtObject {
        id: internal

        // PRIVATE properties
        // Defined by JSON

        property int selectedModules: 0

        property string module1: ""
        property string module2: ""
        property string module3: ""
        property string module4: ""

        property string fileToInstall1: ""
        property string fileToInstall2: ""
        property string fileToInstall3: ""
        property string fileToInstall4: ""




        // PRIVATE functions

        // checks which installation modules were selected and displays the necessary info on screen.
        function checkModules()
        {
            if (selectedModules > 999) {
                activeModules.text += module1 + " · "
                selectedModules = selectedModules - 1000

                if (instDir1text.text.indexOf("Engine.ini") === -1)
                {
                    instDir1text.text += fileToInstall1 + "\n"
                }
            }

            if (selectedModules > 99) {
                activeModules.text += module2 + " · "
                selectedModules = selectedModules - 100

                if (instDir1text.text.indexOf("Engine.ini") === -1)
                {
                    instDir1text.text += fileToInstall1 + "\n"
                }
            }

            if (selectedModules > 9) {
                activeModules.text += module3 + " · "
                selectedModules = selectedModules - 10

                instDir1text.text += fileToInstall2 + "\n"
            }

            if (selectedModules > 0) {
                activeModules.text += module4 + " · "
                selectedModules = selectedModules - 1

                instDir1text.text += fileToInstall3 + "\n" + fileToInstall4
            }
        }

        // gets path to step data JSON.
        function getModDataUrl()
        {
            return "qrc:/json/data/json/step/2/modStep.json";
        }

        // gets data from JSON and defines PRIVATE properties with it.
        function loadModData() {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        var modData = JSON.parse(xhr.responseText);

                        // Step title and description
                        module1 = modData.STEP.mod1
                        module2 = modData.STEP.mod2
                        module3 = modData.STEP.mod3
                        module4 = modData.STEP.mod4

                        fileToInstall1 = modData.STEP.File1
                        fileToInstall2 = modData.STEP.File2
                        fileToInstall3 = modData.STEP.File3
                        fileToInstall4 = modData.STEP.File4

                        internal.checkModules()

                        // ** //
                    }
                }
            };
            xhr.open("GET", getModDataUrl());
            xhr.send();
        }
    }




    // PUBLIC

    Rectangle {
        id: backgroundRectangle
        color: "Transparent"
        anchors.fill: parent




        // ------------------------------------------------------------------
        // Bottom application tool bar.
        // ------------------------------------------------------------------

        Rectangle {
            id: midPageContainer
            color:"TRANSPARENT"

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: botToolBar.top
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0

            anchors.bottomMargin: 0

            Rectangle {
                id: infoContainer

                color: "#c8000000"
                radius: 15
                anchors.fill: parent
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                anchors.topMargin: 20
                anchors.bottomMargin: 20

                Rectangle {
                    id: infoBorder
                    anchors.fill: parent
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 10
                    anchors.topMargin: 10
                    color: "TRANSPARENT"
                    radius: 10
                    border.color: "WHITE"
                    border.width: 5

                    Image {
                        width: 320
                        height: 70
                        anchors.bottom: textSelectedModules.top
                        source: "qrc:/img/res/modInfo/modLogo.png"
                        anchors.bottomMargin: 10
                        anchors.horizontalCenterOffset: 0
                        fillMode: Image.PreserveAspectFit
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        id: textSelectedModules
                        color: "#ffffff"
                        text: qsTr("YOU ARE ABOUT TO INSTALL THE FOLLOWING MODULES:")
                        anchors.bottom: activeModules.top
                        font.letterSpacing: 1.5
                        font.pixelSize: 12
                        anchors.bottomMargin: 10
                        font.family: "Arial"
                        anchors.horizontalCenterOffset: 0
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        id: textInstallLocation
                        x: -7
                        color: "#ffffff"
                        text: qsTr("THEY WILL BE INSTALLED IN:")
                        anchors.top: activeModules.bottom
                        font.letterSpacing: 1.5
                        font.pixelSize: 12
                        anchors.topMargin: 10
                        anchors.horizontalCenterOffset: 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Arial"
                    }

                    Text {
                        id: activeModules
                        x: 4
                        y: 4
                        color: "#ffffff"
                        text: " · "
                        anchors.verticalCenter: parent.verticalCenter
                        font.letterSpacing: 1.5
                        font.pixelSize: 15
                        anchors.horizontalCenterOffset: 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenterOffset: 10
                        font.family: "Arial"
                    }

                    Text {
                        id: instDir1text
                        x: -16
                        color: "#ffffff"
                        text: ""
                        anchors.top: textInstallLocation.bottom
                        font.letterSpacing: 1.5
                        font.pixelSize: 12
                        anchors.topMargin: 10
                        anchors.horizontalCenterOffset: 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Arial"
                    }
                }
            }

        }




        // ------------------------------------------------------------------
        // Bottom application tool bar.
        // ------------------------------------------------------------------

        Rectangle {
            id: botToolBar
            color: "White"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            height: 110

             Button_solidSwap {
                 id: btn1
                 width: 230
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.verticalCenterOffset: 0
                 anchors.horizontalCenter: parent.horizontalCenter
                 anchors.horizontalCenterOffset: -130
                 isImageButton: false
                 btnText: "CANCEL, GO BACK"

                 onClicked: {
                     stepManager.doBackStep()
                 }
             }

             Button_solidSwap {
                 id: btn2
                 width: 230
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.verticalCenterOffset: 0
                 anchors.horizontalCenter: parent.horizontalCenter
                 anchors.horizontalCenterOffset: 130
                 isImageButton: false
                 btnText: "CONFIRM AND INSTALL"

                 onClicked: {
                    stepManager.doNextStep()
                 }
             }

             Button_solidSwap {
                 id: btn_next
                 x: 848
                 width: 80
                 height: 95
                 anchors.verticalCenter: parent.verticalCenter
                 anchors.right: parent.right
                 anchors.rightMargin: 20
                 imageUrl: "qrc:/img/res/system/next.webp"
                 imageSize: 70
                 default_button_color: "WHITE"
                 hovered_button_color: "WHITE"
                 default_textColor: "WHITE"
                 visible: false

                 onClicked: {
                     stepManager.doNextStep()
                 }
             }
        }
    }

    Connections
    {
        target: stepManager

        function onEmittedCurrentModules( moduleString )
        {
            internal.selectedModules = parseInt( moduleString )
            console.log("GOT THIS: " + internal.selectedModules)
        }
    }

}

