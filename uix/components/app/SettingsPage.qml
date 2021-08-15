import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import "../controls"
import "../widgets"
import "../utils/svg.js" as Svg
import "../utils/constants.js" as Constants

Page {
	id: root
	width: 300
	background: BorderedRectangle {
		color: theme.background
		leftborder.width: 1
		leftborder.color: theme.stroke
	}

	Column {
		anchors.fill: parent
		spacing: 0

		BorderedRectangle {
			id: header
			height: 40
			width: parent.width
			color: theme.background
			bottomborder.width: 1
			bottomborder.color: theme.stroke

			RowLayout {
				anchors.fill: parent
				anchors.margins: 1

				ToolButtonIcon {
					onClicked: {
						application.closeSettings()
					}

					source: Svg.fromString(
								[`<svg width="15" height="14" viewBox="0 0 15 14" fill="none" xmlns="http://www.w3.org/2000/svg">`, `<path fill-rule="evenodd" clip-rule="evenodd" d="M1.13607 0.63604C0.940808 0.831302 0.940809 1.14788 1.13607 1.34315L6.79294 7.00002L1.1361 12.6569C0.940839 12.8521 0.940838 13.1687 1.1361 13.364C1.33136 13.5592 1.64795 13.5592 1.84321 13.364L7.50005 7.70712L13.1569 13.364C13.3521 13.5592 13.6687 13.5592 13.864 13.364C14.0593 13.1687 14.0593 12.8521 13.864 12.6569L8.20715 7.00002L13.864 1.34315C14.0593 1.14788 14.0593 0.831302 13.864 0.63604C13.6688 0.440778 13.3522 0.440778 13.1569 0.63604L7.50005 6.29291L1.84318 0.63604C1.64792 0.440778 1.33133 0.440778 1.13607 0.63604Z" fill="${theme.text}"/>`, `</svg>`])
				}

				Label {
					text: "Settings"
					color: theme.text
					Layout.fillWidth: true
				}
			}
		}

		ColumnLayout {
			id: c_
			x: 15
			width: parent.width - 30

			RoundImage {
				Layout.fillWidth: true
				Layout.preferredHeight: 160
				verticalAlignment: Image.AlignTop
				fillMode: Image.PreserveAspectCrop
				radius: 10
				source: {
					if (helper)
						return helper.profilephoto
					return ''
				}
				Layout.alignment: Qt.AlignLeft | Qt.AlignTop

				Rectangle {
					id: rectangle
					radius: parent.radius
					anchors.fill: parent
					gradient: Gradient {
						GradientStop {
							position: 0.62907
							color: "#00000000"
						}

						GradientStop {
							position: 1
							color: "#e6000000"
						}
					}

					ColumnLayout {
						anchors.bottom: parent.bottom
						anchors.margins: 9
						anchors.left: parent.left
						anchors.right: parent.right
						spacing: 4

						Label {
							clip: true
							font.weight: Font.Medium
							font.pixelSize: theme.fontsize.heading
							text: {
								if (helper)
									return helper.username
								return "Anonymous"
							}
							color: "white"
						}

						RowLayout {
							spacing: 5
							Layout.fillWidth: true

							Image {
								Layout.preferredHeight: 14
								Layout.preferredWidth: 14
								source: Svg.fromString(
											[`<svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg"><path opacity="0.4" d="M12.8332 6.99984C12.8332 10.2222 10.2216 12.8332 6.99984 12.8332C3.77809 12.8332 1.1665 10.2222 1.1665 6.99984C1.1665 3.77867 3.77809 1.1665 6.99984 1.1665C10.2216 1.1665 12.8332 3.77867 12.8332 6.99984Z" fill="white"/><path fill-rule="evenodd" clip-rule="evenodd" d="M7.50741 7.36792C7.50741 7.64909 7.27816 7.87834 6.99699 7.87834C6.71582 7.87834 6.48657 7.64909 6.48657 7.36792V4.78959C6.48657 4.50842 6.71582 4.27917 6.99699 4.27917C7.27816 4.27917 7.50741 4.50842 7.50741 4.78959V7.36792ZM6.48954 9.21874C6.48954 8.93757 6.71762 8.70832 6.99704 8.70832C7.28462 8.70832 7.51329 8.93757 7.51329 9.21874C7.51329 9.4999 7.28462 9.72915 7.00287 9.72915C6.71995 9.72915 6.48954 9.4999 6.48954 9.21874Z" fill="white"/></svg>`])
							}

							Label {
								color: "#B2B2B2"
								font.pixelSize: theme.fontsize.helptext
								Layout.fillWidth: true
								text: {
									if (courier_state === Constants.COURIER_MODE_IDLE) {
										return "create or join a server"
									} else if (courier_state === Constants.COURIER_MODE_CLIENT) {
										return "you are connected to server"
									} else if (courier_state === Constants.COURIER_MODE_SERVER) {
										return "you run the server"
									} else {
										return 'server setting up...'
									}
								}
							}
						}
					}
				}
			}

			BorderedRectangle {
				Layout.fillWidth: true
				Layout.preferredHeight: 50
				color: "transparent"
				Layout.alignment: Qt.AlignLeft | Qt.AlignTop
				bottomborder.color: theme.stroke

				CustomSwitch {
					id: dnd_swtch
					height: parent.height
					width: parent.width
					text: "Do not disturb"
					textColor: theme.text
					font.pixelSize: theme.fontsize.normal
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
				Layout.alignment: Qt.AlignLeft | Qt.AlignTop

				CustomSwitch {
					id: darkmode_swtch
					height: parent.height
					width: parent.width
					text: "Dark mode"
					textColor: theme.text
					font.pixelSize: theme.fontsize.normal
					checked: apperance_settings.darkmode
					onCheckedChanged: apperance_settings.darkmode = checked

					Connections {
						target: apperance_settings
						function onDarkmodeChanged() {
							darkmode_swtch.checked = apperance_settings.darkmode
						}
					}
				}
			}

			BorderedRectangle {
				Layout.fillWidth: true
				Layout.preferredHeight: 50
				color: "transparent"
				bottomborder.color: theme.stroke
				Layout.alignment: Qt.AlignLeft | Qt.AlignTop

				CustomSpinBox {
					height: parent.height
					width: parent.width
					from: -2
					to: 2
					value: -2
					leftPadding: 5
					rightPadding: 5
					prefix: "Font Size - "

					property var items: ["Tiny", "Small", "Normal", "Medium", "Large"]

					textFromValue: function (value) {
						return items[value + 2]
					}

					valueFromText: function (text) {
						return items.indexOf(text) - 2
					}

					onValueChanged: {
						apperance_settings.fontscale = value
					}

					Component.onCompleted: {
						value = apperance_settings.fontscale
					}
				}
			}
		}

		Label {
			height: (c_.x + c_.height) - 30
			width: parent.width
			text: "made with love. stuffsbyrubbie"
			font.pixelSize: theme.fontsize.helptext
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignBottom
			bottomPadding: 16
			color: theme.text
			opacity: .7
		}
	}
}

/*##^##
Designer {
	D{i:0;formeditorZoom:0.75;height:700}
}
##^##*/

