import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../controls"
import "../utils/svg.js" as Svg

Rectangle {
	id: root
	height: 40
	color: theme.secondary

	property string uid
	property string username
	property string avatar

	RowLayout{
		anchors.fill: parent
		anchors.leftMargin: 10
		anchors.rightMargin: 10
		spacing: 10

		RoundImage{
			sourceSize.width: 28
			sourceSize.height: 28
			Layout.preferredWidth: 28
			Layout.preferredHeight: 28
			radius: width/2
			source: avatar || "../../assets/images/unknown.svg"
			fillMode: Image.PreserveAspectCrop
		}

		Label{
			text: username
			Layout.fillWidth: true
			color: theme.text
		}

		ToolButtonIcon{
			visible: !application.minimal
			source: Svg.fromString([
			   '<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">',
			   '<path opacity="0.4" fill-rule="evenodd" clip-rule="evenodd" d="M13.215 6.29697C13.2302 6.40805 13.2445 6.51268 13.2521 6.65115L5.24182 14.6605H5.05656C3.88325 14.6605 3.02752 13.8313 2.86873 12.5435C2.69229 11.2556 2.72758 9.05043 2.86873 7.87725C3.03634 6.65997 3.93618 5.82199 5.05656 5.82199H6.58275L9.49398 3.43948C9.84685 3.14045 10.4732 2.85818 10.9584 2.84848C11.8406 2.84848 12.6522 3.46682 12.9433 4.45476C13.058 4.86846 13.1021 5.28392 13.1374 5.67998L13.208 6.24539C13.2103 6.26283 13.2127 6.27997 13.215 6.29697ZM12.4007 11.4429C12.5207 11.3256 12.7862 11.2427 12.9062 11.2727C13.2309 11.3556 13.2935 11.8204 13.2891 12.1856C13.2741 13.2459 13.2379 13.9833 13.1815 14.4394L13.1418 14.8151L13.1411 14.8222C13.1033 15.2002 13.0643 15.5913 12.953 16.0086C12.6583 16.9948 11.8705 17.6351 10.976 17.6351C10.946 17.6351 10.9169 17.6351 10.8869 17.6343C10.3928 17.6343 9.8556 17.3379 9.55124 17.0794L8.46703 16.2406C8.05593 15.9345 8.17679 15.4449 8.40792 15.1618C8.58046 14.9511 10.6536 13.0484 11.7435 12.0481C12.1136 11.7085 12.3703 11.4729 12.4007 11.4429Z" fill="#695EE7"/>',
			   '<path d="M18.1063 2.72482C17.7949 2.42403 17.3167 2.4258 17.0168 2.7257L2.72529 17.0155C2.42446 17.3163 2.42446 17.7953 2.72794 18.1102C2.8832 18.2539 3.07552 18.3333 3.27048 18.3333C3.46986 18.3333 3.67453 18.2495 3.81656 18.1075L18.1072 3.81773C18.4089 3.51605 18.4089 3.02738 18.1063 2.72482Z" fill="#695EE7"/>',
			   '</svg>',
			])
			tiptext: "Mute this person"
		}
	}
}
