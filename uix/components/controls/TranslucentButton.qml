import QtQuick 2.15
import QtQuick.Controls 2.15
import "../utils"

Button {
	id: root
	property alias bg_color: bg.color
	property alias fg_color: text.color

	background: Rectangle{
		id: bg
		radius: 6
		color: theme.accent_light

		RippleArea{
			anchors.fill: parent
			color: "#44c8c8c8"
			onClicked: root.clicked()
		}
	}
	contentItem: Label{
		id: text
		font: root.font
		text: root.text
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		color: theme.accent
	}
}
