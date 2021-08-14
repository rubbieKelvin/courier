import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.9
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.1
import QtGraphicalEffects 1.15
import "../controls"
import "../widgets"
import "../utils"
import "../popup"
import "../utils/svg.js" as Svg
import "../utils/constants.js" as Constants

Popup {
	id: root
	margins: 0
	padding: 0
	height: application.minimal ? application.height : c1_.height + 10
	width: application.minimal ? application.width : 250
	closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
	background: Rectangle {
		radius: 5
		color: theme.background
		border.width: 1
		border.color: theme.stroke
		layer.enabled: !application.minimal
		layer.effect: DropShadow {
			verticalOffset: 0
			horizontalOffset: 0
			color: theme.darkmode ? "#55000000" : "#22695EE7"
			radius: 10
			samples: 8
			spread: 0
		}

		Rectangle {
			width: parent.width
			height: 100
			color: theme.secondary
			radius: 5
		}
	}
	enter: Transition {
		NumberAnimation {
			property: "width"
			from: 0
			to: application.minimal ? application.width : 250
			duration: 60
		}
	}
	exit: Transition {
		NumberAnimation {
			property: "width"
			from: root.width
			to: 0
			duration: 100
		}
	}

	function openCreateServerPopup() {
		server_password_container.shown = true
		open()
	}
	function openJoinServerPopup() {
		client_form_container.shown = true
		open()
	}

	HelperFunctions {
		id: _
	}

	ColumnLayout {
		id: c1_
		width: application.minimal ? application.width : 250
		spacing: 0
		y: 5

		Rectangle {
			id: header
			width: parent.width
			height: 50
			color: theme.secondary

			RowLayout {
				anchors.fill: parent
				anchors.margins: 6

				RoundImage {
					sourceSize.width: 40
					sourceSize.height: 40
					Layout.preferredWidth: 40
					Layout.preferredHeight: 40
					radius: width / 2
					source: {
						if (helper)
							return helper.profilephoto
						return ''
					}

					MouseArea {
						anchors.fill: parent
						cursorShape: Qt.PointingHandCursor
						hoverEnabled: true

						onClicked: profile_picture_dialog.open()
					}
				}

				Column {
					clip: true
					spacing: 4
					Layout.fillHeight: false
					Layout.fillWidth: true

					Label {
						id: contact_name
						text: {
							if (helper)
								return helper.username
							return "Anonymous"
						}
						color: theme.text
						enabled: visible

						MouseArea {
							id: m
							hoverEnabled: true
							anchors.fill: parent
							cursorShape: Qt.PointingHandCursor
							property bool hovered: false
							onDoubleClicked: {
								contact_name.visible = false
								username_field.visible = true
								username_field.focus = true
								username_field.text = contact_name.text
							}
							onEntered: hovered = true
							onExited: hovered = false
						}

						CustomTip {
							visible: m.hovered
							text: "double click to change username"
							delay: 1000
							timeout: 5000
						}
					}

					TextField {
						id: username_field
						placeholderText: "username"
						visible: false
						color: theme.text
						enabled: visible
						height: contact_name.height
						padding: 0
						maximumLength: 25
						selectByMouse: true
						background: Rectangle {
							color: "transparent"
						}

						onAccepted: {
							if (text)
								helper.username = text
							visible = false
							contact_name.visible = true
							// TODO: change username on server under this line
						}
					}

					Label {
						id: contact_description
						text: {
							if (courier_state == Constants.COURIER_MODE_IDLE) {
								return "create or join a server"
							} else if (courier_state == Constants.COURIER_MODE_CLIENT) {
								return "you are connected to server"
							} else if (courier_state == Constants.COURIER_MODE_SERVER) {
								return "you run the server"
							} else {
								return 'server setting up...'
							}
						}
						font.pixelSize: 9
						color: theme.text_light
					}
				}
			}
		}

		ColumnLayout {
			Layout.fillWidth: true
			Layout.fillHeight: true
			spacing: 0

			MenuItemDelegate {
				enabled: visible
				visible: courier_state !== Constants.COURIER_MODE_CLIENT
						 && courier_state !== Constants.COURIER_MODE_SERVER
				lefticon.source: Svg.fromString(
									 ['<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">', '<path d="M9.95752 12.1166C7.08253 12.1166 4.65674 12.5864 4.65674 14.3995C4.65674 16.2134 7.0982 16.6667 9.95752 16.6667C12.8325 16.6667 15.2583 16.1969 15.2583 14.3838C15.2583 12.5699 12.8168 12.1166 9.95752 12.1166Z" fill="#695EE7"/>', '<path opacity="0.4" d="M9.95745 10.3892C11.9042 10.3892 13.4652 8.81923 13.4652 6.86127C13.4652 4.90256 11.9042 3.33334 9.95745 3.33334C8.01069 3.33334 6.44971 4.90256 6.44971 6.86127C6.44971 8.81923 8.01069 10.3892 9.95745 10.3892Z" fill="#695EE7"/>', '<path opacity="0.4" d="M17.5733 7.68272C18.077 5.7015 16.6003 3.92215 14.72 3.92215C14.5155 3.92215 14.32 3.94466 14.129 3.98294C14.1036 3.98894 14.0753 4.0017 14.0603 4.02421C14.0432 4.05273 14.0559 4.091 14.0745 4.11577C14.6394 4.91276 14.964 5.88311 14.964 6.92475C14.964 7.92287 14.6662 8.85345 14.1439 9.62567C14.0902 9.70522 14.1379 9.81254 14.2327 9.82905C14.364 9.85231 14.4983 9.86432 14.6356 9.86807C16.0049 9.90409 17.2338 9.0178 17.5733 7.68272Z" fill="#695EE7"/>', '<path d="M19.0076 12.3475C18.7569 11.8101 18.1517 11.4417 17.2317 11.2608C16.7974 11.1542 15.6222 11.0041 14.5291 11.0244C14.5127 11.0267 14.5037 11.0379 14.5022 11.0454C14.5 11.0559 14.5045 11.0739 14.5261 11.0852C15.0313 11.3366 16.984 12.43 16.7385 14.7362C16.7281 14.836 16.8079 14.9223 16.9071 14.9073C17.3877 14.8383 18.6241 14.5711 19.0076 13.7388C19.2195 13.2991 19.2195 12.788 19.0076 12.3475Z" fill="#695EE7"/>', '<path opacity="0.4" d="M5.87057 3.98318C5.6803 3.94416 5.48406 3.92239 5.27961 3.92239C3.39926 3.92239 1.92259 5.70174 2.427 7.68297C2.76576 9.01804 3.9947 9.90434 5.36392 9.86832C5.50122 9.86456 5.63627 9.85181 5.76685 9.82929C5.86162 9.81278 5.90937 9.70547 5.85565 9.62592C5.33333 8.85294 5.03561 7.92311 5.03561 6.925C5.03561 5.8826 5.36094 4.91226 5.92579 4.11601C5.9437 4.09125 5.95713 4.05297 5.93922 4.02446C5.92429 4.00119 5.89669 3.98919 5.87057 3.98318Z" fill="#695EE7"/>', '<path d="M2.76788 11.2606C1.84786 11.4414 1.24346 11.8099 0.992746 12.3472C0.780087 12.7877 0.780087 13.2988 0.992746 13.7393C1.37628 14.5708 2.61268 14.8388 3.09321 14.9071C3.19245 14.9221 3.27155 14.8365 3.2611 14.7359C3.01561 12.4305 4.96833 11.3371 5.47424 11.0857C5.49513 11.0737 5.49961 11.0564 5.49737 11.0452C5.49588 11.0377 5.48767 11.0264 5.47125 11.0249C4.37737 11.0039 3.2029 11.154 2.76788 11.2606Z" fill="#695EE7"/>', '</svg>'])
				text: "Create Server"
				Layout.preferredHeight: 50
				Layout.fillWidth: true
				onClicked: {
					if (!create_server_btn.busy && !join_server_button.busy)
						server_password_container.shown = !server_password_container.shown
				}
				onVisibleChanged: {
					if (!visible)
						server_password_container.shown = false
				}
			}

			HiddenContainer {
				id: server_password_container
				Layout.preferredHeight: height
				Layout.fillWidth: true

				onShownChanged: {
					if (shown)
						client_form_container.shown = false
				}

				RowLayout {
					enabled: server_password_container.shown
					anchors.fill: parent
					anchors.rightMargin: 10
					anchors.leftMargin: 10

					Image {
						source: Svg.fromString(
									['<svg width="18" height="18" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">', '<path fill-rule="evenodd" clip-rule="evenodd" d="M10.2217 4.31434V5.20879C11.2264 5.5224 11.9584 6.43192 11.9584 7.51824V10.3981C11.9584 11.743 10.8435 12.8333 9.46888 12.8333H4.53188C3.15671 12.8333 2.04175 11.743 2.04175 10.3981V7.51824C2.04175 6.43192 2.77438 5.5224 3.7785 5.20879V4.31434C3.78443 2.5753 5.2248 1.16667 6.99119 1.16667C8.78129 1.16667 10.2217 2.5753 10.2217 4.31434ZM7.00305 2.18111C8.20633 2.18111 9.18436 3.13759 9.18436 4.31434V5.083H4.81581V4.30275C4.82174 3.13179 5.79977 2.18111 7.00305 2.18111ZM7.51874 9.59872C7.51874 9.88276 7.28757 10.1088 6.99712 10.1088C6.7126 10.1088 6.48143 9.88276 6.48143 9.59872V8.31182C6.48143 8.03358 6.7126 7.8075 6.99712 7.8075C7.28757 7.8075 7.51874 8.03358 7.51874 8.31182V9.59872Z" fill="#C5C5C5"/>', '</svg>'])
						sourceSize.height: 10
						sourceSize.width: 10
					}

					TextField {
						id: server_password_field
						placeholderText: "Set Password..."
						Layout.fillWidth: true
						Layout.fillHeight: true
						background: Rectangle {
							color: "transparent"
						}
						color: theme.text
						font.pixelSize: 9
						enabled: !create_server_btn.busy

						onTextChanged: {
							_.setData("server_password_field", text)
						}

						Component.onCompleted: {
							text = _.getData("server_password_field") || ""
						}
					}

					CustomTip {
						id: sp_tip
						timeout: 2000
						visible: false
						bg_color: "red"
						fg_color: "white"
					}

					TranslucentButton {
						id: create_server_btn
						text: "create"
						enabled: !busy
						onClicked: {
							const password = server_password_field.text

							if (!password) {
								sp_tip.show("enter password", 2000)
							} else {
								if (_.createServer(
											server_password_field.text)) {
									busy = Qt.binding(function () {
										const res = courier_state !== Constants.COURIER_MODE_SERVER
												  && courier_state !== Constants.COURIER_MODE_CLIENT
										if (!res) {
											create_server_btn.busy = false
											return false
										}
										return res
									})
								} else {
									sp_tip.show("couldn't create server!", 2000)
								}
							}
						}
					}
				}
			}

			MenuItemDelegate {
				enabled: visible
				visible: courier_state !== Constants.COURIER_MODE_CLIENT
						 && courier_state !== Constants.COURIER_MODE_SERVER
				lefticon.source: Svg.fromString(
									 ['<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">', '<path opacity="0.4" d="M17.5844 7.98989H16.5818V7.00968C16.5818 6.59121 16.2462 6.25 15.8326 6.25C15.42 6.25 15.0835 6.59121 15.0835 7.00968V7.98989H14.0826C13.6691 7.98989 13.3335 8.33109 13.3335 8.74957C13.3335 9.16804 13.6691 9.50925 14.0826 9.50925H15.0835V10.4903C15.0835 10.9088 15.42 11.25 15.8326 11.25C16.2462 11.25 16.5818 10.9088 16.5818 10.4903V9.50925H17.5844C17.997 9.50925 18.3335 9.16804 18.3335 8.74957C18.3335 8.33109 17.997 7.98989 17.5844 7.98989Z" fill="#695EE7"/>', '<path d="M7.91675 12.5129C4.54527 12.5129 1.66675 13.052 1.66675 15.2055C1.66675 17.3582 4.52775 17.9167 7.91675 17.9167C11.2874 17.9167 14.1667 17.3777 14.1667 15.2241C14.1667 13.0705 11.3057 12.5129 7.91675 12.5129Z" fill="#695EE7"/>', '<path opacity="0.4" d="M7.91678 10.4619C10.2123 10.4619 12.0523 8.59809 12.0523 6.27302C12.0523 3.94796 10.2123 2.08334 7.91678 2.08334C5.6213 2.08334 3.78125 3.94796 3.78125 6.27302C3.78125 8.59809 5.6213 10.4619 7.91678 10.4619Z" fill="#695EE7"/>', '</svg>'])
				text: "Join Server"
				Layout.preferredHeight: 50
				Layout.fillWidth: true
				onClicked: {
					if (!create_server_btn.busy && !join_server_button.busy)
						client_form_container.shown = !client_form_container.shown
				}
				onVisibleChanged: {
					if (!visible)
						client_form_container.shown = false
				}
			}

			HiddenContainer {
				id: client_form_container
				Layout.preferredHeight: height
				Layout.fillWidth: true
				virtualHeight: c2_.height

				onShownChanged: {
					if (shown)
						server_password_container.shown = false
				}

				ColumnLayout {
					id: c2_
					anchors.left: parent.left
					anchors.right: parent.right
					anchors.rightMargin: 10
					anchors.leftMargin: 14
					enabled: client_form_container.shown
					spacing: 0

					CustomTip {
						id: tip_2
						timeout: 2000
						visible: false
						bg_color: "red"
						fg_color: "white"
					}

					RowLayout {
						Layout.fillWidth: true
						Layout.preferredHeight: 36
						enabled: !join_server_button.busy

						Image {
							source: Svg.fromString(
										['<svg width="18" height="18" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">', '<path fill-rule="evenodd" clip-rule="evenodd" d="M6.24429 2.05274C5.85326 2.05274 5.52059 2.32447 5.42721 2.69071H8.56711C8.47373 2.32447 8.14107 2.05274 7.75004 2.05274H6.24429ZM9.45423 2.69071H10.6098C11.8354 2.69071 12.8334 3.70084 12.8334 4.94134C12.8334 4.94134 12.7984 5.46648 12.7867 6.19779C12.7856 6.25568 12.7575 6.31238 12.7114 6.34665C12.4307 6.55399 12.1739 6.72529 12.1506 6.73711C11.1818 7.38689 10.0559 7.84411 8.85659 8.07153C8.77839 8.08689 8.70135 8.04613 8.66166 7.97643C8.32549 7.39398 7.69751 7.01474 6.99716 7.01474C6.30148 7.01474 5.66767 7.38985 5.32158 7.97288C5.28131 8.0414 5.20543 8.08098 5.12781 8.06621C3.93838 7.8382 2.81257 7.38158 1.84959 6.74301L1.28931 6.35314C1.24262 6.32361 1.21344 6.27044 1.21344 6.21137C1.19593 5.91011 1.16675 4.94134 1.16675 4.94134C1.16675 3.70084 2.16475 2.69071 3.39036 2.69071H4.5401C4.65099 1.83418 5.36885 1.16667 6.24429 1.16667H7.75004C8.62548 1.16667 9.34334 1.83418 9.45423 2.69071ZM12.635 7.47556L12.6116 7.48738C11.4327 8.27893 10.0145 8.80467 8.52627 9.02323C8.31616 9.05277 8.10606 8.9169 8.04769 8.70425C7.9193 8.21986 7.50492 7.90088 7.00884 7.90088H7.003H6.99133C6.49525 7.90088 6.08088 8.21986 5.95248 8.70425C5.89412 8.9169 5.68401 9.05277 5.47391 9.02323C3.98566 8.80467 2.56745 8.27893 1.38853 7.48738C1.38269 7.48147 1.32433 7.44603 1.27764 7.47556C1.22512 7.5051 1.22512 7.57598 1.22512 7.57598L1.26597 10.5886C1.26597 11.8291 2.25813 12.8333 3.48375 12.8333H10.5106C11.7362 12.8333 12.7284 11.8291 12.7284 10.5886L12.7751 7.57598C12.7751 7.57598 12.7751 7.5051 12.7225 7.47556C12.6933 7.45784 12.6583 7.46375 12.635 7.47556ZM7.43489 9.95066C7.43489 10.1988 7.2423 10.3937 6.99717 10.3937C6.75789 10.3937 6.55945 10.1988 6.55945 9.95066V9.18863C6.55945 8.94644 6.75789 8.7456 6.99717 8.7456C7.2423 8.7456 7.43489 8.94644 7.43489 9.18863V9.95066Z" fill="#C5C5C5"/>', '</svg>'])
							sourceSize.height: 10
							sourceSize.width: 10
						}

						TextField {
							id: hostname_field
							placeholderText: "Server name / IP address..."
							Layout.fillWidth: true
							Layout.fillHeight: true
							background: Rectangle {
								color: "transparent"
							}
							color: theme.text
							font.pixelSize: 9
						}
					}

					RowLayout {
						Layout.fillWidth: true
						Layout.preferredHeight: 36
						enabled: !join_server_button.busy

						Image {
							source: Svg.fromString(
										['<svg width="18" height="18" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">', '<path fill-rule="evenodd" clip-rule="evenodd" d="M10.2217 4.31434V5.20879C11.2264 5.5224 11.9584 6.43192 11.9584 7.51824V10.3981C11.9584 11.743 10.8435 12.8333 9.46888 12.8333H4.53188C3.15671 12.8333 2.04175 11.743 2.04175 10.3981V7.51824C2.04175 6.43192 2.77438 5.5224 3.7785 5.20879V4.31434C3.78443 2.5753 5.2248 1.16667 6.99119 1.16667C8.78129 1.16667 10.2217 2.5753 10.2217 4.31434ZM7.00305 2.18111C8.20633 2.18111 9.18436 3.13759 9.18436 4.31434V5.083H4.81581V4.30275C4.82174 3.13179 5.79977 2.18111 7.00305 2.18111ZM7.51874 9.59872C7.51874 9.88276 7.28757 10.1088 6.99712 10.1088C6.7126 10.1088 6.48143 9.88276 6.48143 9.59872V8.31182C6.48143 8.03358 6.7126 7.8075 6.99712 7.8075C7.28757 7.8075 7.51874 8.03358 7.51874 8.31182V9.59872Z" fill="#C5C5C5"/>', '</svg>'])
							sourceSize.height: 10
							sourceSize.width: 10
						}

						TextField {
							id: cf_password_field
							placeholderText: "password"
							Layout.fillWidth: true
							Layout.fillHeight: true
							background: Rectangle {
								color: "transparent"
							}
							color: theme.text
							font.pixelSize: 9
						}
					}

					TranslucentButton {
						id: join_server_button
						text: "connect"
						Layout.fillWidth: true
						Layout.preferredHeight: 38

						// the client sometimes gets the Error first
						// ...before the busy binding is made in onClick. so i'll use this to
						// ...keep track of the error.
						property bool client_error: false
						onClicked: {
							const hostname = hostname_field.text.trim()
							const password = cf_password_field.text

							if (hostname.length < 1) {
								tip_2.show("enter hostname", 2000)
							} else {
								client_error = false

								if (_.connectToServer(hostname, password)) {

									// the _.connectToServer must has triggered an error
									// at this point, and a connection to the signal would have altered
									// the value of this variable, so we check.
									if (client_error) {
										busy = false
									} else {
										busy = Qt.binding(function () {
											const res = courier_state
													  !== Constants.COURIER_MODE_SERVER
													  && courier_state
													  !== Constants.COURIER_MODE_CLIENT
											if (!res) {
												join_server_button.busy = false
												return false
											}
											return res
										})
									}
								} else {
									tip_2.show(`couldn't connect to '${hostname}'`)
								}
							}
						}

						Connections {
							// when the client tries to connect to a server,...
							// and the client can't find the server, the error is passed to a signal
							// which we can now use to stop the button from being busy
							target: client
							function onError(error) {
								if (!client.running
										&& !client.handshake_successful) {
									if (error === 7 || error === 0) {

										// 7. PySide2.QtNetwork.QAbstractSocket.SocketError.QAbstractSocket.NetworkError
										// An error occurred with the network (e.g., the network cable was accidentally plugged out).

										// 0. PySide2.QtNetwork.QAbstractSocket.SocketError.ConnectionRefusedError
										// The connection was refused by the peer (or timed out).
										join_server_button.client_error = true
										join_server_button.busy = false

										tip_2.show((error === 7) ? "NetworkError, server probably doesn't exist" : (error === 0) ? "Connection Refused, seems like server not listening" : "Opps, an error occured.",
												   2000)
									}
								}
							}

							function onHandshakeDone(successful) {
								if (!client.running) {
									if (!successful) {
										join_server_button.client_error = true
										join_server_button.busy = false
										tip_2.show("Invalid password", 2000)
									}
								}
							}
						}
					}

					// dummy for space
					Item {
						Layout.preferredHeight: 6
					}
				}
			}

			BorderedRectangle {
				Layout.fillWidth: true
				Layout.preferredHeight: 50
				color: "transparent"
				bottomborder.color: theme.stroke

				CustomSwitch {
					id: dnd_swtch
					height: parent.height
					width: parent.width
					text: "Do not disturb"
					textColor: theme.text
					font.pixelSize: 10
					checked: notif_settings.do_not_disturb
					onCheckedChanged: notif_settings.do_not_disturb = checked

					Connections {
						target: notif_settings
						function onDo_not_disturbChanged() {
							dnd_swtch.checked = notif_settings.do_not_disturb
						}
					}
				}
			}

			BorderedRectangle {
				Layout.fillWidth: true
				Layout.preferredHeight: 50
				color: "transparent"
				bottomborder.color: theme.stroke

				CustomSwitch {
					height: parent.height
					width: parent.width
					text: "Dark mode"
					textColor: theme.text
					font.pixelSize: 10
					checked: apperance_settings.darkmode
					onCheckedChanged: apperance_settings.darkmode = checked
				}
			}

			MenuItemDelegate {
				visible: courier_state == Constants.COURIER_MODE_SERVER
						 || courier_state == Constants.COURIER_MODE_CLIENT
				enabled: visible
				lefticon.source: Svg.fromString(
									 ['<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">', '<path opacity="0.4" d="M1.66675 5.37249C1.66675 3.32999 3.35861 1.66666 5.43719 1.66666H9.57145C11.6458 1.66666 13.3334 3.32499 13.3334 5.36416V14.6275C13.3334 16.6708 11.6415 18.3333 9.56212 18.3333H5.42956C3.35437 18.3333 1.66675 16.675 1.66675 14.6358V13.8525V5.37249Z" fill="#695EE7"/>', '<path d="M18.1493 9.54566L15.7778 7.1215C15.5327 6.8715 15.1382 6.8715 14.8939 7.12316C14.6505 7.37483 14.6513 7.78066 14.8956 8.03066L16.1949 9.35816H14.9491H7.95721C7.61228 9.35816 7.33228 9.64566 7.33228 9.99983C7.33228 10.3548 7.61228 10.6415 7.95721 10.6415H16.1949L14.8956 11.969C14.6513 12.219 14.6505 12.6248 14.8939 12.8765C15.0165 13.0023 15.1764 13.0657 15.3371 13.0657C15.4961 13.0657 15.656 13.0023 15.7778 12.8782L18.1493 10.4548C18.2669 10.334 18.3335 10.1707 18.3335 9.99983C18.3335 9.82983 18.2669 9.6665 18.1493 9.54566Z" fill="#695EE7"/>', '</svg>'])
				text: (courier_state
					   == Constants.COURIER_MODE_SERVER) ? "Shutdown Server" : "Leave Server"
				Layout.preferredHeight: 50
				Layout.fillWidth: true
				onClicked: _.shutdownCourierNetwork()
			}

			MenuItemDelegate {
				id: setting_s_
				lefticon.source: Svg.fromString(
									 ['<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M10.0099 12.3584C8.67288 12.3584 7.59131 11.3168 7.59131 10.0084C7.59131 8.70009 8.67288 7.65009 10.0099 7.65009C11.347 7.65009 12.403 8.70009 12.403 10.0084C12.403 11.3168 11.347 12.3584 10.0099 12.3584Z" fill="#695EE7"/><path opacity="0.4" d="M17.6917 11.9751C17.5299 11.7251 17.2999 11.4751 17.0019 11.3167C16.7634 11.2001 16.6101 11.0084 16.4739 10.7834C16.0395 10.0667 16.295 9.12508 17.0189 8.70008C17.8705 8.22508 18.1431 7.16675 17.6491 6.34175L17.0785 5.35841C16.5931 4.53341 15.5286 4.24175 14.6854 4.72508C13.936 5.12508 12.9737 4.85841 12.5393 4.15008C12.4031 3.91675 12.3264 3.66675 12.3435 3.41675C12.369 3.09175 12.2668 2.78341 12.1135 2.53341C11.7984 2.01675 11.2278 1.66675 10.5976 1.66675H9.39681C8.77512 1.68341 8.20452 2.01675 7.88942 2.53341C7.72761 2.78341 7.63393 3.09175 7.65096 3.41675C7.668 3.66675 7.59135 3.91675 7.45509 4.15008C7.02076 4.85841 6.05841 5.12508 5.31749 4.72508C4.46586 4.24175 3.40984 4.53341 2.91589 5.35841L2.3453 6.34175C1.85987 7.16675 2.13239 8.22508 2.97551 8.70008C3.69939 9.12508 3.95488 10.0667 3.52907 10.7834C3.38429 11.0084 3.231 11.2001 2.99254 11.3167C2.70299 11.4751 2.4475 11.7251 2.31124 11.9751C1.99613 12.4917 2.01316 13.1417 2.32827 13.6834L2.91589 14.6834C3.231 15.2167 3.81862 15.5501 4.4318 15.5501C4.72135 15.5501 5.062 15.4667 5.33453 15.3001C5.54743 15.1584 5.80292 15.1084 6.08396 15.1084C6.92708 15.1084 7.63393 15.8001 7.65096 16.6251C7.65096 17.5834 8.43446 18.3334 9.42236 18.3334H10.5806C11.5599 18.3334 12.3435 17.5834 12.3435 16.6251C12.369 15.8001 13.0759 15.1084 13.919 15.1084C14.1915 15.1084 14.447 15.1584 14.6684 15.3001C14.9409 15.4667 15.2731 15.5501 15.5711 15.5501C16.1758 15.5501 16.7634 15.2167 17.0785 14.6834L17.6747 13.6834C17.9812 13.1251 18.0068 12.4917 17.6917 11.9751Z" fill="#695EE7"/></svg>'])
				text: "Settings"
				Layout.preferredHeight: 50
				Layout.fillWidth: true
				onClicked: {
					root.close()
					application.openSettings()
				}
			}

			MenuItemDelegate {
				id: h_
				lefticon.source: Svg.fromString(
									 ['<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">', '<path d="M9.99742 12.6455C6.40325 12.6455 3.33325 13.2122 3.33325 15.4788C3.33325 17.7463 6.38409 18.333 9.99742 18.333C13.5916 18.333 16.6616 17.7672 16.6616 15.4997C16.6616 13.2322 13.6116 12.6455 9.99742 12.6455" fill="#695EE7"/>', '<path opacity="0.4" d="M9.9974 10.4864C12.4457 10.4864 14.4074 8.52392 14.4074 6.07642C14.4074 3.62892 12.4457 1.66642 9.9974 1.66642C7.5499 1.66642 5.5874 3.62892 5.5874 6.07642C5.5874 8.52392 7.5499 10.4864 9.9974 10.4864" fill="#695EE7"/>', '</svg>'])
				text: "Hostname"
				subtitle.text: "0.0.0.0"
				Layout.preferredHeight: 50
				Layout.fillWidth: true
				showStroke: false

				Timer {
					id: t_
					interval: 1000
					repeat: true
					onTriggered: h_.subtitle.text = helper.ip()
				}

				Component.onCompleted: {
					text = helper.hostname()
					t_.start()
				}

				CustomTip {
					id: ip_copy_tip
					timeout: 1500
					text: {
						if (helper)
							return `Copied '${helper.ip()}' to clipbaord`
						return "Copied ip to clipboard"
					}
				}

				onClicked: {
					helper.saveTextToClipboard(helper.ip())
					ip_copy_tip.visible = true
				}
			}
		}
	}

	onClosed: {
		server_password_container.shown = false
		client_form_container.shown = false
		contact_name.visible = true
		username_field.visible = false
	}

	FileDialog {
		id: profile_picture_dialog
		folder: StandardPaths.writableLocation(StandardPaths.PicturesLocation)
		acceptLabel: "Use photo"
		nameFilters: ['Image Files (*.png *.jpg *.jpeg)']

		onAccepted: {
			// set photo
			// TODO: use a worker script to stop gui freeze on large images
			helper.profilephoto = file
		}
	}

	Connections {
		target: application
		function onMinimalChanged() {
			root.close()
		}
	}
}
