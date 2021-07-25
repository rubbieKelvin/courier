import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.11
import "../controls/"
import "../utils"
import "../popup"

Rectangle{
	id: root
	color: "transparent"
	height: 60

	RippleArea{
		id: mouse
		anchors.fill: parent
		color: theme.secondary
		acceptedButtons: Qt.RightButton | Qt.LeftButton
		property string button: ""

		onPressed: {
			button = pressedButtons & Qt.RightButton ? "r" : "l"
		}

		onClicked: {
			if (button=="r"){
				menu.x = mouseX
				menu.y = mouseY-menu.height
				return menu.open()
			}
		}
	}

	ContactItemPopup{
		id: menu
	}

	RowLayout{
		anchors.fill: parent
		anchors.leftMargin: 10
		anchors.rightMargin: 10
		anchors.topMargin: 7
		anchors.bottomMargin: 7

		RoundImage{
			sourceSize.width: 40
			sourceSize.height: 40
			width: 40
			height: 40
			radius: width/2
			source: "../../assets/avatars/001-man.svg"
		}

		Column{
			spacing: 4
			Layout.fillHeight: false
			Layout.fillWidth: true

			Label{
				id: contact_name
				text: "Lori"
				color: theme.text
			}

			Label{
				id: contact_description
				text: "there's a box on somthing..."
				font.pixelSize: 9
				color: theme.text_light
			}
		}

		Rectangle{
			id: rectangle
			width: 20
			height: 14
			color: "#f27d7d"
			radius: 5

			Label{
				id: badge_text
				color: "#ffffff"
				text: "0"
				anchors.verticalCenter: parent.verticalCenter
				anchors.horizontalCenter: parent.horizontalCenter
			}
		}
	}
}

/*##^##
Designer {
	D{i:0;formeditorZoom:2;width:300}
}
##^##*/
