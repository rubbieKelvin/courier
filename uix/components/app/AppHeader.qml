import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15
import "../controls"
import "../widgets"
import "../utils/svg.js" as Svg

BorderedRectangle {
	id: root
	height: 48
	color: "transparent"
	bottomborder.color: theme.stroke
	property alias avatar: avatar

	signal requestPage(string pagename)

	Row {
		id: row
		anchors.fill: parent
		anchors.margins: 8

		RowLayout {
			width: parent.width / 2
			anchors.verticalCenter: parent.verticalCenter

			SearchField {
				leftPadding: 30
				Layout.preferredHeight: 34
				Layout.preferredWidth: 240
			}
		}

		RowLayout {
			width: parent.width / 2
			anchors.verticalCenter: parent.verticalCenter

			ProfileAvatar {
				id: avatar
				Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
				Layout.preferredHeight: 34
				Layout.preferredWidth: 34
			}
		}
	}
}
