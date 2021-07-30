import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

RowLayout {
	id: root
	property bool showAtLeft: true
	property alias txt: text_.text

	Item{
		Layout.fillWidth: !showAtLeft
		Layout.preferredHeight: 5
	}

	// main stuff
	ColumnLayout{
		spacing: 1

		Rectangle{
			id: balloon_rect
			color: showAtLeft ? theme.secondary : theme.accent
			radius: 10
			Layout.preferredHeight: childrenRect.height + 20
			Layout.preferredWidth: childrenRect.width + 20

			Label{
				id: text_
				color: showAtLeft ? theme.text : "white"
				anchors.centerIn: parent
			}
		}

		Label{
			id: time_text
			font.pixelSize: 9
			horizontalAlignment: showAtLeft ? Text.AlignLeft : Text.AlignRight
			verticalAlignment: Text.AlignVCenter
			color: theme.disabled
			text: "00:00am"
			Layout.preferredWidth: balloon_rect.width

		}
	}

	Item{
		Layout.fillWidth: showAtLeft
		Layout.preferredHeight: 5
	}
}
