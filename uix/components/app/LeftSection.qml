import QtQuick 2.9
import QtQuick.Controls 2.5
import "../widgets"

BorderedRectangle{
	id: root
	width: 250
	color: "transparent"
	rightborder.color: theme.stroke

	ScrollView{
		clip: true
		anchors.fill: parent
		ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
		ScrollBar.vertical.policy: ScrollBar.AsNeeded

		ListView{
			id: list
			model: 20
			anchors.fill: parent
			boundsBehavior: Flickable.StopAtBounds
			clip: true
			delegate: ContactItem{
				width: (parent || {width: 0}).width
			}
		}
	}
}

/*##^##
Designer {
	D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
