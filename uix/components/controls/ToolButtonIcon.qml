import QtQuick 2.15
import QtQuick.Controls 2.15
import "../utils"
import "../popup"

Rectangle {
	id: root
	width: 35
	height: 35
	radius: width / 2
	clip: true
	color: root.down ? "#22000000" : "transparent"
	property alias source: image.source
	property string tiptext: ""

	signal clicked

	Image {
		id: image
		anchors.centerIn: parent
	}

	RippleArea{
		id: mouse
		anchors.fill: parent
		onClicked: root.clicked()
	}

	CustomTip{
		delay: 1000
		visible: mouse.containsMouse && !!tiptext
		text: tiptext
	}
}
