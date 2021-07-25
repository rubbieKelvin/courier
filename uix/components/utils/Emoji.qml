import QtQuick 2.15
import "../utils"
import "./emoji.js" as Sticker

Rectangle{
	id: root
	color: "transparent"
	property bool clickable: true
	property string source: Sticker.stickers[0]
	property string tone: "#F9B914"
	signal clicked

	Image {
		id: image
		anchors.fill: parent
		anchors.margins: 5
		source: Sticker.fromString(root.source, {"$tone":tone})
		sourceSize.width: width
		sourceSize.height: height
	}

	RippleArea{
		enabled: clickable
		anchors.fill: parent
		onClicked: root.clicked()
	}
}
