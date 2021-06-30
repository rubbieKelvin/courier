import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15
import "./components"

Page {
	id: root

	readonly property StackView mainstack_: mainstack
	readonly property StateManager statemanager_: statemanager

	Column {
		id: column
		x: 168
		y: 221
		width: 248
		anchors.verticalCenter: parent.verticalCenter
		spacing: 15

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
				text: qsTr("Join Server")
			}
		}

		Column {
			id: column3
			width: parent.width
			Item {
				id: item2
				width: parent.width
				height: 25
				Label {
					id: label3
					text: qsTr("hostname")
					anchors.verticalCenter: parent.verticalCenter
				}
			}

			TextField {
				id: hostname_field
				width: parent.width
				text: helper.hostname()
				placeholderText: qsTr("Hostname or IPv4 address...")
				enabled: button1.enabled
			}
			spacing: 2
		}

		Column {
			id: column2
			width: parent.width
			spacing: 2

			Item {
				id: item1
				width: parent.width
				height: 25

				Label {
					id: label2
					text: qsTr("password")
					anchors.verticalCenter: parent.verticalCenter
				}

				Button {
					id: button2
					width: 60
					height: parent.height
					text: qsTr(password_field.echoMode === TextInput.Password ? "show" : "hide")
					anchors.right: parent.right
					flat: true
					anchors.rightMargin: 0
					onClicked: {
						if (password_field.echoMode === TextInput.Password)
							password_field.echoMode = TextInput.Normal
						else
							password_field.echoMode = TextInput.Password
					}
				}
			}

			TextField {
				id: password_field
				width: parent.width
				enabled: button1.enabled
				placeholderText: qsTr("Password...")
				echoMode: TextInput.Password
			}
		}

		RowLayout {
			id: row
			width: parent.width
			spacing: 5

			Button {
				id: button
				enabled: button1.enabled
				text: qsTr("Cancel")
				Layout.fillWidth: false
				onClicked: mainstack_.pop()
			}

			LoadButton {
				id: button1
				text: qsTr("Join")
				Layout.fillWidth: true

				onClicked: {
					enabled = false
					statemanager_.connectToServer(hostname_field.text)
				}

				Connections {
					target: statemanager_

					function onRequireAuth(){
						client.authenticate(password_field.text)
					}

					function onHandshakeDone(state) {
						button1.enabled = true
						if (state)
							mainstack_.push("./home.qml")
					}
				}
			}
		}

		anchors.horizontalCenter: parent.horizontalCenter
	}
}

/*##^##
Designer {
	D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}D{i:5}
}
##^##*/

