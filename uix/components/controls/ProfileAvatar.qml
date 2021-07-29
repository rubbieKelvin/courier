import QtQuick 2.15
import QtQuick.Controls 2.15
import "../popup"
import "../utils/constants.js" as Constant

Rectangle{
	id: root
	color: "#55000000"
	radius: width / 2
	property alias menu: menu

	RoundImage{
		source: "../../assets/avatars/001-man.svg"
		anchors.fill: parent
		sourceSize.height: 34
		sourceSize.width: 34
		radius: width/2
	}

	MouseArea{
		cursorShape: Qt.PointingHandCursor
		hoverEnabled: true
		anchors.fill: parent
		onClicked: menu.open()
	}

	UserMenu{
		id: menu
		x: -width-10
		y: 15
	}

	Rectangle{
		x: 25
		y: 30
		radius: width/2
		anchors.left: parent.left
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 2
		anchors.leftMargin: 2
		width: 8
		height: width
		border.color: theme.stroke
		border.width: 1
		color: (courier_state === Constant.COURIER_MODE_CLIENT || courier_state === Constant.COURIER_MODE_SERVER) ? theme.online : theme.offline
	}

}

/*##^##
Designer {
	D{i:0;autoSize:true;formeditorZoom:10;height:40;width:40}
}
##^##*/
