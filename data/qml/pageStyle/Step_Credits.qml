import QtQuick 2.15

import "qrc:/qml/data/qml/appControls"

Item {
    id: cs_module

    width: 950
    height: 440
    anchors.fill: parent

    QtObject {
        id: internal

        property int stepCredits: 215

    }


    Rectangle {
        id: bg
        color: "TRANSPARENT"
        border.color: "#00000000"
        anchors.fill: parent


        Rectangle {
            id: medCon
            color: "#00000000"
            border.color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: botBar.top
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            Rectangle {
                id: rectangle
                width: 500
                color: "#00000000"
                border.color: "#00000000"
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 36
                anchors.topMargin: 84
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true

                Text {
                    id: credits
                    x: 246
                    y: 68
                    width: 458
                    height: 194
                    color: "#ffffff"
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Segoe UI'; font-size:9pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12pt;\">SnowTheBard</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12pt;\">Melodic Fortress</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12pt;\">emmanuelle </span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12pt;\">Krackcat</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12pt;\">Cody Ambrose</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12pt;\">Matthew Manley</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12pt;\">Andrethegiant</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12pt;\">Tangled_Mesh</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12pt;\">Chabs</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12pt;\">Euliemia</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12pt;\">Hector Juarez</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12pt;\">Young Phoenix</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12pt;\">Sir Bughunter</span></p></body></html>"
                    anchors.top: parent.top
                    font.letterSpacing: 1.2
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                    textFormat: Text.RichText
                    clip: false
                    anchors.topMargin: internal.stepCredits
                    font.family: "Arial"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Text {
                id: text1
                color: "#ffffff"
                text: "· SPECIAL THANKS TO MY PATREON SUPPORTERS ·"
                anchors.top: parent.top
                font.letterSpacing: 3
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                textFormat: Text.RichText
                font.underline: false
                font.family: "Arial"
            }

            Text {
                id: text2
                width: 420
                color: "#ffffff"
                text: qsTr("THESE PROJECTS WOULDN'T BE POSSIBLE WITHOUT THEM!")
                anchors.top: text1.bottom
                font.letterSpacing: 3
                font.pixelSize: 10
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 10
                font.underline: false
                font.family: "Arial"
            }

        }

        Rectangle {
            id: botBar
            x: 0
            y: 440
            height: 110
            color: "#ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0

            Button_solidSwap {
                id: donate_button
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: 110
                anchors.horizontalCenter: parent.horizontalCenter
                btnText: "DONATE"
                isImageButton: false

                onClicked: { stepManager.process_donate_button() }
            }

            Button_solidSwap {
                id: close_button
                anchors.verticalCenter: parent.verticalCenter
                btnText: "CLOSE"
                isImageButton: false
                anchors.horizontalCenterOffset: -110
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: { stepManager.process_exit_button() }
            }

        }

    }

    Timer {
        id: clk
        interval: 25; running: true; repeat: true
        onTriggered: { internal.stepCredits -= 1; credits.anchors.topMargin = internal.stepCredits }
    }

    Connections {
        target: stepManager
    }
}


