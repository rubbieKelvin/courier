import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../utils/svg.js" as Svg
import "../utils/constants.js" as Constants

RowLayout {
	id: root
	state: {
		switch (msg.type) {
		case Constants.PRIVATE_MESSAGE_TEXT:
			return ""
		case Constants.PRIVATE_MESSAGE_STICKER:
			return "sticker"
		case Constants.PRIVATE_MESSAGE_VOICE_NOTE:
			return "voicenote"
		case Constants.PRIVATE_MESSAGE_TYPE_BINARY_FILE:
			return "file"
		default:
			throw new Error(`invalid message type: ${msg.type}`)
		}
	}

	property bool showAtLeft: true
	property int maxLabelWidth: 400
	property variant msg: ({})

	Item {
		Layout.fillWidth: !showAtLeft
		Layout.preferredHeight: 5
	}

	// main stuff
	ColumnLayout {
		id: columnLayout
		spacing: 8

		Label {
			id: text_
			color: theme.text
			font.pixelSize: 10
			wrapMode: Text.WordWrap
			padding: 10
			Layout.maximumWidth: maxLabelWidth
			background: Rectangle {
				radius: 10
				color: showAtLeft ? theme.secondary : theme.accent_light
			}

			Component.onCompleted: {
				if (msg.type === Constants.PRIVATE_MESSAGE_TEXT)
					text = msg.text
			}
		}

		Image {
			id: image
			visible: false
			enabled: false
			sourceSize.width: 120
			sourceSize.height: 120
			Layout.preferredWidth: 120
			Layout.preferredHeight: 120
			fillMode: Image.PreserveAspectFit

			Component.onCompleted: {
				if (msg.type === Constants.PRIVATE_MESSAGE_STICKER)
					source = Svg.fromString([msg.text])
			}
		}

		VoiceNote {
			id: vn
			width: 200
			visible: false
			enabled: false
			color: showAtLeft ? theme.secondary : theme.accent_light
			label_color: theme.text
			message: msg
		}

		FileBalloon {
			id: fb
			width: 200
			visible: false
			enabled: false
			color: showAtLeft ? theme.secondary : theme.accent_light
			message: msg
		}

		Label {
			id: time_text
			font.pixelSize: 8
			horizontalAlignment: showAtLeft ? Text.AlignLeft : Text.AlignRight
			verticalAlignment: Text.AlignVCenter
			color: theme.disabled
			text: msg.timestamp
			Layout.preferredWidth: {
				switch (msg.type) {
				case Constants.PRIVATE_MESSAGE_TEXT:
					return text_.width
				case Constants.PRIVATE_MESSAGE_STICKER:
					return image.width
				case Constants.PRIVATE_MESSAGE_VOICE_NOTE:
					return vn.width
				case Constants.PRIVATE_MESSAGE_TYPE_BINARY_FILE:
					return fb.width
				}
			}
		}
	}

	Item {
		Layout.fillWidth: showAtLeft
		Layout.preferredHeight: 5
	}
	states: [
		State {
			name: "sticker"

			PropertyChanges {
				target: text_
				width: 0
				height: 0
				visible: false
				enabled: false
			}

			PropertyChanges {
				target: image
				visible: true
				enabled: true
				fillMode: Image.PreserveAspectFit
			}

			PropertyChanges {
				target: vn
				visible: false
				enabled: false
			}
		},
		State {
			name: "voicenote"
			PropertyChanges {
				target: text_
				width: 0
				height: 0
				visible: false
				enabled: false
			}

			PropertyChanges {
				target: image
				visible: false
				fillMode: Image.PreserveAspectFit
				enabled: false
			}

			PropertyChanges {
				target: vn
				visible: true
				enabled: true
			}
		},
		State {
			name: "file"

			PropertyChanges {
				target: text_
				width: 0
				height: 0
				visible: false
				enabled: false
			}

			PropertyChanges {
				target: fb
				visible: true
				enabled: true
			}
		}
	]
}

/*##^##
Designer {
	D{i:0;formeditorZoom:0.33;width:1300}
}
##^##*/

