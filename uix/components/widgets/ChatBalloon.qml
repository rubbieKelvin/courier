import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../utils/svg.js" as Svg

RowLayout {
	id: root
	property bool showAtLeft: true
	property string label: ""
	property int maxLabelWidth: 400

	Item{
		Layout.fillWidth: !showAtLeft
		Layout.preferredHeight: 5
	}

	// main stuff
	ColumnLayout{
		id: columnLayout
		spacing: 8

		Label{
			id: text_
			text: label
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
				if (root.state === "sticker")
					source = Svg.fromString([label])
			}

		}

		Label{
			id: time_text
			font.pixelSize: 8
			horizontalAlignment: showAtLeft ? Text.AlignLeft : Text.AlignRight
			verticalAlignment: Text.AlignVCenter
			color: theme.disabled
			text: "00:00am"
			Layout.preferredWidth: {
				if (root.state === ""){
					return text_.width
				}else if (root.state === "sticker"){
					return image.width
				}
			}

		}

	}

	Item{
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
		}
 ]
}

/*##^##
Designer {
	D{i:0;formeditorZoom:0.33;width:1300}
}
##^##*/
