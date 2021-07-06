import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15

Rectangle {
	id: root
	height: _.childrenRect.height + 10

	property var pm: ({})

	ColumnLayout {
		id: _
		anchors.fill: parent
		anchors.margins: 5
		spacing: 3

		RowLayout {
			width: 100
			height: 100
			Layout.alignment: Qt.AlignLeft | Qt.AlignTop
			Layout.fillWidth: true

			Label {
				id: name
				text: pm.body.sender_uid || "Me"
				Layout.fillWidth: true
			}

			Label {
				id: time
				text: pm.datetime
			}
		}

		Label {
			id: msg_
			text: pm.body.text
			Layout.fillHeight: true
			Layout.fillWidth: true
			fontSizeMode: Text.Fit
			font.letterSpacing: 1
			lineHeight: 1.2
			font.pixelSize: 12
		}

		Rectangle {
			visible: pm.fileurl !== null && pm.fileurl !== undefined
			height: visible ? 60 : 0
			clip: true
			enabled: visible
			color: "#bdbdbd"
			Layout.fillWidth: true

			RowLayout {
				anchors.margins: 4
				anchors.fill: parent

				Label {
					text: "filename"
					Layout.fillWidth: true
				}

				Button {
					text: "view file"
				}
			}
		}
	}
}
