import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import "../widgets"
import "../utils"

ItemDelegate {
	id: root
	readonly property alias lefticon: icon
	readonly property alias subtitle: subtitle
	property bool showStroke: true
	spacing: 8

	background: BorderedRectangle{
		id: bg
		color: theme.background
		bottomborder.color: root.showStroke ? theme.stroke : "transparent"
		clip: true

		RippleArea{
			id: m
			anchors.fill: parent
			onClicked: root.clicked()
			color: theme.secondary
		}
	}

	contentItem: RowLayout{
		anchors.verticalCenter: parent.verticalCenter
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.rightMargin: 10
		anchors.leftMargin: 10
		spacing: root.spacing

		Image {
			id: icon
			sourceSize.height: 20
			sourceSize.width: 20
			height: 20
			width: 20
		}

		Column{
			Layout.fillWidth: true

			Label {
				text: root.text
				verticalAlignment: Text.AlignVCenter
				font.pixelSize: 10
				color: theme.text
			}

			Label{
				id: subtitle
				font.pixelSize: 9
				verticalAlignment: Text.AlignVCenter
				visible: !!text
			}
		}
	}
}
