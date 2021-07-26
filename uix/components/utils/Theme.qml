import QtQuick 2.0

QtObject{
	id: root
	property bool darkmode: false
	readonly property color accent: "#695EE7"
	readonly property color disabled: "#9F9F9F"
	readonly property color accent_light: darkmode ? "#2F2C55" : "#D2CFF8"
	readonly property color disabled_light: darkmode ? "3F3F3F" : "#E2E2E2"
	readonly property color background: darkmode ? "#161616" : "#ffffff"
	readonly property color secondary: darkmode ? "#0D0D0D" : "#F2F2F2"
	readonly property color text: darkmode ? "#C9C9C9" : "#333333"
	readonly property color text_light: darkmode ? "#696969" : "#A3A3A3"
	readonly property color stroke: darkmode ? "#1C1C1C" : "#F0F0F0"
	readonly property color offline: "#3f3f3f"
	readonly property color online: "#6ce463"
}
