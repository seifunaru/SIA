// ParallaxImage.qml

import QtQuick

Item {

    id: itemContainer
    anchors.fill: parent

    // PRIVATE
    QtObject {
        id: internal

        property bool lowResVisible: true

        function getHqImgOnWebInit()
        {
            console.log("FUNCTION TRIGGER")
            webTimer.start()
        }

        function getModDataUrl() {
            return "../../json/modData.json";
        }

        function loadModData() {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        var modData = JSON.parse(xhr.responseText);

                        // Assigns parallax image URLs from modData json.
                        image1HQ_url = modData.MOD_MEDIA.modParallaxImg1;
                        image2HQ_url = modData.MOD_MEDIA.modParallaxImg2;
                        image3HQ_url = modData.MOD_MEDIA.modParallaxImg3;
                        image4HQ_url = modData.MOD_MEDIA.modParallaxImg4;
                        // ** //
                    }
                }
            };
            xhr.open("GET", getModDataUrl());
            xhr.send();
        }
    }

    Timer { // This timer gives time to the app to load the web viewer.
        id: webTimer
        interval: 7000
        onTriggered: {
            console.log("TIMER TRIGGER")
            internal.lowResVisible = false
        }
    }




    // PUBLIC

    // path to depth images. 1 = far, 4 = near.
    property url image1_url: "../../../res/parallaxIntro/parallaxLr1.webp"
    property url image2_url: "../../../res/parallaxIntro/parallaxLr2.webp"
    property url image3_url: "../../../res/parallaxIntro/parallaxLr3.webp"
    property url image4_url: "../../../res/parallaxIntro/parallaxLr4.webp"

    // path to high quality web depth images to be retrieved as background process.
    property url image1HQ_url: ""
    property url image2HQ_url: ""
    property url image3HQ_url: ""
    property url image4HQ_url: ""

    // parallax effect properties
    property real amplitude: 0.02
    property real frequency: 0.02
    property real mouseMoveAmp: 0.1
    property int mouseMoveArea: 50
    property real appCenterX: parent.width/2
    property real appCenterY: parent.height/2

    property int deltaX: 0
    property int deltaY: 0

    // default values, subject to main window values.
    implicitWidth: 950
    implicitHeight: 330




    // On Component created, starts loading HQ web images
    Component.onCompleted: {
        internal.getHqImgOnWebInit()
        internal.loadModData()
    }




    // IMAGE 1 : near

    Rectangle {

        id: image1_parallaxMoveArea
        anchors.fill: parent

        // Parallax movement:
        // Tweaks image container margins based on mouse position to produce layer-based movement.

        anchors.leftMargin: {
            -mouseMoveArea +((1 - (((deltaX*100)/appCenterX) / 100)) * 100) * mouseMoveAmp  // if mouse is at left, inverts percentage.
        }

        anchors.rightMargin: {
            -mouseMoveArea -((1 - (((deltaX*100)/appCenterX) / 100)) * 100) * mouseMoveAmp  // inverted results for right margin.
        }

        anchors.topMargin: {
            -mouseMoveArea +((1 - (((deltaY*100)/appCenterY) / 100)) * 100) * mouseMoveAmp // if mouse is at top, inverts percentage.
        }

        anchors.bottomMargin: {
            -mouseMoveArea -((1 - (((deltaY*100)/appCenterY) / 100)) * 100) * mouseMoveAmp  // inverted results for bottom margin.
        }

        Image{

            // High resolution image. Needs time to get loaded.
            // Is visible once webItem timer is ready.

            id: image1_highResItem
            source: image1HQ_url
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent

            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0

        }

        Image{

            // Embedded low resolution placeholder.
            // Is turned invisible once webItem timer is ready.

            id: image1_lowResItem
            source: image1_url
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent

            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0

            visible: internal.lowResVisible

        }
    }




    // IMAGE 2 : not so far
    // amplitude is multiplied by 2 to accentuate distance

    Rectangle{

        id: image2_parallaxMoveArea
        anchors.fill: parent
        color: "Transparent"

        // Parallax movement:
        // Tweaks image container margins based on mouse position to produce layer-based movement.

        anchors.leftMargin: {
            -mouseMoveArea +((1 - (((deltaX*100)/appCenterX) / 100)) * 100) * (mouseMoveAmp/1.5)  // if mouse is at left, inverts percentage.
        }                                                                                         // effect divided by 1.5 to accentuate distance

        anchors.rightMargin: {
            -mouseMoveArea -((1 - (((deltaX*100)/appCenterX) / 100)) * 100) * (mouseMoveAmp/1.5)  // inverted results for right margin.
        }

        anchors.topMargin: {
            -mouseMoveArea +((1 - (((deltaY*100)/appCenterY) / 100)) * 100) * (mouseMoveAmp/1.5) // if mouse is at top, inverts percentage.
        }

        anchors.bottomMargin: {
            -mouseMoveArea -((1 - (((deltaY*100)/appCenterY) / 100)) * 100) * (mouseMoveAmp/1.5)  // inverted results for bottom margin.
        }

        Image{

            // High resolution image. Needs time to get loaded.
            // Is visible once webItem timer is ready.

            id: image2_highResItem
            source: image2HQ_url
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent

            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0

        }

        Image{

            // Embedded low resolution placeholder.
            // Is turned invisible once webItem timer is ready.

            id: image2_lowResItem
            source: image2_url
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent

            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0

            visible: internal.lowResVisible

        }
    }




    // IMAGE 3 : not so near
    // amplitude is multiplied by 3 to accentuate distance

    Rectangle {

        id: image3_parallaxMoveArea
        anchors.fill: parent
        color: "Transparent"

        // Parallax movement is based on image margins for a responsive result.
        anchors.leftMargin: {
            -mouseMoveArea +((1 - (((deltaX*100)/appCenterX) / 100)) * 100) * (mouseMoveAmp/2)  // if mouse is at left, inverts percentage.
        }                                                                                         // effect divided by 2.0 to accentuate distance

        anchors.rightMargin: {
            -mouseMoveArea -((1 - (((deltaX*100)/appCenterX) / 100)) * 100) * (mouseMoveAmp/2)  // inverted results for right margin.
        }

        anchors.topMargin: {
            -mouseMoveArea +((1 - (((deltaY*100)/appCenterY) / 100)) * 100) * (mouseMoveAmp/2) // if mouse is at top, inverts percentage.
        }

        anchors.bottomMargin: {
            -mouseMoveArea -((1 - (((deltaY*100)/appCenterY) / 100)) * 100) * (mouseMoveAmp/2)  // inverted results for bottom margin.
        }

        Image{

            // High resolution image. Needs time to get loaded.
            // Is visible once webItem timer is ready.

            id: image3_highResItem
            source: image3HQ_url
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent

            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0

        }

        Image{

            // Embedded low resolution placeholder.
            // Is turned invisible once webItem timer is ready.

            id: image3_lowResItem
            source: image3_url
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent

            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0

            visible: internal.lowResVisible

        }
    }




    // IMAGE 4 : near
    // amplitude is multiplied by 4 to accentuate distance

    Rectangle {

        id: image4container
        anchors.fill: parent
        color: "Transparent"

        // Parallax movement is based on image margins for a responsive result.
        anchors.leftMargin: {
            -mouseMoveArea +((1 - (((deltaX*100)/appCenterX) / 100)) * 100) * (mouseMoveAmp/2.5)  // if mouse is at left, inverts percentage.
        }                                                                                         // effect divided by 2.5 to accentuate distance

        anchors.rightMargin: {
            -mouseMoveArea -((1 - (((deltaX*100)/appCenterX) / 100)) * 100) * (mouseMoveAmp/2.5)  // inverted results for right margin.
        }

        anchors.topMargin: {
            -mouseMoveArea +((1 - (((deltaY*100)/appCenterY) / 100)) * 100) * (mouseMoveAmp/2.5) // if mouse is at top, inverts percentage.
        }

        anchors.bottomMargin: {
            -mouseMoveArea -((1 - (((deltaY*100)/appCenterY) / 100)) * 100) * (mouseMoveAmp/2.5)  // inverted results for bottom margin.
        }

        Image{

            // High resolution image. Needs time to get loaded.
            // Is visible once webItem timer is ready.

            id: image4_highResItem
            source: image4HQ_url
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent

            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0

        }

        Image{

            // Embedded low resolution placeholder.
            // Is turned invisible once webItem timer is ready.

            id: image4_lowResItem
            source: image4_url
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent

            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0

            visible: internal.lowResVisible

        }
    }




    // ---------------------------------------------------------------------
    //                 IMAGE 1 MEDIUM CLOSE-UP ANIMATION
    // ---------------------------------------------------------------------

    // As this application has a responsive design, these animations are
    // accomplished by tweaking anchor margins, and not positions.

    // (X) Horizontal close-up Animation

    SequentialAnimation { //left margin
        running: true

        NumberAnimation // go
        {
            targets: [image1_lowResItem, image1_highResItem]
            property: "anchors.leftMargin"
            from: -(parent.width * amplitude )  // Initial point, Max zoom. Relative to tweakable amplitude
            to:  0                              // Final point, Min zoom.
            duration: 500 / frequency           // Animation Speed, based on tweakable frequency (0.0x)
            easing.type: Easing.CosineCurve
        }

        NumberAnimation // return
        {
            targets: [image1_lowResItem, image1_highResItem]
            property: "anchors.leftMargin"
            from:  0                            // Final point, Min zoom.
            to: -(parent.width * amplitude )    // Initial point, Max zoom. Relative to tweakable amplitude.
            duration: 500 / frequency           // Frequency based Animation Speed (0.0x).
            easing.type: Easing.CosineCurve
        }

        loops: Animation.Infinite
    }

    SequentialAnimation { // right margin
        running: true

        NumberAnimation // go
        {
            targets: [image1_lowResItem, image1_highResItem]
            property: "anchors.rightMargin"
            from: -(parent.width * amplitude )
            to:  0
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        NumberAnimation // return
        {
            targets: [image1_lowResItem, image1_highResItem]
            property: "anchors.rightMargin"
            from:  0; to: -(parent.width * amplitude )
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        loops: Animation.Infinite
    }

    // (Y) Vertical close-up animation

    SequentialAnimation { // only applied to top margin. It's enough.
        running: true

        NumberAnimation // go
        {
            targets: [image1_lowResItem, image1_highResItem]
            property: "anchors.topMargin"
            from: -(parent.height * amplitude )
            to:  0
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        NumberAnimation // return
        {
            targets: [image1_lowResItem, image1_highResItem]
            property: "anchors.topMargin"
            from:  0
            to: -(parent.height * amplitude )
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        loops: Animation.Infinite
    }




    // ---------------------------------------------------------------------
    //                 IMAGE 2 MEDIUM CLOSE-UP ANIMATION
    // ---------------------------------------------------------------------

    // As this application has a responsive design, these animations are
    // accomplished by tweaking anchor margins, and not positions.

    // (X) Horizontal close-up Animation

    SequentialAnimation { //left margin
        running: true

        NumberAnimation // go
        {
            targets: [image2_lowResItem, image2_highResItem]
            property: "anchors.leftMargin"
            from: -(parent.width * (amplitude * 2) )  // Initial point, Max zoom. Relative to tweakable amplitude x2 because of distance.
            to:  0                                  // Final point, Min zoom.
            duration: 500 / frequency               // Animation Speed, based on tweakable frequency (0.0x)
            easing.type: Easing.CosineCurve
        }

        NumberAnimation // return
        {
            targets: [image2_lowResItem, image2_highResItem]
            property: "anchors.leftMargin"
            from:  0                                // Final point, Min zoom.
            to: -(parent.width * (amplitude * 2) )    // Initial point, Max zoom. Relative to tweakable amplitude x2 because of distance.
            duration: 500 / frequency               // Frequency based Animation Speed (0.0x).
            easing.type: Easing.CosineCurve
        }

        loops: Animation.Infinite
    }

    SequentialAnimation { // right margin
        running: true

        NumberAnimation // go
        {
            targets: [image2_lowResItem, image2_highResItem]
            property: "anchors.rightMargin"
            from: -(parent.width * (amplitude * 2) )
            to:  0
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        NumberAnimation // return
        {
            targets: [image2_lowResItem, image2_highResItem]
            property: "anchors.rightMargin"
            from:  0; to: -(parent.width * (amplitude * 2) )
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        loops: Animation.Infinite
    }

    // (Y) Vertical close-up animation

    SequentialAnimation { // only applied to top margin. It's enough.
        running: true

        NumberAnimation // go
        {
            targets: [image2_lowResItem, image2_highResItem]
            property: "anchors.topMargin"
            from: -(parent.height * (amplitude * 2) )
            to:  0
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        NumberAnimation // return
        {
            targets: [image2_lowResItem, image2_highResItem]
            property: "anchors.topMargin"
            from:  0
            to: -(parent.height * (amplitude * 2) )
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        loops: Animation.Infinite
    }




    // ---------------------------------------------------------------------
    //                 IMAGE 3 MEDIUM CLOSE-UP ANIMATION
    // ---------------------------------------------------------------------

    // As this application has a responsive design, these animations are
    // accomplished by tweaking anchor margins, and not positions.

    // (X) Horizontal close-up Animation

    SequentialAnimation { //left margin
        running: true

        NumberAnimation // go
        {
            targets: [image3_lowResItem, image3_highResItem]
            property: "anchors.leftMargin"
            from: -(parent.width * (amplitude * 3) )    // Initial point, Max zoom. Relative to tweakable amplitude x3 because of distance.
            to:  0                                      // Final point, Min zoom.
            duration: 500 / frequency                   // Animation Speed, based on tweakable frequency (0.0x)
            easing.type: Easing.CosineCurve
        }

        NumberAnimation // return
        {
            targets: [image3_lowResItem, image3_highResItem]
            property: "anchors.leftMargin"
            from:  0                                    // Final point, Min zoom.
            to: -(parent.width * (amplitude * 3) )      // Initial point, Max zoom. Relative to tweakable amplitude x3 because of distance.
            duration: 500 / frequency                   // Frequency based Animation Speed (0.0x).
            easing.type: Easing.CosineCurve
        }

        loops: Animation.Infinite
    }

    SequentialAnimation { // right margin
        running: true

        NumberAnimation // go
        {
            targets: [image3_lowResItem, image3_highResItem]
            property: "anchors.rightMargin"
            from: -(parent.width * (amplitude * 3) )
            to:  0
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        NumberAnimation // return
        {
            targets: [image3_lowResItem, image3_highResItem]
            property: "anchors.rightMargin"
            from:  0; to: -(parent.width * (amplitude * 3) )
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        loops: Animation.Infinite
    }

    // (Y) Vertical close-up animation

    SequentialAnimation { // only applied to top margin. It's enough.
        running: true

        NumberAnimation // go
        {
            targets: [image3_lowResItem, image3_highResItem]
            property: "anchors.topMargin"
            from: -(parent.height * (amplitude * 3) )
            to:  0
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        NumberAnimation // return
        {
            targets: [image3_lowResItem, image3_highResItem]
            property: "anchors.topMargin"
            from:  0
            to: -(parent.height * (amplitude * 3) )
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        loops: Animation.Infinite
    }




    // ---------------------------------------------------------------------
    //                 IMAGE 4 MEDIUM CLOSE-UP ANIMATION
    // ---------------------------------------------------------------------

    // As this application has a responsive design, these animations are
    // accomplished by tweaking anchor margins, and not positions.

    // (X) Horizontal close-up Animation

    SequentialAnimation { //left margin
        running: true

        NumberAnimation // go
        {
            targets: [image4_lowResItem, image4_highResItem]
            property: "anchors.leftMargin"
            from: -(parent.width * (amplitude * 4) )    // Initial point, Max zoom. Relative to tweakable amplitude x4 because of distance.
            to:  0                                      // Final point, Min zoom.
            duration: 500 / frequency                   // Animation Speed, based on tweakable frequency (0.0x)
            easing.type: Easing.CosineCurve
        }

        NumberAnimation // return
        {
            targets: [image4_lowResItem, image4_highResItem]
            property: "anchors.leftMargin"
            from:  0                                    // Final point, Min zoom.
            to: -(parent.width * (amplitude * 4) )      // Initial point, Max zoom. Relative to tweakable amplitude x4 because of distance.
            duration: 500 / frequency                   // Frequency based Animation Speed (0.0x).
            easing.type: Easing.CosineCurve
        }

        loops: Animation.Infinite
    }

    SequentialAnimation { // right margin
        running: true

        NumberAnimation // go
        {
            targets: [image4_lowResItem, image4_highResItem]
            property: "anchors.rightMargin"
            from: -(parent.width * (amplitude * 4) )
            to:  0
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        NumberAnimation // return
        {
            targets: [image4_lowResItem, image4_highResItem]
            property: "anchors.rightMargin"
            from:  0; to: -(parent.width * (amplitude * 4) )
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        loops: Animation.Infinite
    }

    // (Y) Vertical close-up animation

    SequentialAnimation { // only applied to top margin. It's enough.
        running: true

        NumberAnimation // go
        {
            targets: [image4_lowResItem, image4_highResItem]
            property: "anchors.topMargin"
            from: -(parent.height * (amplitude * 4) )
            to:  0
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        NumberAnimation // return
        {
            targets: [image4_lowResItem, image4_highResItem]
            property: "anchors.topMargin"
            from:  0
            to: -(parent.height * (amplitude * 4) )
            duration: 500 / frequency
            easing.type: Easing.CosineCurve
        }

        loops: Animation.Infinite
    }

}
