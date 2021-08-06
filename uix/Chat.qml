import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import "./components/app"

Page {
	id: root
	background: Rectangle{
		color: theme.background
	}

	StackLayout{
		id: chat_stack
		anchors.fill: parent
		currentIndex: _currentPeerIndex

		Repeater{
			/* for every contact model, there's a message model
			*/
			model: contact_model
			delegate: ChatPage{
				id: current_chat_page
				client_uid: uid
				Layout.fillWidth: true
				Layout.fillHeight: true
				client_username: username
				client_avatar: avatar || ''
			}
		}
	}
}
