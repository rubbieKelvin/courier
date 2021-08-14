import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import "../controls"
import "../utils/constants.js" as Constants
import "../utils/helper.js" as Helper

Rectangle {
	id: root
	height: 45
	radius: 8
	property variant message: null

	RowLayout {
		anchors.fill: parent
		anchors.margins: 5

		Label {
			id: filename_text
			color: theme.text
			Layout.fillWidth: true
			font.pixelSize: 10
		}

		ToolButtonIcon {
			color: "transparent"

			Label {
				anchors.centerIn: parent
				text: "open"
				color: theme.accent
			}
		}
	}

	Component.onCompleted: {
		if (message !== null) {
			if (message.type === Constants.PRIVATE_MESSAGE_TYPE_BINARY_FILE)
				filename_text.text = Helper.truncate(
							String(Helper.filenameFromUrl(message.filename)),
							20)
		}
	}
}
