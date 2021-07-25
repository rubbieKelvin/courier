import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.12
import "../controls"
import "../utils/svg.js" as Svg

Popup {
	id: root
	width: 110
	height: c_.height + 10
	padding: 0
	closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

	signal actionClicked(string action)

	background: Rectangle{
		color: theme.background
		radius: 6
		border.width: 1
		border.color: theme.stroke
		layer.enabled: true
		layer.effect: DropShadow{
			verticalOffset: 0
			horizontalOffset: 0
			color: theme.darkmode ? "#55000000" : "#22695EE7"
			radius: 10
			samples: 8
			spread: 0
		}
	}

	enter: Transition {
		NumberAnimation{property: "height"; duration: 100; from: 0; to: c_.height + 10}
		NumberAnimation{property: "width"; from: 0; to: 110; duration: 60}
	}

	exit: Transition {
		NumberAnimation{property: "height"; duration: 60; from: root.height; to: 0}
		NumberAnimation{property: "width"; from: root.width; to: 0; duration: 100}
	}

	ColumnLayout{
		id: c_
		y: 5
		width: parent.width
		spacing: 0

		MenuItemDelegate{
			Layout.fillWidth: true
			Layout.preferredHeight: 40
			text: "Mute"
			lefticon.enabled: false
			lefticon.visible: false

			onClicked: root.actionClicked("mute")

		}

		MenuItemDelegate{
			Layout.fillWidth: true
			Layout.preferredHeight: 35
			text: "Clear Chat"
			lefticon.enabled: false
			lefticon.visible: false

			onClicked: root.actionClicked("clear-chat")
		}

		MenuItemDelegate{
			Layout.fillWidth: true
			Layout.preferredHeight: 35
			showStroke: false
			text: "Delete Contact"
			lefticon.enabled: false
			lefticon.visible: false

			onClicked: root.actionClicked("delete")
		}

	}

	onActionClicked: {
		timer.start()
	}

	Timer{
		id: timer
		interval: 150
		onTriggered: root.close()
	}
}
