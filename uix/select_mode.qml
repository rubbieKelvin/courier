import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
	id: root

	readonly property StackView mainstack_: mainstack

	Column {
		x: 168
		y: 221
		height: 99
		anchors.verticalCenter: parent.verticalCenter
		spacing: 15
		anchors.horizontalCenter: parent.horizontalCenter

		Column {
			id: column1

			Label {
				id: label
				width: parent.width
				text: qsTr("Courier")
				horizontalAlignment: Text.AlignLeft
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
				onClicked: mainstack_.push("./create_server.qml")
			}

			Button {
				id: button1
				text: qsTr("Join Workspace")
				onClicked: mainstack_.push("./join_server.qml")
			}
		}
	}

	Label {
		opacity: 0.8
		anchors.left: parent.left
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 10
		anchors.leftMargin: 10

		Component.onCompleted: {
			text = `network: ${helper.hostname()}\nip: ${helper.ip()}`
		}
	}
}

/*##^##
Designer {
	D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}D{i:8}
}
##^##*/

