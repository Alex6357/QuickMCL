/*
  这是“启动游戏”中的“启动”页面。
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

Rectangle {
    id: pageLaunch

    ComboBox {
        id: control
        model: ["First", "Second", "Third"]

        delegate: ItemDelegate {
            id: delegate

            required property var model
            required property int index

            width: control.width
            contentItem: Text {
                text: delegate.model[control.textRole]
                color: "#21be2b"
                font: control.font
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                color: delegate.down ? "#dddedf" : "#eeeeee"
                radius: 10

                // Rectangle {
                //     width: parent.width
                //     height: 1
                //     color: delegate.down ? "#17a81a" : "#21be2b"
                //     anchors.bottom: parent.bottom
                // }
            }
        }
        /*ItemDelegate {
            id: delegate

            required property var model
            required property int index

            width: control.width
            contentItem: Text {
                text: delegate.model[control.textRole]
                color: "#21be2b"
                font: control.font
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }
            highlighted: control.highlightedIndex === index
        }*/

        indicator: Canvas {
            id: canvas
            x: control.width - width - control.rightPadding
            y: control.topPadding + (control.availableHeight - height) / 2
            width: 12
            height: 8
            contextType: "2d"

            Connections {
                target: control
                function onPressedChanged() { canvas.requestPaint(); }
            }

            onPaint: {
                context.reset();
                context.moveTo(0, 0);
                context.lineTo(width, 0);
                context.lineTo(width / 2, height);
                context.closePath();
                context.fillStyle = control.pressed ? "#17a81a" : "#21be2b";
                context.fill();
            }
        }

        contentItem: Text {
            leftPadding: 0
            rightPadding: control.indicator.width + control.spacing

            text: control.displayText
            font: control.font
            color: control.pressed ? "#17a81a" : "#21be2b"
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitWidth: 120
            implicitHeight: 40
            border.color: control.pressed ? "#17a81a" : "#21be2b"
            border.width: control.visualFocus ? 2 : 1
            radius: 10
            clip: true
        }

        popup: Popup {
            y: control.height - 1
            width: control.width
            implicitHeight: contentItem.implicitHeight
            padding: 1

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: control.popup.visible ? control.delegateModel : null
                currentIndex: control.highlightedIndex

                ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle {
                border.color: "#21be2b"
                radius: 10
            }
        }
    }
}
