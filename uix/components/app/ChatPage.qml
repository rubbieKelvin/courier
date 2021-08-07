import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../widgets"
import "../models"
import "../utils/constants.js" as Constants

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
				label: message.text
				maxLabelWidth: width - 100
				state: {
					if (message.msg_type===Constants.PRIVATE_MESSAGE_TEXT){
						return ""
					}else if (message.msg_type===Constants.PRIVATE_MESSAGE_STICKER){
						return "sticker"
					}
				}
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
