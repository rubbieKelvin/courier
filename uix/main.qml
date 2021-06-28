import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
	id: application
	visible: true
	width: 600
	height: 450

	StackView {
		anchors.fill: parent
		initialItem: "select_mode.qml"
	}
}
/*##^##
Designer {
	D{i:0;formeditorZoom:0.9}
}
##^##*/

