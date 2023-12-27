// ParallaxImage.qml

import QtQuick
import "../appControls"

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
        internal.reloadImgPrev()
    }

    // PRIVATE
    QtObject {
        id: internal

        // PRIVATE properties
        // Defined by JSON

        property int buttonCount: 0
        property int buttonSizeX: 0

        property string hasWarning: ""
        property string warningMessage: ""

        property string title: ""
        property string description: ""

        property string btn1_text: ""
        property string btn1_comment: ""

        property string btn2_text: ""
        property string btn2_comment: ""

        property string btn3_text:""
        property string btn3_comment:""

        property string btn4_text:""
        property string btn4_comment:""


        // IMAGE URLS:
        // Defined by JSON

        property url img_LQ_vanilla: ""
        property url img_HQ_vanilla: ""

        property url img_LQ_btn1: ""
        property url img_HQ_btn1: ""

        property url img_LQ_btn2: ""
        property url img_HQ_btn2: ""

        property url img_LQ_btn3: ""
        property url img_HQ_btn3: ""

        property url img_LQ_btn4: ""
        property url img_HQ_btn4: ""



        property url img_LQ_btn1_btn2: ""
        property url img_HQ_btn1_btn2: ""

        property url img_LQ_btn1_btn3: ""
        property url img_HQ_btn1_btn3: ""

        property url img_LQ_btn1_btn4: ""
        property url img_HQ_btn1_btn4: ""



        property url img_LQ_btn2_btn3: ""
        property url img_HQ_btn2_btn3: ""

        property url img_LQ_btn2_btn4: ""
        property url img_HQ_btn2_btn4: ""



        property url img_LQ_btn3_btn4: ""
        property url img_HQ_btn3_btn4: ""



        property url img_LQ_btn1_btn3_btn4: ""
        property url img_HQ_btn1_btn3_btn4: ""

        property url img_LQ_btn1_btn2_btn4: ""
        property url img_HQ_btn1_btn2_btn4: ""

        property url img_LQ_btn1_btn2_btn3_btn4: ""
        property url img_HQ_btn1_btn2_btn3_btn4: ""




        // PRIVATE functions

        function reloadImgPrev()
        {
            previewImage.lqsource = img_LQ_vanilla
            previewImage.hqsource = img_HQ_vanilla
        }

        // gets path to step data JSON.
        function getModDataUrl()
        {
            return "../../json/step/1/modStep.json";
        }

        // gets data from JSON and defines PRIVATE properties with it.
        function loadModData() {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        console.log("JSON CONTENT: \n" + xhr.responseText)
                        var modData = JSON.parse(xhr.responseText);

                        // Step title and description
                        title_text.text = modData.STEP.title
                        comment_txt.text = modData.STEP.description


                        // Buttons title and description
                        btn1_text = modData.STEP.button1_text
                        btn1_comment= modData.STEP.button1_comment

                        btn2_text = modData.STEP.button2_text
                        btn2_comment= modData.STEP.button2_comment

                        btn3_text = modData.STEP.button3_text
                        btn3_comment= modData.STEP.button3_comment

                        btn4_text = modData.STEP.button4_text
                        btn4_comment= modData.STEP.button4_comment


                        // Image Paths
                        img_LQ_vanilla = modData.STEP.image_LQ_vanilla
                        img_HQ_vanilla = modData.STEP.image_HQ_vanilla

                        img_LQ_btn1 = modData.STEP.image_LQ_btn1
                        img_HQ_btn1 = modData.STEP.image_HQ_btn1

                        img_LQ_btn2 = modData.STEP.image_LQ_btn2
                        img_HQ_btn2 = modData.STEP.image_HQ_btn2

                        img_LQ_btn3 = modData.STEP.image_LQ_btn3
                        img_HQ_btn3 = modData.STEP.image_HQ_btn3

                        img_LQ_btn4 = modData.STEP.image_LQ_btn4
                        img_HQ_btn4 = modData.STEP.image_HQ_btn4


                        img_LQ_btn1_btn2 = modData.STEP.image_LQ_btn1_btn2
                        img_HQ_btn1_btn2 = modData.STEP.image_HQ_btn1_btn2

                        img_LQ_btn1_btn3 = modData.STEP.image_LQ_btn1_btn3
                        img_HQ_btn1_btn3 = modData.STEP.image_HQ_btn1_btn3

                        img_LQ_btn1_btn4 = modData.STEP.image_LQ_btn1_btn4
                        img_HQ_btn1_btn4 = modData.STEP.image_HQ_btn1_btn4


                        img_LQ_btn2_btn3 = modData.STEP.image_LQ_btn2_btn3
                        img_HQ_btn2_btn3 = modData.STEP.image_HQ_btn2_btn3

                        img_LQ_btn2_btn4 = modData.STEP.image_LQ_btn2_btn4
                        img_HQ_btn2_btn4 = modData.STEP.image_HQ_btn2_btn4


                        img_LQ_btn3_btn4 = modData.STEP.image_LQ_btn3_btn4
                        img_HQ_btn3_btn4 = modData.STEP.image_HQ_btn3_btn4

                        img_LQ_btn1_btn3_btn4 = modData.STEP.image_LQ_btn1_btn3_btn4
                        img_HQ_btn1_btn3_btn4 = modData.STEP.image_HQ_btn1_btn3_btn4

                        img_LQ_btn1_btn2_btn4 = modData.STEP.image_LQ_btn1_btn3_btn4
                        img_HQ_btn1_btn2_btn4 = modData.STEP.image_HQ_btn1_btn3_btn4

                        img_LQ_btn1_btn2_btn3_btn4 = modData.STEP.image_LQ_btn1_btn2_btn3_btn4
                        img_HQ_btn1_btn2_btn3_btn4 = modData.STEP.image_HQ_btn1_btn2_btn3_btn4

                        // ** //
                    }
                }
            };
            xhr.open("GET", getModDataUrl());
            xhr.send();
        }
    }

    function generateButtons()
    {
        // Button position when there are 2/4 buttons visible on this template.
        if (buttonCount === 2) {
            btn1.anchors.horizontalCenterOffset = -(buttonSizeX/2)-10
            btn2.anchors.horizontalCenterOffset = +(buttonSizeX/2)+10
        }

        // Button position when there are 3/4 buttons visible on this template.
        if (buttonCount === 3) {
            btn1.anchors.horizontalCenterOffset = -(buttonSizeX)-10
            btn2.anchors.horizontalCenterOffset = 0
            btn3.anchors.horizontalCenterOffset = -(buttonSizeX)+10
        }

        // Button position when there are 4/4 buttons visible on this template.
        if (buttonCount === 4) {
            btn1.anchors.horizontalCenterOffset = -buttonSizeX-(buttonSizeX/2)-30
            btn2.anchors.horizontalCenterOffset = -(buttonSizeX/2)-10
            btn3.anchors.horizontalCenterOffset = +(buttonSizeX/2)+10
            btn4.anchors.horizontalCenterOffset = +buttonSizeX+(buttonSizeX/2)+30
        }
    }

    Timer { // This timer gives time to the app to load the web viewer.
        id: webTimer
        interval: 7000
        onTriggered: {
            console.log("TIMER TRIGGER")
            internal.lowResUpdate = false
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
            color:"Black"

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: botToolBar.top
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0

            anchors.bottomMargin: 0

            Image {
                id: lowRes
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                source: "../../../" + internal.img_LQ_vanilla
                onSourceChanged: imgLODtimer.restart()
            }

            Image {
                id: highRes
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                source: internal.img_HQ_vanilla
                visible: false
            }

            Timer {
                id: imgLODtimer
                running: true
                interval: 1500
                onTriggered: {
                    lowRes.visible = false
                    highRes.visible = true
                    console.log("IMG Updated")
                }
            }

            Rectangle {
                id: bck_comment
                y: 214
                width: 300
                height: 30 + comment_txt.height
                color: "#99000000"
                radius: 10
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 8
                anchors.bottomMargin: 8

                Rectangle {
                    id: brd_comment
                    color: "#00ffffff"
                    radius: 10
                    border.color: "#ffffff"
                    border.width: 5
                    anchors.fill: parent
                    anchors.margins: 5

                    Text {
                        id: comment_txt
                        y: 10
                        width: 270
                        color: "#ffffff"
                        text: qsTr(" dummie")
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        font.pixelSize: 12
                        wrapMode: Text.Wrap
                        fontSizeMode: Text.VerticalFit
                        anchors.bottomMargin: 10
                        font.family: "Arial"
                        anchors.margins: 10
                        font.letterSpacing: 2
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
                width: 160
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -270
                isImageButton: false
                state: 'toggleable'
                btnText: internal.btn1_text

//                onHoveredChanged: {
//                    if (isHovered) {
//                        lowRes.visible = true
//                        highRes.visible=false

//                        // NECESITA CONDICIONAL PARA NO CAMBIAR SOURCE SI YA ESTÁ ELEGIDO
//                        lowRes.source = "../../../" + internal.img_LQ_btn1
//                    }
//                }



                onClicked: {
                    setClicked()
                }
            }

            Button_solidSwap {
                id: btn2
                width: 160
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -90
                isImageButton: false
                state: 'toggleable'
                btnText: internal.btn2_text

                onClicked: {
                    setClicked()
                }
            }

            Button_solidSwap {
                id: btn3
                width: 160
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 90
                isImageButton: false
                state: 'toggleable'
                btnText: internal.btn3_text

                onClicked: {
                    setClicked()
                }
            }

            Button_solidSwap {
                id: btn4
                width: 160
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 270
                isImageButton: false
                state: 'toggleable'
                btnText: internal.btn4_text

                onClicked: {
                    setClicked()
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
                imageUrl: "./res/system/next.webp"
                imageSize: 70
                default_button_color: "WHITE"
                hovered_button_color: "WHITE"
                default_textColor: "WHITE"
            }

            Button_solidSwap {
                id: btn_back
                width: 80
                height: 95
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
                imageUrl: "./res/system/back.webp"
                imageSize: 70
                default_button_color: "WHITE"
                hovered_button_color: "WHITE"
                default_textColor: "WHITE"
            }

            Text {
                id: title_text
                text: qsTr("")
                anchors.verticalCenter: parent.verticalCenter
                font.letterSpacing: 3
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenterOffset: -28
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Arial"
            }
        }
    }

}
