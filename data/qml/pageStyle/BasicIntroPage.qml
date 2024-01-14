
// BasicIntroPage.qml

// A basic page with a mod-logo, a button to install, and a button to
// uninstall the mod.

import QtQuick 2.15
import QtQuick.Dialogs
import "qrc:/qml/data/qml/appControls"
import "qrc:/modFile/data/modFiles"

Item {
    id: item1

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
        property string modInfoUrl: "qrc:/json/data/json/modData.json"
    }


    // PRIVATE functions

    // gets path to step data JSON.
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
                    modAuthor = modData.MOD_INFO.modVersion
                    modVersion = modData.MOD_INFO.modAuthor
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


    // Minimum page size. Expected to be handled by StackView.
    width: internal.defaultWidth
    height: internal.defaultHeight
    anchors.fill: parent

    Component.onCompleted: {
        loadModData()
    }

    ModfileInfoQml { id: modInfo }




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
                    source: "qrc:/img/res/modInfo/modLogo.png"

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

            Button_solidSwap {
                id: buttonOp1
                width: 250
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: -135
                anchors.horizontalCenter: parent.horizontalCenter

                btnText: "QUICK UNINSTALL"

                isImageButton: false

                onClicked: {
                    thisModCxx.checkModUninstallDir1("AUTO")
                }
            }

            Button_solidSwap {
                id: buttonOp2
                width: 250
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: 135
                anchors.horizontalCenter: parent.horizontalCenter

                btnText: "ASSISTED INSTALLATION"

                isImageButton: false

                onClicked: {
                    thisModCxx.checkModInstallDir1("AUTO")
                }
            }

        }

    }



    // File dialog used for engine file localization.
    FileDialog {
        id: fileDialog1
        title: "Find and select your Engine.ini file."

        onAccepted: {
            console.log("SELECTED FILE:", fileDialog1.selectedFile)
            thisModCxx.checkModInstallDir1(fileDialog1.selectedFile)
            // Puedes acceder al archivo seleccionado a través de fileDialog.fileUrls[0]
        }

        onRejected: {
            console.log("Selección de archivo cancelada")
        }
    }

    // File dialog used for exe file localization.
    FileDialog {
        id: fileDialog2
        title: "Find and select your HogwartsLegacy.exe"

        onAccepted: {
            console.log("SELECTED FILE:", fileDialog2.selectedFile)
            thisModCxx.checkModInstallDir2(fileDialog2.selectedFile)
            // Puedes acceder al archivo seleccionado a través de fileDialog.fileUrls[0]
        }

        onRejected: {
            console.log("Selección de archivo cancelada")
        }
    }




    // File dialog used for engine file localization. UNINSTALL
    FileDialog {
        id: fileDialog3
        title: "Find and select your Engine.ini file."

        onAccepted: {
            console.log("SELECTED FILE:", fileDialog1.selectedFile)
            thisModCxx.checkModUninstallDir1(fileDialog1.selectedFile)
            // Puedes acceder al archivo seleccionado a través de fileDialog.fileUrls[0]
        }

        onRejected: {
            console.log("Selección de archivo cancelada")
        }
    }

    // File dialog used for exe file localization. UNINSTALL
    FileDialog {
        id: fileDialog4
        title: "Find and select your HogwartsLegacy.exe"

        onAccepted: {
            console.log("SELECTED FILE:", fileDialog4.selectedFile)
            thisModCxx.checkModUninstallDir2(fileDialog4.selectedFile)
            // Puedes acceder al archivo seleccionado a través de fileDialog.fileUrls[0]
        }

        onRejected: {
            console.log("Selección de archivo cancelada")
        }
    }




    // Page Disabler
    // The page gets disabled when the custom message box is visible.
    Rectangle {
        id: pageDisabler
        anchors.fill: parent

        color: "#dce9e9e9"
        visible: false

        MouseArea {
            anchors.fill: parent
        }
    }




    SiaMessageBox {
        id: messageBox1
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -55
        anchors.horizontalCenter: parent.horizontalCenter

        title: "Ascendio could not find your Engine file"
        description: "Ascendio was not able to automatically find your Engine.ini file. This is usually located at %localappdata%/Hogwarts Legacy/Saved/Config/WindowsNoEditor, but in your case it's not there for some reason. You'll have to find it and select it manually."

        visible: false

        onVisibleChanged: {
            if (visible) {
                pageDisabler.visible = true
            } else {
                fileDialog1.open()
                pageDisabler.visible = false
            }
        }
    }


    SiaMessageBox {
        id: messageBox2
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -55
        anchors.horizontalCenter: parent.horizontalCenter

        title: "Ascendio could not find your Hogwarts Legacy .Exe"
        description: "Ascendio was not able to locate your Hogwarts Legacy.exe. Please, find it and select it. It's usually located at /your_steam_dir/steamapps/common/Hogwarts Legacy/HogwartsLegacy.exe"

        visible: false

        onVisibleChanged: {
            if (visible) {
                pageDisabler.visible = true
            } else {
                fileDialog2.open()
                pageDisabler.visible = false
            }
        }
    }


    SiaMessageBox {
        id: messageBox3 // uninstall
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -55
        anchors.horizontalCenter: parent.horizontalCenter

        title: "Ascendio could not find your Engine file"
        description: "Ascendio was not able to automatically find your Engine.ini file. This is usually located at %localappdata%/Hogwarts Legacy/Saved/Config/WindowsNoEditor, but in your case it's not there for some reason. You'll have to find it and select it manually."

        visible: false

        onVisibleChanged: {
            if (visible) {
                pageDisabler.visible = true
            } else {
                fileDialog3.open()
                pageDisabler.visible = false
            }
        }
    }


    SiaMessageBox {
        id: messageBox4
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -55
        anchors.horizontalCenter: parent.horizontalCenter

        title: "Ascendio could not find your Hogwarts Legacy .Exe"
        description: "Ascendio was not able to locate your Hogwarts Legacy.exe. Please, find it and select it. It's usually located at /your_steam_dir/steamapps/common/Hogwarts Legacy/HogwartsLegacy.exe"

        visible: false

        onVisibleChanged: {
            if (visible) {
                pageDisabler.visible = true
            } else {
                fileDialog4.open()
                pageDisabler.visible = false
            }
        }
    }


    SiaMessageBox {
        id: messageBox5 // Used for uninstallation
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -55
        anchors.horizontalCenter: parent.horizontalCenter

        visible: false

        onVisibleChanged: {
            if (visible) {
                pageDisabler.visible = true
            } else {
                pageDisabler.visible = false
            }
        }
    }

    SiaMessageBox {
        id: messageBox6 // Used for uninstallation
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -55
        anchors.horizontalCenter: parent.horizontalCenter

        visible: false

        onVisibleChanged: {
            if (visible) {
                pageDisabler.visible = true
            } else {
                pageDisabler.visible = false
            }
        }
    }



    // BACKEND CONNECTIONS

    Connections {
        target: stepManager

        function onFileRemoveError(error)
        {
            messageBox6.title = "Uninstallation failed."
            messageBox6.description = "One or more files could not be removed, error: " + error + "\n\nYou could try uninstalling manually."
            messageBox6.visible = true
        }

        function onUninstallFinished()
        {
            messageBox5.title = "Uninstallation Finished Successfully!."
            messageBox5.description = "Ascendio has been uninstalled from your system, you can now close this application and also delete it if you want."
            if (!messageBox6.visible) {
                messageBox5.visible = true
            }
        }
    }

    Connections {
        target: thisModCxx

        // MOD INSTALL
        function onMod_install_dir_1_isOk(response)
        {
            if (response === true) {
                stepManager.initModInstall()
            }
            else {
                messageBox1.visible = true
            }
        }


        // MOD UNINSTALL

        function onMod_uninstall_dir_1_isOk(response)
        {
            if (response === true) {
                thisModCxx.getInstallDirs();
                stepManager.initModUninstall()
            }
            else {
                messageBox3.visible = true
            }
        }

        function onEmittedInstallDirs(dir1, dir2)
        {
            stepManager.setInstallDir (dir1, dir2, modInfo.mod_intro, modInfo.fps_hotfix, modInfo.rt_hotfix)
            stepManager.initModRemove()
        }
    }
}
