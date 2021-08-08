import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import "../controls"
import "../utils/svg.js" as Svg

Page {
	id: root
	width: 280
	background: Rectangle {
		color: theme.background
	}

	ColumnLayout {
		anchors.fill: parent

		Rectangle {
			Layout.preferredHeight: 55
			Layout.fillWidth: true

			RowLayout {
				ToolButtonIcon {
					source: Svg.fromString(
								[`<svg width="15" height="14" viewBox="0 0 15 14" fill="none" xmlns="http://www.w3.org/2000/svg">`, `<path fill-rule="evenodd" clip-rule="evenodd" d="M1.13607 0.63604C0.940808 0.831302 0.940809 1.14788 1.13607 1.34315L6.79294 7.00002L1.1361 12.6569C0.940839 12.8521 0.940838 13.1687 1.1361 13.364C1.33136 13.5592 1.64795 13.5592 1.84321 13.364L7.50005 7.70712L13.1569 13.364C13.3521 13.5592 13.6687 13.5592 13.864 13.364C14.0593 13.1687 14.0593 12.8521 13.864 12.6569L8.20715 7.00002L13.864 1.34315C14.0593 1.14788 14.0593 0.831302 13.864 0.63604C13.6688 0.440778 13.3522 0.440778 13.1569 0.63604L7.50005 6.29291L1.84318 0.63604C1.64792 0.440778 1.33133 0.440778 1.13607 0.63604Z" fill="${theme.text}"/>`, `</svg>`])
				}

				Label {
					text: "Settings"
					color: theme.text
				}
			}
		}

		Rectangle {
			width: 200
			height: 200
			color: theme.stroke
			Layout.preferredHeight: 1
			Layout.fillWidth: true
		}

		ColumnLayout {
			width: 100
			height: 100
			Layout.rightMargin: 15
			Layout.leftMargin: 15
			Layout.fillHeight: true
			Layout.fillWidth: true
		}
	}
}

/*##^##
Designer {
	D{i:0;formeditorZoom:0.75;height:700}D{i:2}
}
##^##*/

