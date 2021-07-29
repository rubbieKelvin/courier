import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.9
import QtGraphicalEffects 1.13

Image {
    id: root
    property bool rounded: true
    property bool adapt: true
	property int radius: 5
	fillMode: Image.PreserveAspectCrop

	layer.enabled: rounded
    layer.effect: OpacityMask {
        maskSource: Item {
            width: root.width
            height: root.height
            Rectangle {
                anchors.centerIn: parent
                width: root.adapt ? root.width : Math.min(root.width, root.height)
                height: root.adapt ? root.height : width
                radius: root.radius
            }
        }
    }
}
/*##^##
Designer {
	D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
