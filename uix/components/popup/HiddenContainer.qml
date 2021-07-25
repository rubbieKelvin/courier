import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../widgets"

BorderedRectangle{
	id: root
	property bool shown: false
	visible: height !== 0
	bottomborder.color: theme.stroke
	color: theme.background
	property int virtualHeight: 50

	Component.onCompleted: {
		root.shown = false
		root.height = 0
	}

	onShownChanged: {
		anim.from = root.height
		anim.to = shown ? virtualHeight : 0
		anim.restart()
	}

	NumberAnimation {
		id: anim
		target: root
		property: "height"
		duration: 200
		easing.type: Easing.InOutQuad
	}
}
