import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../widgets"

Page {
	id: root
	background: Rectangle{
		color: theme.background
	}

	ColumnLayout{
		anchors.fill: parent
		spacing: 0

		ChatHead{
			Layout.fillWidth: true
			Layout.preferredHeight: 40
		}

		ChatBody{
			Layout.fillHeight: true
			Layout.fillWidth: true
			list.model: 30
			list.delegate: ChatBalloon{
				width: (parent || {width: 0}).width
				showAtLeft: !!(modelData%3)
				label.text: "This is a simple example."
			}
		}

		ChatFooter{
			Layout.fillWidth: true

		}
	}
}

/*##^##
Designer {
	D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
