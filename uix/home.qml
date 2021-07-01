import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import "./components"
import "./scripts/helper.js" as Helper

Page {
	id: root
	readonly property StateManager statemanager_: statemanager
	property string current_chat_uid: ""

	RowLayout {
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.bottom: tell_rect.top

		Rectangle {
			width: 250
			color: "#f6f6f6"
			Layout.fillHeight: true

			ColumnLayout {
				id: columnLayout
				anchors.fill: parent
				anchors.margins: 25
				clip: true
				spacing: 15

				RowLayout {
					id: rowLayout
					width: parent.width
					spacing: 0
					Layout.fillWidth: true
					Layout.alignment: Qt.AlignLeft | Qt.AlignTop

					ColumnLayout {
						id: column
						Layout.fillWidth: true
						Layout.alignment: Qt.AlignLeft | Qt.AlignTop

						Label {
							text: qsTr("Courier")
							font.pointSize: 14
						}

						Label {
							text: qsTr("stuffsbyrubbie")
							font.pointSize: 10
						}
					}

					Label {
						horizontalAlignment: Text.AlignRight
						Layout.fillWidth: true
						Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

						Component.onCompleted: {
							if (server.running) {
								text = `${helper.hostname()}\n${helper.ip()}`
							} else {
								text = helper.hostname()
							}
						}
					}
				}

				Label {
					id: label3
					text: qsTr(`Peers (${statemanager_.peermodel.count})`)
					font.pointSize: 12
					Layout.alignment: Qt.AlignLeft | Qt.AlignTop
				}
				ScrollView {
					Layout.fillHeight: true
					Layout.fillWidth: true
					ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
					ScrollBar.vertical.policy: ScrollBar.AsNeeded

					ListView {
						id: peer_list_view
						spacing: 3
						clip: true
						delegate: Rectangle {
							height: 40
							width: (parent || {
										"width": 0
									}).width
							clip: true
							color: "transparent"

							RowLayout {
								anchors.fill: parent
								anchors.margins: 5

								Rectangle {
									id: rectangle
									width: height
									height: parent.height
									color: "#c4c4c4"
									radius: width / 2
								}

								Label {
									height: parent.height
									text: username
									font.pixelSize: 11
									Layout.fillWidth: true
								}
							}

							MouseArea {
								anchors.fill: parent
								hoverEnabled: true
								cursorShape: Qt.PointingHandCursor
								onClicked: current_chat_uid = unique_id
							}
						}
						model: statemanager_.peermodel
					}
				}
			}
		}

		StackLayout {
			id: chat_stack
			width: 100
			height: 100
			Layout.fillHeight: true
			Layout.fillWidth: true
			// keep track if created object
			// TODO: try your best to not use this
			property list<ChatPage> pages

			function addClient(data) {
				let page = Helper.createQObject(
						chat_stack,
						Qt.createComponent("./components/ChatPage.qml"), {
							"user": data
						})

				if (page !== null)
					chat_stack.pages.push(page)
			}

			Connections{
				target: root

				function onCurrent_chat_uidChanged(){
					// if chat_stack.pages > 1, ...
					// lets look for the index of the page in chat_stack.children...
					// that has the user.unique_id == current_chat_uid
					if (chat_stack.pages.length > 1){
						for (let i=0; i<chat_stack.children.length; i++){
							const page = chat_stack.children[i]
							if (page.user.unique_id == current_chat_uid){
								chat_stack.currentIndex = i
								break
							}
						}
					}
				}
			}

			Connections {
				target: client

				function onContactListReceived(message) {
					message.body.forEach(function (data) {
						if (current_chat_uid === "") current_chat_uid = data.unique_id
						chat_stack.addClient(data)
					})
				}

				function onNewPeerJoined(message) {
					if (current_chat_uid === "") current_chat_uid = message.body.unique_id
					chat_stack.addClient(message.body)
				}

				function onClientProfileUpdateReceived(message) {
					const data = message.body

					// update client profile in chat page
					// look for item in chat_stack.pages that match unique_id
					for (var i = 0; i < chat_stack.pages.length; i++) {
						const page = chat_stack.pages[i]
						if (page.user.unique_id === data.unique_id) {
							page.user = data
							page.merge()
							break
						}
					}

					// update client profile in model
					// loop though statemanager_.peermodel and then set the matching data
					for (var j = 0; j < statemanager_.peermodel.count; j++) {
						const modelItem = statemanager_.peermodel.get(j)
						if (modelItem.unique_id === data.unique_id) {
							statemanager_.peermodel.set(j, data)
							break
						}
					}
				}

				function onPrivateMessageReceived(message) {
					// find the page this message belongs to,
					// and then put it in the chat model bbelonging to the page

					for (var i=0; i<chat_stack.pages.length; i++) {
						const page = chat_stack.pages[i]
						if (page.user.unique_id === message.body.sender_uid){
							page.chatmodel.append({message: message})
						}
					}
				}
			}
		}
	}

	Rectangle {
		id: tell_rect
		width: parent.width
		height: visible ? 36 : 0
		color: "#4dff0000"
		border.width: 0
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		visible: false
		enabled: visible

		RowLayout {
			anchors.fill: parent
			anchors.margins: 5
			spacing: 5

			Label {
				color: "#ff0000"
				text: qsTr("Server Disconnected. most features have been disabled")
				verticalAlignment: Text.AlignVCenter
				wrapMode: Text.WordWrap
				font.pointSize: 9
				Layout.fillHeight: true
				Layout.fillWidth: true
			}

			Button {
				id: button
				text: qsTr("Leave")
				flat: false
				contentItem: Label {
					color: "#ffffff"
					font: parent.font
					text: parent.text
					anchors.fill: parent
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
				}

				background: Rectangle {
					anchors.fill: parent
					color: parent.down ? "#99ff0000" : "#6aff0000"
				}

				onClicked: {
					statemanager_.resetData()
					mainstack.pop()
				}
			}
		}
	}

	Connections {
		target: client

		function onDisconnected() {
			// client disconnected
			tell_rect.visible = true
		}
	}
}

/*##^##
Designer {
	D{i:0;autoSize:true;formeditorZoom:0.75;height:600;width:1000}D{i:20}
}
##^##*/

