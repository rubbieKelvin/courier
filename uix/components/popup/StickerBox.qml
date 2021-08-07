import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import "../controls"
import "../utils/svg.js" as Svg
import QtGraphicalEffects 1.12
import "../utils"
import "../utils/emoji.js" as EmojiJS

Popup {
	id: root
	padding: 0
	closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
	clip: application.minimal
	background: Rectangle{
		radius: 5
		color: theme.background
		border.width: 1
		border.color: theme.stroke
		layer.enabled: !application.minimal
		layer.effect: ShadowDropEffect{}

		Rectangle{
			width: parent.width
			height: 100
			color: theme.secondary
			radius: 5
		}
	}
	enter: Transition {
		NumberAnimation{property: "height"; duration: 100; from: 0; to: application.minimal ? application.height : c1_.height + 10}
		NumberAnimation{property: "width"; from: 0; to: application.minimal ? application.width : c1_.width; duration: 60}
	}

	exit: Transition {
		NumberAnimation{property: "height"; duration: 60; from: root.height; to: 0}
		NumberAnimation{property: "width"; from: root.width; to: 0; duration: 100}
	}

	signal emojiSelected(string source)

	QtObject{
		id: tones
		property int currentIndex: 0
		readonly property string currentTone: list[currentIndex]
		readonly property var list: [
			"#F9B914",
			"white",
			"red",
			"#FFE0E0",
			"#E0FFE3",
			"#7FC0FC"
		]
		function next(){
			currentIndex = (currentIndex + 1) % list.length
		}
	}

	ColumnLayout{
		id: c1_
		width: application.minimal ? parent.width : 300
		height: application.minimal ? parent.height : 320
		spacing: 0
		y: 5

		Rectangle{
			color: theme.secondary
			Layout.fillWidth: true
			Layout.preferredHeight: 45

			RowLayout{
				anchors.rightMargin: 10
				anchors.leftMargin: 10
				anchors.topMargin: 5
				anchors.bottomMargin: 5
				anchors.fill: parent

				Image{
					source: Svg.fromString([
					   '<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">',
					   '<rect opacity="0.4" width="20" height="20" rx="4" fill="#695EE7"/>',
					   '<path d="M3 6C4 5 6 5 7 6" stroke="#695EE7" stroke-linecap="round"/>',
					   '<path d="M13 6C14 5 16 5 17 6" stroke="#695EE7" stroke-linecap="round"/>',
					   '<circle cx="6" cy="8" r="1" fill="#695EE7"/>',
					   '<circle cx="16" cy="8" r="1" fill="#695EE7"/>',
					   '<path d="M11 4C9.33331 6 7.70001 9.2 8.50001 10C9.50001 11 10.5 10.5 11 11.5C11.3578 12.2155 9.66667 14.1667 9 15" stroke="#695EE7" stroke-linecap="round"/>',
					   '</svg>'
					])
					sourceSize.height: 20
					sourceSize.width: 20
					height: 20
					width: 20
				}

				Label{
					text: "Sticker Set"
					color: theme.text
					Layout.fillWidth: true
				}

				ToolButtonIcon{
					source: Svg.fromString([
					   '<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">',
					   '<path opacity="0.4" d="M16.6604 15.7944H11.9152C11.4522 15.7944 11.0757 16.1769 11.0757 16.6472C11.0757 17.1184 11.4522 17.5 11.9152 17.5H16.6604C17.1234 17.5 17.5 17.1184 17.5 16.6472C17.5 16.1769 17.1234 15.7944 16.6604 15.7944" fill="#695EE7"/>',
					   '<path d="M8.59085 5.75323L13.0874 9.38664C13.1959 9.47354 13.2144 9.63299 13.1297 9.74407L7.79895 16.6902C7.46385 17.1193 6.97001 17.362 6.4409 17.371L3.5308 17.4068C3.37559 17.4086 3.23979 17.3011 3.20452 17.1471L2.54313 14.2715C2.42849 13.743 2.54313 13.1965 2.87823 12.7755L8.23547 5.79623C8.32189 5.68426 8.4815 5.66455 8.59085 5.75323" fill="#695EE7"/>',
					   '<path opacity="0.4" d="M15.1006 7.2212L14.2337 8.30334C14.1464 8.41352 13.9894 8.43144 13.881 8.34365C12.8272 7.49084 10.1287 5.30237 9.38001 4.69591C9.27066 4.60633 9.25567 4.44687 9.34386 4.33579L10.1799 3.29755C10.9382 2.32111 12.261 2.23153 13.3281 3.08255L14.5538 4.05899C15.0565 4.45314 15.3916 4.97271 15.5062 5.51916C15.6385 6.12025 15.4974 6.71059 15.1006 7.2212" fill="#695EE7"/>',
					   '</svg>'
					])
					onClicked: tones.next()
					tiptext: "Switch sticker tone"
				}
			}
		}

		Rectangle{
			Layout.fillWidth: true
			Layout.fillHeight: true
			color: theme.background

			ScrollView{
				clip: true
				anchors.fill: parent
				ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
				ScrollBar.vertical.policy: ScrollBar.AsNeeded

				GridView{
					id: emoji_grid
					model: EmojiJS.stickers.length
					cellHeight: width/5
					cellWidth: width/5
					anchors.fill: parent
					anchors.margins: 5
					clip: true
					boundsBehavior: Flickable.StopAtBounds
					delegate: Emoji{
						height: emoji_grid.width/5
						width: emoji_grid.width/5
						tone: tones.currentTone
						source: EmojiJS.stickers[modelData]

						onClicked: {
							let emoji = EmojiJS.stickers[modelData]
							emoji = emoji.replace("$tone", tone)
							root.emojiSelected(emoji)
							closer.restart()
						}
					}
				}
			}
		}
	}

	Timer{
		id: closer
		interval: 180
		repeat: false
		onTriggered: root.close()
	}

	Connections{
		target: application
		function onMinimalChanged() {
			root.close()
		}
	}
}
