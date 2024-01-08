import QtQuick 2.0
import Qt5Compat.GraphicalEffects

Item {
    id: progress
    implicitWidth: 900
    implicitHeight: 30

    QtObject {
        id: internal

        property int gradValue: 0
    }

    // CUSTOM PROPERTIES
    property double progressCount: 50.0         // Defines the current progress of the bar.
    property int barRadius: 10                  // Bar Border Radius.
    property int gradientSpeed: 100             // Speed unit for gradient movement.

    property color barGradient1: "#49b8ff"      // Left gradient color. Defined as application default Light theme for now.
    property color barGradient2: "#ff8bd1"      // Mid gradient color. Same as above.
    property color barGradient3: "#ff9600"      // Right gradient color. Same as above.
    property color backgroundColor: "#6f3c2a"   // Color for the yet unfilled progress bar area.


    // Progress bar container. This Rectangle is the background of the bar.
    Rectangle {
        id: progressBg
        color: "#006f3c2a"
        radius: 10
        anchors.fill: parent
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1


        // This rectangle contains the gradient effect. This one represents the already done progress.
        Rectangle {
            id: progressCnt
            width: parent.width * (progressCount * 0.01)
            color: backgroundColor

            radius: barRadius
            border.color: backgroundColor
            border.width: 0
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0


            // Defines the gradient effect for the progress bar.
            LinearGradient {

                id: grad1
                anchors.fill: parent
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 2
                anchors.bottomMargin: 2
                anchors.topMargin: 2
                source: progressCnt
                anchors.rightMargin: 2
                start: Qt.point(parent.width, 0)
                end: Qt.point(0, parent.height)

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#49b8ff" }
                    GradientStop { position: 0.1; color: "#ff8bd1" }
                    GradientStop { position: 0.5; color: "#ff9600" }
                    GradientStop { position: 0.9; color: "#ff8bd1" }
                    GradientStop { position: 1.0; color: "#49b8ff" }
                }
            }


            // This timer manages the movement animation on the gradient effect.
            Timer {
                interval: gradientSpeed; running: true; repeat: true
                onTriggered: {
                    if (internal.gradValue < progressBg.width) {
                        internal.gradValue += 2
                        grad1.start = Qt.point(internal.gradValue, 0)
                        grad1.end = Qt.point(progressBg.width + internal.gradValue, 0)
                    } else {
                        internal.gradValue = -progressBg.width
                        grad1.start = Qt.point(-progressBg.width, 0)
                        grad1.end = Qt.point(0, 0)
                    }
                }
            }
        }
    }

}
