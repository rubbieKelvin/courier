import QtQuick 2.15
import QtQuick.Controls 2.15
import "./components"

ApplicationWindow {
	id: application
	visible: true
	width: 600
	height: 450
	title: "Courier"

	readonly property StateManager statemanager: StateManager {}

	StackView {
		id: mainstack
		anchors.fill: parent
		initialItem: "select_mode.qml"
	}
}
/*##^##
Designer {
	D{i:0;formeditorZoom:0.9}
}
##^##*/

