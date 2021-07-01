import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11

Page {
	id: root
	required property var user
	property ListModel chatmodel: ListModel{}

	function merge(){
		username_label.text = Qt.binding(
			function(){
				return user.username
			}
		)
	}

	ColumnLayout {
		anchors.fill: parent
		anchors.topMargin: 5
		spacing: 0

		Rectangle {
			height: 40
			Layout.alignment: Qt.AlignLeft | Qt.AlignTop
			Layout.fillWidth: true

			Label {
				id: username_label
				width: 372
				height: 11
				font.pixelSize: 12
				text: user.username
				anchors.verticalCenter: parent.verticalCenter
			}
		}

		ScrollView {
			width: 200
			height: 200
			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignLeft | Qt.AlignTop
			ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
			ScrollBar.vertical.policy: ScrollBar.AsNeeded

			ListView {
				id: chat_view
				width: 110
				height: 160
				clip: true
				delegate: MessageBubble{
					width: parent.width

					Component.onCompleted: {
						pm=message
					}
				}
				model: chatmodel

				Connections {
				    target: client
				    
				    function onPrivateMessageSent(message) {
				    	chatmodel.append({message: message})
				    }
				}
			}
		}

		Rectangle {
			width: 200
			height: 50
			color: "#00000000"
			Layout.fillWidth: true

			Rectangle {
				color: "#f6f6f6"
				anchors.fill: parent
				anchors.margins: 5

				RowLayout {
					anchors.fill: parent

					TextField {
						id: text_message
						Layout.fillWidth: true
						placeholderText: qsTr("Enter message...")

						onAccepted: {
							client.sendPrivateMessage(text, user.unique_id)
							text = ""
						}
					}

					Button {
						id: button
						text: qsTr("send file")
					}
				}
			}
		}
	}
}

/*##^##
Designer {
	D{i:0;autoSize:true;height:480;width:640}D{i:7}D{i:6}D{i:1}
}
##^##*/

