import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../widgets"
import "../models"

Page {
	id: root
	background: Rectangle{
		color: theme.background
	}

	property string client_uid
	property string client_username
	property string client_avatar

	readonly property MessageModel model: MessageModel{
		client_uid: current_chat_page.client_uid
	}

	ColumnLayout{
		anchors.fill: parent
		spacing: 0

		ChatHead{
			Layout.fillWidth: true
			Layout.preferredHeight: 40
			uid: client_uid
			username: client_username
			avatar: client_avatar
		}

		ChatBody{
			Layout.fillHeight: true
			Layout.fillWidth: true
			list.model: root.model
			list.delegate: ChatBalloon{
				width: (parent || {width: 0}).width
				showAtLeft: message.sender_uid===client_uid
				maxLabelWidth: width - 100
				msg: message
			}

			Connections{
				target: client

				function onPrivateMessageSent(msg_data){
					// if it was sent to this guy, add to model
					const message = msg_data.message
					if (message.recv_uid === client_uid)
						root.model.append(msg_data)
				}

				function onPrivateMessageReceived(msg_data){
					// if it was recieved from this guy, add to model
					print(msg_data)
					const message = msg_data.message
					if (message.sender_uid === client_uid)
						root.model.append(msg_data)
				}
			}
		}

		ChatFooter{
			Layout.fillWidth: true
		}
	}
}

/*##^##
Designer {
	D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
