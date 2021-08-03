import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import "../utils"

Button {
	id: root
	property alias bg_color: bg.color
	property alias fg_color: text_.color
	property bool busy: false

	background: Rectangle{
		id: bg
		radius: 6
		color: theme.accent_light

		RippleArea{
			clipRadius: bg.radius
			anchors.fill: parent
			color: "#44c8c8c8"
			onClicked: root.clicked()

			Rectangle{
				width: 20
				height: 30
				color: "#00000000"
				anchors.verticalCenter: parent.verticalCenter
				anchors.horizontalCenter: parent.horizontalCenter
				visible: root.busy

				onVisibleChanged: {
					if(visible){
						anim.restart()
					}else{
						anim.stop()
					}
				}

				RowLayout {
					anchors.fill: parent

					Rectangle{
						id: bud
						radius: 2
						Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
						Layout.preferredHeight: 4
						Layout.preferredWidth: 4
						color: theme.text
						opacity: 0
					}

					Rectangle{
						id: bud_2
						radius: 2
						Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
						Layout.preferredHeight: 4
						Layout.preferredWidth: 4
						color: theme.text
						opacity: 0
					}

					Rectangle{
						id: bud_3
						radius: 2
						Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
						Layout.preferredHeight: 4
						Layout.preferredWidth: 4
						color: theme.text
						opacity: 1
					}
				}

				SequentialAnimation{
					id: anim
					loops: -1
					property int _delay_int: 200

					ParallelAnimation{
						NumberAnimation {
							target: bud
							easing.type: Easing.InQuad
							properties: "opacity"
							duration: anim._delay_int
							from: 0
							to: 1
						}

						NumberAnimation {
							target: bud_3
							property: "opacity"
							duration: anim._delay_int
							easing.type: Easing.InQuad
							from: 1
							to: 0
						}
					}
					ParallelAnimation{
						NumberAnimation {
							target: bud_2
							easing.type: Easing.InQuad
							properties: "opacity"
							duration: anim._delay_int
							from: 0
							to: 1
						}

						NumberAnimation {
							target: bud
							property: "opacity"
							duration: anim._delay_int
							easing.type: Easing.InQuad
							from: 1
							to: 0
						}
					}
					ParallelAnimation{
						NumberAnimation {
							target: bud_3
							easing.type: Easing.InQuad
							properties: "opacity"
							duration: anim._delay_int
							from: 0
							to: 1
						}

						NumberAnimation {
							target: bud_2
							property: "opacity"
							duration: anim._delay_int
							easing.type: Easing.InQuad
							from: 1
							to: 0
						}
					}
				}
			}
		}
		
		
	}
	contentItem: Label{
		id: text_
		font: root.font
		text: root.text
		visible: !busy
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		color: theme.accent

	}
}

/*##^##
Designer {
	D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
