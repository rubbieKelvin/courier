import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.13

MouseArea {
	id: root
	hoverEnabled: true
	cursorShape: Qt.PointingHandCursor

	property int _click_x: 0
	property int _click_y: 0
	property int clipRadius: 0
	property alias color: overlay_.color
//	readonly property bool : value

	onClicked: {
		overlay_.width = 0
		overlay_.height = 0
		overlay_.opacity = 1
		_click_x = mouseX
		_click_y = mouseY
		anim.restart()
		timer.restart()
	}

	Rectangle{
		id: ripple_clip
		anchors.fill: parent
		clip: true
		color: "transparent"
		radius: clipRadius
		layer.enabled: clipRadius>0
		layer.effect: OpacityMask {
			maskSource: Item {
				width: ripple_clip.width
				height: ripple_clip.height

				Rectangle {
					anchors.centerIn: parent
					width: ripple_clip.width
					height: ripple_clip.height
					radius: ripple_clip.radius
				}
			}
		}

		Rectangle{
			id: overlay_2
			color: Qt.lighter(overlay_.color, theme.darkmode ? 1.1 : 1.02)
			radius: width/2
			height: 0
			width: 0
			x: root._click_x - (width/2)
			y: root._click_y - (width/2)
		}

		Rectangle{
			id: overlay_
			color: "#22000000"
			radius: width/2
			width: 0
			height: 0
			x: root._click_x - (width/2)
			y: root._click_y - (height/2)
		}
	}

	SequentialAnimation{
		id: anim

		ParallelAnimation{

			NumberAnimation {
				target: overlay_
				property: "width"
				duration: 150
				from: 0
				to: Math.min(root.width*2, root.height*2)
			}

			NumberAnimation {
				target: overlay_
				property: "height"
				duration: 150
				from: 0
				to: Math.min(root.width*2, root.height*2)
			}
		}

		NumberAnimation {
			target: overlay_
			property: "opacity"
			duration: 100
			from: 1
			to: 0
		}
	}

	Timer{
		id: timer
		interval: Math.min(root.width*2, root.height*2)
		onTriggered: {
			overlay_2.width = 0
			overlay_2.height = 0
			overlay_2.opacity = 1
			anim_2.restart()
		}
	}

	SequentialAnimation{
		id: anim_2

		ParallelAnimation{

			NumberAnimation {
				target: overlay_2
				property: "width"
				duration: 200
				from: 0
				to: Math.max(root.width*2, root.height*2)
			}

			NumberAnimation {
				target: overlay_2
				property: "height"
				duration: 200
				from: 0
				to: Math.max(root.width*2, root.height*2)
			}
		}

		NumberAnimation {
			target: overlay_2
			property: "opacity"
			duration: 150
			from: 1
			to: 0
		}
	}
}
