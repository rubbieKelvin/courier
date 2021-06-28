import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Button {
	id: root
	property color budColor: "#000000"
	property int delay_interval: 200

	onEnabledChanged: {
		if (enabled)
			anim.stop()
		else
			anim.restart()
	}

	RowLayout {
		anchors.centerIn: parent
		spacing: 4
		visible: !root.enabled

		Rectangle {
			id: bud
			radius: 2
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.preferredHeight: 4
			Layout.preferredWidth: 4
			color: budColor
			opacity: 0
		}

		Rectangle {
			id: bud_2
			radius: 2
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.preferredHeight: 4
			Layout.preferredWidth: 4
			color: budColor
			opacity: 0
		}

		Rectangle {
			id: bud_3
			radius: 2
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.preferredHeight: 4
			Layout.preferredWidth: 4
			color: budColor
			opacity: 1
		}
	}

	SequentialAnimation {
		id: anim
		loops: -1
		ParallelAnimation {
			NumberAnimation {
				target: bud
				easing.type: Easing.InQuad
				properties: "opacity"
				duration: delay_interval
				from: 0
				to: 1
			}

			NumberAnimation {
				target: bud_3
				property: "opacity"
				duration: delay_interval
				easing.type: Easing.InQuad
				from: 1
				to: 0
			}
		}
		ParallelAnimation {
			NumberAnimation {
				target: bud_2
				easing.type: Easing.InQuad
				properties: "opacity"
				duration: delay_interval
				from: 0
				to: 1
			}

			NumberAnimation {
				target: bud
				property: "opacity"
				duration: delay_interval
				easing.type: Easing.InQuad
				from: 1
				to: 0
			}
		}
		ParallelAnimation {
			NumberAnimation {
				target: bud_3
				easing.type: Easing.InQuad
				properties: "opacity"
				duration: delay_interval
				from: 0
				to: 1
			}

			NumberAnimation {
				target: bud_2
				property: "opacity"
				duration: delay_interval
				easing.type: Easing.InQuad
				from: 1
				to: 0
			}
		}
	}
}
