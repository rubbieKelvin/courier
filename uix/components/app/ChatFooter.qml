import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.3
import "../widgets"
import "../controls"
import "../utils"
import "../popup"
import "../utils/svg.js" as Svg
import "../utils/helper.js" as Helper

BorderedRectangle {
	id: root
	height: 50
	color: theme.background
	topborder.color: theme.stroke
	property string selectedFileUrl: ""

	signal recorded(string source)

	function sendFile() {
		if (selectedFileUrl) {
			// TODO: stoped here
			client.sendFile(selectedFileUrl, client_uid)
			selectedFileUrl = ""
		}
	}

	function start_recording() {
		if (recorder.record()) {
			root.state = "recording"
			min_counter.start()
			sec_counter.start()
		} else {
			rib_popup.show("Recorder is busy", 2000)
		}
	}

	function cancel_recording() {
		recorder.cancel()
		root.state = ""
		min_counter.stop()
		sec_counter.stop()
	}

	function finish_recording() {
		root.state = ""
		const filename = recorder.stopRecording()
		min_counter.stop()
		sec_counter.stop()
		client.sendVoiceNote(filename, client_uid)
	}

	function send_text_message() {
		const txt = msg_field.text.trim()
		if (txt)
			client.sendPrivateMessage(txt, client_uid)
		msg_field.text = ""
	}

	function send_sticker(source) {
		if (source)
			client.sendPrivateMessage(source, client_uid, true)
	}

	// base state
	RowLayout {
		id: rowLayout
		anchors.fill: parent
		anchors.margins: 8
		spacing: 8
		enabled: root.state === ""

		ToolButtonIcon {
			source: Svg.fromString(
						['<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">', '<rect opacity="0.4" width="20" height="20" rx="4" fill="#695EE7"/>', '<path d="M3 6C4 5 6 5 7 6" stroke="#695EE7" stroke-linecap="round"/>', '<path d="M13 6C14 5 16 5 17 6" stroke="#695EE7" stroke-linecap="round"/>', '<circle cx="6" cy="8" r="1" fill="#695EE7"/>', '<circle cx="16" cy="8" r="1" fill="#695EE7"/>', '<path d="M11 4C9.33331 6 7.70001 9.2 8.50001 10C9.50001 11 10.5 10.5 11 11.5C11.3578 12.2155 9.66667 14.1667 9 15" stroke="#695EE7" stroke-linecap="round"/>', '</svg>'])
			onClicked: sb.open()
			tiptext: "Sticker Set"
		}

		ScrollView {
			ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
			ScrollBar.vertical.policy: ScrollBar.AsNeeded
			Layout.fillWidth: true
			Layout.fillHeight: true
			visible: !selectedFileUrl

			TextArea {
				id: msg_field
				placeholderText: "Type Something..."
				color: theme.text
				focus: true
				font.pixelSize: 10
				background: Rectangle {
					color: "transparent"
				}

				property bool ctrl: false

				Keys.onPressed: {
					if (event.key === Qt.Key_Control)
						ctrl = true
					if ((event.key === Qt.Key_Return) && ctrl)
						send_text_message()
				}

				Keys.onReleased: {
					if (event.key === Qt.Key_Control)
						ctrl = false
				}
			}
		}

		Rectangle {
			Layout.preferredHeight: 30
			Layout.fillWidth: true
			border.width: 0
			Layout.fillHeight: true
			border.color: theme.accent
			color: theme.accent_light
			radius: height / 2
			visible: !!root.selectedFileUrl
			enabled: visible

			RowLayout {
				anchors.fill: parent
				anchors.leftMargin: 10
				anchors.rightMargin: 10

				Label {
					id: t__
					clip: true
					text: Helper.truncate(String(Helper.filenameFromUrl(
													 root.selectedFileUrl)), 40)
					verticalAlignment: Text.AlignVCenter
					color: theme.accent
					Layout.fillHeight: true
					Layout.fillWidth: true
				}

				ToolButtonIcon {
					tiptext: `close ${t__.text}`
					onClicked: root.selectedFileUrl = ""
					source: Svg.fromString(
								['<svg width="20" height="20" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">', `<path fill-rule="evenodd" clip-rule="evenodd" d="M4.29289 4.29289C3.90237 4.68342 3.90237 5.31658 4.29289 5.70711L5.70711 7.12132L4.2929 8.53553C3.90238 8.92606 3.90238 9.55922 4.2929 9.94975C4.68343 10.3403 5.31659 10.3403 5.70711 9.94975L7.12132 8.53554L8.53553 9.94975C8.92606 10.3403 9.55922 10.3403 9.94975 9.94975C10.3403 9.55922 10.3403 8.92606 9.94975 8.53553L8.53554 7.12132L9.94976 5.70711C10.3403 5.31658 10.3403 4.68342 9.94976 4.29289C9.55923 3.90237 8.92607 3.90237 8.53554 4.29289L7.12132 5.70711L5.70711 4.29289C5.31658 3.90237 4.68342 3.90237 4.29289 4.29289Z" fill="${theme.text}"/>`, '</svg>'])
				}

				ToolButtonIcon {
					tiptext: "send file"
					onClicked: sendFile()
					source: Svg.fromString(
								['<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">', '<path d="M17.8563 2.14857C17.4396 1.72274 16.8229 1.56524 16.2479 1.73191L2.8396 5.60607C2.23293 5.77441 1.80293 6.25524 1.6871 6.86524C1.56876 7.48691 1.9821 8.27691 2.5221 8.60691L6.7146 11.1669C7.1446 11.4302 7.6996 11.3644 8.05543 11.0077L12.8563 6.20691C13.0979 5.95607 13.4979 5.95607 13.7396 6.20691C13.9813 6.44774 13.9813 6.84024 13.7396 7.09024L8.93043 11.8911C8.57377 12.2477 8.5071 12.8011 8.7696 13.2319L11.3313 17.4402C11.6313 17.9394 12.1479 18.2236 12.7146 18.2236C12.7813 18.2236 12.8563 18.2236 12.9229 18.2144C13.5729 18.1319 14.0896 17.6894 14.2813 17.0644L18.2563 3.75691C18.4313 3.19024 18.2729 2.57357 17.8563 2.14857" fill="#695EE7"/>', '<path opacity="0.4" fill-rule="evenodd" clip-rule="evenodd" d="M2.50882 14.0065C2.34882 14.0065 2.18882 13.9457 2.06716 13.8232C1.82299 13.579 1.82299 13.184 2.06716 12.9398L3.20466 11.8015C3.44883 11.5582 3.84466 11.5582 4.08883 11.8015C4.33216 12.0457 4.33216 12.4415 4.08883 12.6857L2.95049 13.8232C2.82883 13.9457 2.66882 14.0065 2.50882 14.0065ZM5.64315 15.0002C5.48315 15.0002 5.32315 14.9393 5.20149 14.8168C4.95732 14.5727 4.95732 14.1777 5.20149 13.9335L6.33899 12.7952C6.58315 12.5518 6.97899 12.5518 7.22315 12.7952C7.46649 13.0393 7.46649 13.4352 7.22315 13.6793L6.08482 14.8168C5.96315 14.9393 5.80315 15.0002 5.64315 15.0002ZM5.85457 17.9735C5.97624 18.096 6.13624 18.1568 6.29624 18.1568C6.45624 18.1568 6.61624 18.096 6.7379 17.9735L7.87624 16.836C8.11957 16.5918 8.11957 16.196 7.87624 15.9518C7.63207 15.7085 7.23624 15.7085 6.99207 15.9518L5.85457 17.0902C5.6104 17.3343 5.6104 17.7293 5.85457 17.9735Z" fill="#695EE7"/>', '</svg>'])
				}
			}
		}

		RowLayout {
			spacing: 4

			ToolButtonIcon {
				tiptext: "send message"
				visible: !!msg_field.text
				source: Svg.fromString(
							['<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">', '<path d="M17.8563 2.14857C17.4396 1.72274 16.8229 1.56524 16.2479 1.73191L2.8396 5.60607C2.23293 5.77441 1.80293 6.25524 1.6871 6.86524C1.56876 7.48691 1.9821 8.27691 2.5221 8.60691L6.7146 11.1669C7.1446 11.4302 7.6996 11.3644 8.05543 11.0077L12.8563 6.20691C13.0979 5.95607 13.4979 5.95607 13.7396 6.20691C13.9813 6.44774 13.9813 6.84024 13.7396 7.09024L8.93043 11.8911C8.57377 12.2477 8.5071 12.8011 8.7696 13.2319L11.3313 17.4402C11.6313 17.9394 12.1479 18.2236 12.7146 18.2236C12.7813 18.2236 12.8563 18.2236 12.9229 18.2144C13.5729 18.1319 14.0896 17.6894 14.2813 17.0644L18.2563 3.75691C18.4313 3.19024 18.2729 2.57357 17.8563 2.14857" fill="#695EE7"/>', '<path opacity="0.4" fill-rule="evenodd" clip-rule="evenodd" d="M2.50882 14.0065C2.34882 14.0065 2.18882 13.9457 2.06716 13.8232C1.82299 13.579 1.82299 13.184 2.06716 12.9398L3.20466 11.8015C3.44883 11.5582 3.84466 11.5582 4.08883 11.8015C4.33216 12.0457 4.33216 12.4415 4.08883 12.6857L2.95049 13.8232C2.82883 13.9457 2.66882 14.0065 2.50882 14.0065ZM5.64315 15.0002C5.48315 15.0002 5.32315 14.9393 5.20149 14.8168C4.95732 14.5727 4.95732 14.1777 5.20149 13.9335L6.33899 12.7952C6.58315 12.5518 6.97899 12.5518 7.22315 12.7952C7.46649 13.0393 7.46649 13.4352 7.22315 13.6793L6.08482 14.8168C5.96315 14.9393 5.80315 15.0002 5.64315 15.0002ZM5.85457 17.9735C5.97624 18.096 6.13624 18.1568 6.29624 18.1568C6.45624 18.1568 6.61624 18.096 6.7379 17.9735L7.87624 16.836C8.11957 16.5918 8.11957 16.196 7.87624 15.9518C7.63207 15.7085 7.23624 15.7085 6.99207 15.9518L5.85457 17.0902C5.6104 17.3343 5.6104 17.7293 5.85457 17.9735Z" fill="#695EE7"/>', '</svg>'])
				onClicked: send_text_message()
			}

			ToolButtonIcon {
				source: Svg.fromString(
							['<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">', '<path opacity="0.4" d="M16.2762 8.18806C15.8305 8.18806 15.4689 8.54442 15.4689 8.98527C15.4689 11.9628 13.0156 14.3856 10.0005 14.3856C6.98455 14.3856 4.53128 11.9628 4.53128 8.98527C4.53128 8.54442 4.16962 8.18806 3.72401 8.18806C3.2784 8.18806 2.91675 8.54442 2.91675 8.98527C2.91675 12.5727 5.66629 15.5343 9.19322 15.9321V17.5361C9.19322 17.9762 9.55407 18.3333 10.0005 18.3333C10.4461 18.3333 10.8077 17.9762 10.8077 17.5361V15.9321C14.3339 15.5343 17.0834 12.5727 17.0834 8.98527C17.0834 8.54442 16.7218 8.18806 16.2762 8.18806Z" fill="#695EE7"/>', '<path d="M9.85377 12.6809H10.146C12.148 12.6809 13.7722 11.0777 13.7722 9.10064V5.24773C13.7722 3.26906 12.148 1.66667 10.146 1.66667H9.85377C7.85175 1.66667 6.22754 3.26906 6.22754 5.24773V9.10064C6.22754 11.0777 7.85175 12.6809 9.85377 12.6809Z" fill="#695EE7"/>', '</svg>'])
				tiptext: "record voice note"
				onClicked: root.start_recording()

				CustomTip {
					id: rib_popup
					bg_color: "red"
					fg_color: "white"
				}
			}

			ToolButtonIcon {
				source: Svg.fromString(
							['<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">', '<path opacity="0.4" d="M14.0704 4.26238H11.6178C11.0068 4.26641 10.4267 3.99463 10.0396 3.52293L9.23192 2.40636C8.85122 1.93052 8.27116 1.65746 7.66109 1.66691H5.92725C2.81524 1.66691 1.66676 3.49335 1.66676 6.59904V9.95613C1.66288 10.3253 18.3298 10.3249 18.3309 9.95613V8.98006C18.3457 5.87438 17.2268 4.26238 14.0704 4.26238Z" fill="#695EE7"/>', '<path fill-rule="evenodd" clip-rule="evenodd" d="M17.3602 5.4529C17.6268 5.76463 17.8328 6.12322 17.9678 6.51031C18.2333 7.30588 18.3562 8.14192 18.3308 8.98007V13.3576C18.3298 13.7263 18.3025 14.0945 18.2493 14.4594C18.148 15.1033 17.9215 15.7213 17.5825 16.2784C17.4267 16.5476 17.2375 16.796 17.0194 17.0179C16.032 17.9241 14.7209 18.3957 13.3813 18.3267H6.60893C5.26716 18.3952 3.95393 17.9238 2.96342 17.0179C2.74792 16.7956 2.56122 16.5471 2.40771 16.2784C2.07071 15.7217 1.84899 15.1031 1.75566 14.4594C1.69632 14.0951 1.66659 13.7267 1.66675 13.3576V8.98007C1.6666 8.61447 1.68639 8.24914 1.72603 7.88568C1.73436 7.82192 1.74686 7.75919 1.75923 7.69711C1.77986 7.59362 1.80012 7.49194 1.80012 7.39025C1.87534 6.95165 2.01255 6.52592 2.20765 6.12579C2.78559 4.89091 3.97112 4.26238 5.91243 4.26238H14.0629C15.1503 4.17829 16.2295 4.50562 17.086 5.1793C17.1847 5.26295 17.2764 5.35445 17.3602 5.4529ZM5.80869 12.9509H14.1963H14.2111C14.3952 12.9589 14.5748 12.893 14.7098 12.768C14.8448 12.643 14.9241 12.4692 14.9299 12.2854C14.9403 12.1239 14.8871 11.9647 14.7817 11.8417C14.6604 11.6765 14.4682 11.5779 14.263 11.5755H5.80869C5.42812 11.5755 5.1196 11.8834 5.1196 12.2632C5.1196 12.643 5.42812 12.9509 5.80869 12.9509Z" fill="#695EE7"/>', '</svg>'])

				onClicked: file_dialog.open()
				tiptext: "select a file"
			}
		}
	}

	// recording state
	RowLayout {
		id: rowLayout1
		visible: false
		anchors.fill: parent
		anchors.margins: 8
		enabled: false
		spacing: 8

		Item {
			width: 35
			height: 35

			Image {
				id: rec_icon
				property color color: "#F02121"
				source: Svg.fromString(
							['<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">', `<path fill-rule="evenodd" clip-rule="evenodd" d="M12.1748 15.2174H11.825C9.42166 15.2174 7.47358 13.2927 7.47358 10.9203V6.29706C7.47358 3.92373 9.42166 2 11.825 2H12.1748C14.5781 2 16.5272 3.92373 16.5272 6.29706V10.9203C16.5272 13.2927 14.5781 15.2174 12.1748 15.2174ZM18.5626 10.7829C18.5626 10.2539 18.9966 9.82626 19.5313 9.82626C20.066 9.82626 20.5 10.2539 20.5 10.7829C20.5 15.0866 17.2006 18.6404 12.9692 19.1178V21.0434C12.9692 21.5714 12.5352 22 12.0005 22C11.4648 22 11.0318 21.5714 11.0318 21.0434V19.1178C6.79945 18.6404 3.5 15.0866 3.5 10.7829C3.5 10.2539 3.93398 9.82626 4.46872 9.82626C5.00345 9.82626 5.43743 10.2539 5.43743 10.7829C5.43743 14.3558 8.38136 17.2629 12.0005 17.2629C15.6186 17.2629 18.5626 14.3558 18.5626 10.7829Z" fill="${color}"/>`, '</svg>'])
				sourceSize.width: 20
				sourceSize.height: 20
				width: 20
				height: 20
				anchors.centerIn: parent

				SequentialAnimation on color {
					running: rowLayout1.enabled
					loops: Animation.Infinite

					ColorAnimation {
						from: "#F02121"
						to: "#FFADAD"
						duration: 1000
					}

					ColorAnimation {
						from: "#FFADAD"
						to: "#F02121"
						duration: 700
					}
				}
			}
		}

		Label {
			id: label
			color: theme.text
			text: {
				return Helper.digit(min_counter.count,
									2) + ":" + Helper.digit(sec_counter.count,
															2)
			}
		}

		// gap
		Item {
			id: item1
		}

		TranslucentButton {
			text: "cancel"
			fg_color: "#FF2A2A"
			bg_color: "#33FF2A2A"
			onClicked: root.cancel_recording()
		}

		ToolButtonIcon {
			source: Svg.fromString(
						['<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">', '<path d="M17.8563 2.14857C17.4396 1.72274 16.8229 1.56524 16.2479 1.73191L2.8396 5.60607C2.23293 5.77441 1.80293 6.25524 1.6871 6.86524C1.56876 7.48691 1.9821 8.27691 2.5221 8.60691L6.7146 11.1669C7.1446 11.4302 7.6996 11.3644 8.05543 11.0077L12.8563 6.20691C13.0979 5.95607 13.4979 5.95607 13.7396 6.20691C13.9813 6.44774 13.9813 6.84024 13.7396 7.09024L8.93043 11.8911C8.57377 12.2477 8.5071 12.8011 8.7696 13.2319L11.3313 17.4402C11.6313 17.9394 12.1479 18.2236 12.7146 18.2236C12.7813 18.2236 12.8563 18.2236 12.9229 18.2144C13.5729 18.1319 14.0896 17.6894 14.2813 17.0644L18.2563 3.75691C18.4313 3.19024 18.2729 2.57357 17.8563 2.14857" fill="#695EE7"/>', '<path opacity="0.4" fill-rule="evenodd" clip-rule="evenodd" d="M2.50882 14.0065C2.34882 14.0065 2.18882 13.9457 2.06716 13.8232C1.82299 13.579 1.82299 13.184 2.06716 12.9398L3.20466 11.8015C3.44883 11.5582 3.84466 11.5582 4.08883 11.8015C4.33216 12.0457 4.33216 12.4415 4.08883 12.6857L2.95049 13.8232C2.82883 13.9457 2.66882 14.0065 2.50882 14.0065ZM5.64315 15.0002C5.48315 15.0002 5.32315 14.9393 5.20149 14.8168C4.95732 14.5727 4.95732 14.1777 5.20149 13.9335L6.33899 12.7952C6.58315 12.5518 6.97899 12.5518 7.22315 12.7952C7.46649 13.0393 7.46649 13.4352 7.22315 13.6793L6.08482 14.8168C5.96315 14.9393 5.80315 15.0002 5.64315 15.0002ZM5.85457 17.9735C5.97624 18.096 6.13624 18.1568 6.29624 18.1568C6.45624 18.1568 6.61624 18.096 6.7379 17.9735L7.87624 16.836C8.11957 16.5918 8.11957 16.196 7.87624 15.9518C7.63207 15.7085 7.23624 15.7085 6.99207 15.9518L5.85457 17.0902C5.6104 17.3343 5.6104 17.7293 5.85457 17.9735Z" fill="#695EE7"/>', '</svg>'])
			onClicked: finish_recording()
		}
	}

	FileDialog {
		id: file_dialog
		selectFolder: false
		selectMultiple: false
		onAccepted: {
			root.selectedFileUrl = fileUrl
		}
	}

	StickerBox {
		id: sb
		y: application.minimal ? 0 : -height - 5
		x: application.minimal ? 0 : 5
		parent: application.minimal ? Overlay.overlay : root

		onEmojiSelected: {
			root.send_sticker(source)
		}
	}

	states: [
		State {
			name: "recording"

			PropertyChanges {
				target: rowLayout
				visible: false
				enabled: false
			}

			PropertyChanges {
				target: rowLayout1
				visible: true
				enabled: true
			}

			PropertyChanges {
				target: item1
				width: 1
				height: 1
				Layout.fillHeight: true
				Layout.fillWidth: true
			}
		}
	]

	Timer {
		id: min_counter
		property int count: 0
		interval: 60000
		repeat: true

		onRunningChanged: count = 0
		onTriggered: {
			count += 1
			count %= 60
		}
	}

	Timer {
		id: sec_counter
		interval: 1000
		repeat: true
		property int count: 0

		onRunningChanged: count = 0
		onTriggered: {
			count += 1
			count %= 60
		}
	}
}

/*##^##
Designer {
	D{i:0;formeditorZoom:3}D{i:12}D{i:27;transitionDuration:2000}
}
##^##*/

