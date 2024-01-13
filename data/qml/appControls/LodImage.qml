import QtQuick

Item {

    // PUBLIC
    property url lqsource: "res/step/1/LQ_vanilla.webp"
    property url hqsource: "res/step/1/LQ_btn1.webp"

    Rectangle {
        anchors.fill: parent

        Image {
            id: lowRes
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "../../../" + lqsource
        }

        Image {
            id: highRes
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            visible: false
            source: hqsource
        }
    }


    Timer {
        id: resTimer
        running: true
        interval: 1500  // Enough time for HQ image to get loaded.
        onTriggered: {
            highRes.visible = true
            lowRes.visible = false
            console.log("imageUpdated")
        }
    }

}
