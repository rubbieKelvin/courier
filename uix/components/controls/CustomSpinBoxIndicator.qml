import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Rectangle {
	id: root
	radius: 4
	implicitHeight: 30
	implicitWidth: 30
	anchors.verticalCenter: parent.verticalCenter
	color: theme.secondary

	property alias label: label

	Label {
		id: label
		font.pixelSize: theme.fontsize.normal
		anchors.centerIn: parent
	}
}
