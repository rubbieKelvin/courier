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
	state: application.minimal ? "minimal" : ""

	property alias name: contact_name.text
	property alias tip: tip.text
	property alias subtext: contact_description.text
	property alias icon: roundImage.source

	signal clicked()

	RippleArea{
		id: mouse
		anchors.fill: parent
		color: theme.secondary
		hoverEnabled: true
		acceptedButtons: Qt.RightButton | Qt.LeftButton
		property string button: ""
		property bool hovered: false

		onPressed: {
			button = pressedButtons & Qt.RightButton ? "r" : "l"
		}

		onClicked: {
			if (button=="r"){
				menu.x = mouseX
				menu.y = mouseY-menu.height
				return menu.open()
			}else{
				root.clicked()
			}
		}

		onEntered: hovered = true
		onExited: hovered = false
	}

	ContactItemPopup{
		id: menu
	}

	CustomTip{
		id: tip
		visible: mouse.hovered
		delay: 2000
		timeout: 2000
	}

	RowLayout{
		id: rowLayout
		anchors.fill: parent
		anchors.leftMargin: 10
		anchors.rightMargin: 10
		anchors.topMargin: 7
		anchors.bottomMargin: 7
		clip: true

		RoundImage{
			id: roundImage
			sourceSize.width: 40
			sourceSize.height: 40
			Layout.preferredWidth: 40
			Layout.preferredHeight: 40
			radius: width/2
			fillMode: Image.PreserveAspectCrop
		}

		Column{
			visible: !minimal
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
				font.pixelSize: theme.fontsize.helptext
				color: theme.text_light
			}
		}

		Rectangle{
			id: rectangle
			width: 20
			height: 14
			color: "#f27d7d"
			radius: 5
			visible: !minimal

			Label{
				id: badge_text
				color: "#ffffff"
				text: "0"
				anchors.verticalCenter: parent.verticalCenter
				anchors.horizontalCenter: parent.horizontalCenter
			}
		}
	}
	states: [
		State {
			name: "minimal"

			PropertyChanges {
			 target: roundImage
			 width: 30
			 height: 30
			 sourceSize.height: 30
			 sourceSize.width: 30
			}

			PropertyChanges {
				target: rowLayout
				anchors.bottomMargin: 5
				anchors.topMargin: 5
				anchors.rightMargin: 5
				anchors.leftMargin: 5
			}

			PropertyChanges {
			   target: root
			   height: 40
			}
		}
 ]
 transitions: [
	 Transition {
		 id: transition
		 ParallelAnimation {
			 SequentialAnimation {
				 PauseAnimation {
					 duration: 50
				 }

				 PropertyAnimation {
					 target: roundImage
					 property: "width"
					 duration: 150
				 }
			 }

			 SequentialAnimation {
				 PauseAnimation {
					 duration: 50
				 }

				 PropertyAnimation {
					 target: roundImage
					 property: "sourceSize.width"
					 duration: 150
				 }
			 }

			 SequentialAnimation {
				 PauseAnimation {
					 duration: 50
				 }

				 PropertyAnimation {
					 target: roundImage
					 property: "height"
					 duration: 150
				 }
			 }

			 SequentialAnimation {
				 PauseAnimation {
					 duration: 50
				 }

				 PropertyAnimation {
					 target: roundImage
					 property: "sourceSize.height"
					 duration: 150
				 }
			 }
		 }

		 ParallelAnimation {
			 SequentialAnimation {
				 PauseAnimation {
					 duration: 50
				 }

				 PropertyAnimation {
					 target: rowLayout
					 property: "anchors.leftMargin"
					 duration: 150
				 }
			 }

			 SequentialAnimation {
				 PauseAnimation {
					 duration: 50
				 }

				 PropertyAnimation {
					 target: rowLayout
					 property: "anchors.bottomMargin"
					 duration: 150
				 }
			 }

			 SequentialAnimation {
				 PauseAnimation {
					 duration: 50
				 }

				 PropertyAnimation {
					 target: rowLayout
					 property: "anchors.topMargin"
					 duration: 150
				 }
			 }

			 SequentialAnimation {
				 PauseAnimation {
					 duration: 50
				 }

				 PropertyAnimation {
					 target: rowLayout
					 property: "anchors.rightMargin"
					 duration: 150
				 }
			 }
		 }
		 to: "*"
		 from: "*"
	 }
 ]
}

/*##^##
Designer {
	D{i:0;formeditorZoom:2;width:300}D{i:14;transitionDuration:2000}
}
##^##*/
