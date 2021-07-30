import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

RowLayout {
	id: root
	property bool showAtLeft: true
	property alias label: text_
	property int maxLabelWidth: 400

	Item{
		Layout.fillWidth: !showAtLeft
		Layout.preferredHeight: 5
	}

	// main stuff
	ColumnLayout{
		spacing: 8

		Label{
			id: text_
			color: showAtLeft ? theme.text : "white"
			font.pixelSize: 10
			wrapMode: Text.WordWrap
			padding: 10
			Layout.maximumWidth: maxLabelWidth
			background: Rectangle{
				radius: 10
				color: showAtLeft ? theme.secondary : theme.accent
			}
		}

		Label{
			id: time_text
			font.pixelSize: 8
			horizontalAlignment: showAtLeft ? Text.AlignLeft : Text.AlignRight
			verticalAlignment: Text.AlignVCenter
			color: theme.disabled
			text: "00:00am"
			Layout.preferredWidth: text_.width

		}
	}

	Item{
		Layout.fillWidth: showAtLeft
		Layout.preferredHeight: 5
	}
}

/*##^##
Designer {
	D{i:0;formeditorZoom:0.33;width:1300}
}
##^##*/
