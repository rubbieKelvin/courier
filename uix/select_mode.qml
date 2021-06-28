import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
	id: root

	Column {
		id: column
		x: 168
		y: 221
		height: 99
		anchors.verticalCenter: parent.verticalCenter
		spacing: 15
		anchors.horizontalCenter: parent.horizontalCenter

		Column {
			id: column1
			anchors.horizontalCenter: parent.horizontalCenter

			Label {
				id: label
				width: parent.width
				text: qsTr("Courier")
				horizontalAlignment: Text.AlignHCenter
				font.pointSize: 14
			}

			Label {
				id: label1
				opacity: 0.8
				text: qsTr("stuffsbyrubbie")
			}
		}

		Row {
			id: row
			spacing: 5

			Button {
				id: button
				text: qsTr("Create Workspace")
			}

			Button {
				id: button1
				text: qsTr("Join Workspace")
			}
		}
	}

	Label {
		y: 457
		opacity: 0.8
		text: qsTr(`network: ${helper.hostname()}`)
		anchors.left: parent.left
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 10
		anchors.leftMargin: 10
	}
}

/*##^##
Designer {
	D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}D{i:8}
}
##^##*/

