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
    }

    // PRIVATE
    QtObject {
        id: internal

        // PRIVATE properties
        // Defined by JSON

        property int buttonCount: 0
        property int buttonSizeX: 0
        property int buttonTrack: 0000

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



        property url img_LQ_btn1_btn2_btn3: ""
        property url img_HQ_btn1_btn2_btn3: ""
        property url img_LQ_btn1_btn3_btn4: ""
        property url img_HQ_btn1_btn3_btn4: ""

        property url img_LQ_btn1_btn2_btn4: ""
        property url img_HQ_btn1_btn2_btn4: ""

        property url img_LQ_btn2_btn3_btn4: ""
        property url img_HQ_btn2_btn3_btn4: ""

        property url img_LQ_btn1_btn2_btn3_btn4: ""
        property url img_HQ_btn1_btn2_btn3_btn4: ""




        // PRIVATE functions

        function checkForWarnings() {
            var regex = new RegExp("\\b" + buttonTrack.toString() + "\\b")
            if (hasWarning.match(regex))
            {
                bck_warning.visible = true
            } else {
                bck_warning.visible = false
            }
        }

        // Manages which image to display, and also triggers checkForWarnings.
        function reloadImgPrev()
        {
            switch (buttonTrack)
            {
            case 0000:
                lowRes.source  = "../../../" + img_LQ_vanilla
                highRes.source = img_HQ_vanilla
                comment_txt.text = description
                break;

            case 1000:
                lowRes.source  = "../../../" + img_LQ_btn1
                highRes.source = img_HQ_btn1
                break;

            case 0100:
                lowRes.source  = "../../../" + img_LQ_btn2
                highRes.source = img_HQ_btn2
                break;

            case 0010:
                lowRes.source  = "../../../" + img_LQ_btn3
                highRes.source = img_HQ_btn3
                break;

            case 0001:
                lowRes.source  = "../../../" + img_LQ_btn4
                highRes.source = img_HQ_btn4
                break;

            case 1100:
                lowRes.source  = "../../../" + img_LQ_btn1_btn2
                highRes.source = img_HQ_btn1_btn2
                break;

            case 1010:
                lowRes.source  = "../../../" + img_LQ_btn1_btn3
                highRes.source = img_HQ_btn1_btn3
                break;

            case 1001:
                lowRes.source  = "../../../" + img_LQ_btn1_btn4
                highRes.source = img_HQ_btn1_btn4
                break;

            case 0110:
                lowRes.source  = "../../../" + img_LQ_btn2_btn3
                highRes.source = img_HQ_btn2_btn3
                break;

            case 0101:
                lowRes.source  = "../../../" + img_LQ_btn2_btn4
                highRes.source = img_HQ_btn2_btn4
                break;

            case 0111:
                lowRes.source  = "../../../" + img_LQ_btn2_btn3_btn4
                highRes.source = img_HQ_btn2_btn3_btn4
                break;

            case 0011:
                lowRes.source  = "../../../" + img_LQ_btn3_btn4
                highRes.source = img_HQ_btn3_btn4
                break;

            case 1110:
                lowRes.source  = "../../../" + img_LQ_btn1_btn2_btn3
                highRes.source = img_HQ_btn1_btn2_btn3
                break;

            case 1011:
                lowRes.source  = "../../../" + img_LQ_btn1_btn3_btn4
                highRes.source = img_HQ_btn1_btn3_btn4
                break;

            case 1101:
                lowRes.source  = "../../../" + img_LQ_btn1_btn2_btn4
                highRes.source = img_HQ_btn1_btn2_btn4
                break;

            case 1111:
                lowRes.source  = "../../../" + img_LQ_btn1_btn2_btn3_btn4
                highRes.source = img_HQ_btn1_btn2_btn3_btn4
                break;
            }

            checkForWarnings()
            console.log("CURRENT BUTTON TRACK: " + buttonTrack.toString())
            console.log("CURRENT WARNING CONDITION: " + hasWarning)
            if (buttonTrack === 0) { btn_next.visible = false } else { btn_next.visible = true }
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
                        var modData = JSON.parse(xhr.responseText);

                        // Step title and description
                        internal.title = modData.STEP.title
                        internal.description = modData.STEP.description


                        // Buttons title and description
                        btn1_text = modData.STEP.button1_text
                        btn1_comment= modData.STEP.button1_comment

                        btn2_text = modData.STEP.button2_text
                        btn2_comment= modData.STEP.button2_comment

                        btn3_text = modData.STEP.button3_text
                        btn3_comment= modData.STEP.button3_comment

                        btn4_text = modData.STEP.button4_text
                        btn4_comment= modData.STEP.button4_comment

                        hasWarning = modData.STEP.step_warning
                        warning_txt.text = modData.STEP.warning_message


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


                        img_LQ_btn1_btn2_btn3 = modData.STEP.image_LQ_btn1_btn2_btn3
                        img_HQ_btn1_btn2_btn3 = modData.STEP.image_HQ_btn1_btn2_btn3

                        img_LQ_btn1_btn3_btn4 = modData.STEP.image_LQ_btn1_btn3_btn4
                        img_HQ_btn1_btn3_btn4 = modData.STEP.image_HQ_btn1_btn3_btn4

                        img_LQ_btn1_btn2_btn4 = modData.STEP.image_LQ_btn1_btn2_btn4
                        img_HQ_btn1_btn2_btn4 = modData.STEP.image_HQ_btn1_btn2_btn4

                        img_LQ_btn2_btn3_btn4 = modData.STEP.image_LQ_btn2_btn3_btn4
                        img_HQ_btn2_btn3_btn4 = modData.STEP.image_LQ_btn2_btn3_btn4

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
                source: "../../../" + "res/step/1/LQ_vanilla.webp"
                onSourceChanged: {
                    checkImgLod.start()
                }
            }

            Image {
                id: highRes
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                source: internal.img_HQ_vanilla
                visible: false
            }

            Timer {
                id: checkImgLod
                running: true
                interval: 100
                onTriggered: {
                    if (highRes.status !== 1) {
                        checkImgLod.start()
                        highRes.visible = false
                    }else {
                        highRes.visible = true
                    }
                }
            }

            Rectangle {
                id: bck_warning
                y: 214
                width: 300
                height: 30 + warning_txt.height
                color: "#99b30000"
                radius: 10
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 8
                anchors.bottomMargin: 8

                visible:false

                Rectangle {
                    id: brd_warning
                    color: "#00ffffff"
                    radius: 10
                    border.color: "#ffffff"
                    border.width: 5
                    anchors.fill: parent
                    anchors.margins: 5

                    Text {
                        id: warning_txt
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
                        text: internal.description
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

                    if( isClicked )
                    {
                        internal.buttonTrack += 1000
                    } else {
                        internal.buttonTrack -= 1000
                    }

                    internal.reloadImgPrev()
                }

                onHoveredChanged: {
                    if (comment_txt.text === internal.btn1_comment) {
                        comment_txt.text = internal.description
                    } else {
                        comment_txt.text = internal.btn1_comment
                    }
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

                    if( isClicked )
                    {
                        internal.buttonTrack += 100
                    } else {
                        internal.buttonTrack -= 100
                    }

                    internal.reloadImgPrev()
                }

                onHoveredChanged: {
                    if (comment_txt.text === internal.btn2_comment) {
                        comment_txt.text = internal.description
                    } else {
                        comment_txt.text = internal.btn2_comment
                    }
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

                    if( isClicked )
                    {
                        internal.buttonTrack += 10
                        comment_txt.text = internal.btn3_comment
                    } else {
                        internal.buttonTrack -= 10
                        comment_txt.text = internal.description
                    }

                    internal.reloadImgPrev()
                }

                onHoveredChanged: {
                    if (comment_txt.text === internal.btn3_comment) {
                        comment_txt.text = internal.description
                    } else {
                        comment_txt.text = internal.btn3_comment
                    }
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

                    if( isClicked )
                    {
                        internal.buttonTrack += 1
                    } else {
                        internal.buttonTrack -= 1
                    }

                    internal.reloadImgPrev()
                }

                onHoveredChanged: {
                    if (comment_txt.text === internal.btn4_comment) {
                        comment_txt.text = internal.description
                    } else {
                        comment_txt.text = internal.btn4_comment
                    }
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
                visible: false

                onClicked: {
                    stepManager.doNextStep()
                }
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

                onClicked:  {
                    stepManager.doBackStep()
                }
            }

            Text {
                id: title_text
                text: internal.title
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

    Connections { target: stepManager }

}
