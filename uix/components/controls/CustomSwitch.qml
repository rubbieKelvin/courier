import QtQuick 2.15
import QtQuick.Controls 2.15
import "../widgets"
import "../utils"

SwitchDelegate{
	id: root
	property alias textColor: label.color

	contentItem: Label{
		id: label
		font: root.font
		text: root.text
		rightPadding: root.indicator.width + root.spacing
		verticalAlignment: Text.AlignVCenter
	}

	indicator: Rectangle{
		implicitHeight: 15
		implicitWidth: 30
		radius: height/2
		x: (root.width - root.rightPadding) - width
		y: root.height/2 - height/2
		color: root.checked ? theme.accent_light : theme.disabled_light

		Rectangle{
			id: handle
			color: root.checked ? theme.accent : theme.disabled
			height: 15
			width: 15
			radius: width/2
		}

		NumberAnimation{
			id: anim
			target: handle
			property: "x"
		}
	}

	background: BorderedRectangle{
		implicitWidth: 50
		implicitHeight: 120
		color: theme.background
		bottomborder.color: theme.stroke

		RippleArea{
			anchors.fill: parent
			color: theme.secondary
			onClicked: root.checked = !root.checked
		}
	}

	onCheckedChanged: {
		anim.from = handle.x
		anim.to = checked ? 15 : 0
		anim.restart()
	}
}
