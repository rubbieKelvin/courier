import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
	id: root
	color: "transparent"
	readonly property alias list: list

	ScrollView{
		anchors.fill: parent
		ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
		ScrollBar.vertical.policy: ScrollBar.AsNeeded

		ListView {
			id: list
			anchors.fill: parent
			anchors.margins: 8
			clip: true
			spacing: 8

			onCountChanged: {
				currentIndex = count -1
			}
		}
	}
}
