import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15

Rectangle {
	id: root
	height: msg_.contentHeight+50

	property var pm: ({})

	ColumnLayout {
		anchors.fill: parent
		anchors.margins: 5

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
	}
}
