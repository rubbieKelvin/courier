import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import "./components"
import "./scripts/helper.js" as Helper

Page {
	id: root
	readonly property StateManager statemanager_: statemanager

	RowLayout {
		anchors.fill: parent

		Rectangle {
			width: 250
			color: "#f6f6f6"
			Layout.fillHeight: true

			ColumnLayout {
				id: columnLayout
				anchors.fill: parent
				anchors.margins: 25
				spacing: 15

				RowLayout {
					id: rowLayout
					width: parent.width
					spacing: 0
					Layout.fillWidth: false
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
							}else{
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
								onClicked: {

								}
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

			Connections {
				target: client

				function onContactListReceived(message) {
					message.body.forEach(function (data) {
						chat_stack.addClient(data)
					})
				}

				function onNewPeerJoined(message) {
					chat_stack.addClient(message.body)
				}

				function onClientProfileUpdateReceived(message) {
					const data = message.body
					
					// update client profile in chat page
					// look for item in chat_stack.pages that match unique_id
					for (var i = 0; i < chat_stack.pages.length; i++) {
						const page = chat_stack.pages[i]
						if (page.user.unique_id == data.unique_id) {
							page.user = data
							page.merge()
							break
						}
					}

					// update client profile in model
					// loop though statemanager_.peermodel and then set the matching data
					for (var j=0; j<statemanager_.peermodel.count; j++) {
						const modelItem = statemanager_.peermodel.get(j)
						if (modelItem.unique_id == data.unique_id){
							statemanager_.peermodel.set(j, data)
							break
						}
					}
				}
			}
		}
	}
}

/*##^##
Designer {
	D{i:0;autoSize:true;formeditorZoom:0.66;height:600;width:1000}
}
##^##*/

