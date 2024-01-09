import QtQuick
import Qt5Compat.GraphicalEffects
import "qrc:/qml/data/qml/appControls"

Item {
    id: messageBox

    height: 240
    width: 450

    property string title: ""
    property string description: ""


    Component.onCompleted: {
        if (descriptionBox.height > 88) {
            messageBox.height = 240 + (descriptionBox.height - 80)
        }
        if (titleBox.width > 350) {
            messageBox.width = 450 + (titleBox.width - 340)
        }
    }


    Rectangle {
        id: windowContainer
        color: "TRANSPARENT"
        anchors.fill: parent

        Rectangle {
            id: shadowContainer
            anchors.fill: parent
            anchors.margins: 15

            radius: 14
            color: "#ebebeb"

            layer.effect: DropShadow {
                horizontalOffset: 3
                verticalOffset: 3
                radius: 15.0
                samples: 17
                color: "#40000000"
                transparentBorder: true
            }
        }

        Rectangle {
            id: windowBackground
            anchors.fill: parent
            anchors.margins: 20

            color: "WHITE"

            layer.enabled: true
            layer.effect:
                OpacityMask {
                maskSource: Item {
                    width: shadowContainer.width
                    height: shadowContainer.height
                    Rectangle {
                        anchors.centerIn: parent
                        width: shadowContainer.width
                        height: shadowContainer.height
                        radius: shadowContainer.radius
                    }
                }
            }

            Rectangle {
                id: titleContainer
                height: 40
                color: "#ebebeb"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                Text {
                    id: titleBox
                    text: title.toUpperCase()
                    anchors.verticalCenter: parent.verticalCenter
                    font.letterSpacing: 1.5
                    font.pixelSize: 12
                    wrapMode: Text.Wrap
                    fontSizeMode: Text.HorizontalFit
                    anchors.horizontalCenter: parent.horizontalCenter
                }

            }

            Image {
                id: iconBox
                width: 81
                height: 88
                anchors.left: parent.left
                anchors.top: titleContainer.bottom
                source: "qrc:/img/res/system/warningIcon.webp"
                anchors.topMargin: 10
                anchors.leftMargin: 20
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: descriptionBox
                text: description
                anchors.left: iconBox.right
                anchors.right: parent.right
                anchors.top: titleContainer.bottom
                font.letterSpacing: 1.0
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                fontSizeMode: Text.VerticalFit
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                anchors.topMargin: 10
            }

            Button_solidSwap {
                id: okButton
                width: 160
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 15

                isImageButton: false
                btnText: "OK"

                onClicked: {
                    messageBox.visible = false
                }

            }
        }
    }

}
