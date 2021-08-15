import QtQuick 2.15
import QtQuick.Controls 2.15
import "../utils/svg.js" as Svg

TextField {
	id: root
	leftPadding: 30
	placeholderText: qsTr("Search Courrier..")
	font.pixelSize: theme.fontsize.normal

	background: Rectangle {
		id: rectangle
		height: parent.height
		width: parent.width
		radius: height / 2
		color: "transparent"

		Image {
			anchors.verticalCenter: parent.verticalCenter
			source: Svg.fromString(
						['<svg width="18" height="18" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">', `<ellipse cx="9.80553" cy="9.8055" rx="7.49047" ry="7.49047" stroke="${root.focus ? theme.accent : theme.disabled}" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>`, `<path d="M15.0153 15.4043L17.9519 18.3333" stroke="${root.focus ? theme.accent : theme.disabled}" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>`, '</svg>'])
			sourceSize.height: 20
			sourceSize.width: 20
		}
	}

	onFocusChanged: {
		anim.from = root.leftPadding
		anim.to = focus ? 35 : 30
		anim.restart()
	}

	color: theme.text

	NumberAnimation {
		id: anim
		target: root
		property: "leftPadding"
		duration: 200
		easing.type: Easing.InOutQuad
	}
}
