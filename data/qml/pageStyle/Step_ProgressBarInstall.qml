import QtQuick 2.15
import "../appControls"
import "qrc:/modFile/data/modFiles"

Item {

    id: item1

    width: 950
    height: 440
    anchors.fill: parent

    Component.onCompleted: {
        thisModCxx.getInstallDirs()
    }

    ModfileInfoQml{ id: modinfo }

    // CUSTOM PROPERTIES
    property bool mdbGoodToGo: false

    Rectangle {
        id: windowBg
        opacity: 1
        visible: true
        color: "TRANSPARENT"
        border.color: "#00000000"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        Rectangle {
            id: newsPage
            x: 10
            visible: true
            color: "#00000000"
            radius: 10
            border.color: "WHITE"
            border.width: 5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: botBar.top
            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 10

            ProgressBarGradient {
                id: installProgress
                width: 712
                height: 28
                anchors.verticalCenter: parent.verticalCenter
                progressCount: 1
                backgroundColor: "#ffffff"
                anchors.verticalCenterOffset: 58
                anchors.horizontalCenter: parent.horizontalCenter

            }




            Rectangle {
                id: descriptionBg
                color: "#00000000"
                radius: 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.bottomMargin: 41
                anchors.topMargin: 55

                Image {
                    id: img
                    width: 447
                    height: 95
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/img/res/modInfo/modLogo.png"
                    anchors.verticalCenterOffset: -50
                    anchors.horizontalCenterOffset: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    fillMode: Image.PreserveAspectFit
                }



            }

            Rectangle {
                id: downloadingStateWindow
                width: 483
                height: 196
                visible: false
                color: "#ffffff"
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: text1
                    text: qsTr("DOWNLOADING & INSTALLING")
                    anchors.top: parent.top
                    font.letterSpacing: 5
                    font.pixelSize: 18
                    anchors.topMargin: 30
                    anchors.horizontalCenterOffset: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: "Roboto Medium"
                }

                Text {
                    id: desc2
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:10pt;\">Please, wait patiently while the application downloads and install the latest version available of the mod from the Database.</span></p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:10pt;\"><br /></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:10pt;\">This window will close when the proccess is finished, it can take a few seconds.</span></p></body></html>"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.letterSpacing: 3
                    font.pixelSize: 16
                    wrapMode: Text.Wrap
                    anchors.rightMargin: 15
                    anchors.leftMargin: 15
                    textFormat: Text.RichText
                    font.family: "Roboto"
                    anchors.topMargin: 72
                }
            }

            Text {
                id: progressStatus
                x: 108
                y: 176
                color: "#ffffff"
                text: qsTr("| 000% | PROGRESS: MANAGING DIRECTORIES...")
                anchors.bottom: installProgress.top
                font.letterSpacing: 1.5
                font.pixelSize: 12
                anchors.bottomMargin: 6
                font.wordSpacing: 0
                font.family: "Arial"
            }


        }

        Rectangle {
            id: botBar
            x: 0
            y: 330
            height: 110
            color: "#ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0

            Button_solidSwap {
                id: nextStep
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                btnText: "FINISH"
                isImageButton: false

                visible: false //turns visible on 100p progress.

                onClicked: {
                    stepManager.doNextStep()
                }

            }
        }


    }



    Connections {
        target: stepManager

        function onInstallationProgressAt20p()
        {
            installProgress.progressCount = 20
            progressStatus.text = qsTr("| 020% | PROGRESS: FPS HOTFIX UNPACKED SUCCESSFULLY...")
        }

        function onInstallationProgressAt40p()
        {
            installProgress.progressCount = 40
            progressStatus.text = qsTr("| 040% | PROGRESS: RT HOTFIX UNPACKED SUCCESSFULLY...")
        }

        function onInstallationProgressAt60p()
        {
            installProgress.progressCount = 60
            progressStatus.text = qsTr("| 060% | PROGRESS: GAMEUSERSETTINGS.INI HAS BEEN SYNCED...")
        }

        function onInstallationProgressAt80p()
        {
            installProgress.progressCount = 80
            progressStatus.text = qsTr("| 080% | PROGRESS: NUKEM9'S FRAMEGEN UNPACKED SUCCESSFULLY...")
        }

        function onInstallationProgressAt100p()
        {
            installProgress.progressCount = 100
            progressStatus.text = qsTr("| 100% | PROGRESS: ASCENDIO HAS BEEN SUCCESSFULLY INSTALLED.")
            nextStep.visible = true
        }

    }

    Connections
    {
        target: thisModCxx

        function onEmittedInstallDirs(dir1, dir2)
        {
            stepManager.setInstallDir (dir1, dir2, modinfo.mod_intro, modinfo.fps_hotfix, modinfo.rt_hotfix)
            stepManager.initModUnpack()
        }
    }

}
