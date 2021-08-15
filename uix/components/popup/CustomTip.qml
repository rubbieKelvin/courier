import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.12

ToolTip {
	id: root
	font.pixelSize: theme.fontsize.normal
	background: Rectangle{
		color: root.bg_color
		border.width: 1
		radius: 5
		border.color: theme.secondary
		layer.enabled: true
		layer.effect: DropShadow{
			verticalOffset: 0
			horizontalOffset: 0
			color: theme.darkmode ? "#55000000" : "#22695EE7"
			radius: 10
			samples: 8
			spread: 0
		}
	}
	contentItem: Label{
		font: root.font
		text: root.text
		color: root.fg_color
		opacity: .9
	}

	property color bg_color: theme.background
	property color fg_color: theme.text
}
