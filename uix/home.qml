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
					Layout.fillWidth: true
					Layout.alignment: Qt.AlignLeft | Qt.AlignTop

					Column {
						id: column
						Layout.fillWidth: true
						Layout.alignment: Qt.AlignLeft | Qt.AlignTop

						Label {
							id: label
							text: qsTr("Courier")
							font.pointSize: 14
						}

						Label {
							id: label1
							text: qsTr("stuffsbyrubbie")
							font.pointSize: 10
						}
					}

					Label {
						id: label2
						text: qsTr("rubbie")
						Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
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
							"userdata": data
						})

				if (page !== null)
					chat_stack.pages.push(page)
			}

			Connections {
				target: client

				function onContactListRecieved(message) {
					message.body.forEach(function (data) {
						chat_stack.addClient(data)
					})
				}

				function onNewPeerJoined(message) {
					chat_stack.addClient(message.body)
				}
			}
		}
	}
}

/*##^##
Designer {
	D{i:0;autoSize:true;formeditorZoom:0.75;height:600;width:1000}D{i:3}D{i:1}
}
##^##*/

