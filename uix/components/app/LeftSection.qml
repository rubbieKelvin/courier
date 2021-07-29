import QtQuick 2.9
import QtQuick.Controls 2.5
import "../widgets"
import "../utils/helper.js" as Helper

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
			model: contact_model
			anchors.fill: parent
			boundsBehavior: Flickable.StopAtBounds
			clip: true
			delegate: ContactItem{
				width: (parent || {width: 0}).width
				name: username.trim()
				tip: `You can now chat with ${username.trim()}`
				subtext: Helper.truncate(`You can now chat with ${username.trim()}`, 30)

				onClicked: {
					const i = list.indexAt(x, y)
					list.currentIndex = i
				}
			}
			highlight: Rectangle{
				color: theme.secondary
				opacity: .7
			}

			onCurrentIndexChanged: _currentPeerIndex=currentIndex
		}
	}
}

/*##^##
Designer {
	D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
