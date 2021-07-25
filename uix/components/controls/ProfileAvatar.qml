import QtQuick 2.15
import QtQuick.Controls 2.15
import "../popup"

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

}

/*##^##
Designer {
	D{i:0;formeditorZoom:8}
}
##^##*/
