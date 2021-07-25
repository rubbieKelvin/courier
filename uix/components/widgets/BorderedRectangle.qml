import QtQuick 2.15

Rectangle{
	id: root
	property alias topborder: topborder
	property alias bottomborder: bottomborder
	property alias leftborder: leftborder
	property alias rightborder: rightborder

	Rectangle{id: topborder; width: parent.width; height: 1; anchors.top: parent.top; color: "transparent"}
	Rectangle{id: bottomborder; width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "transparent"}
	Rectangle{id: leftborder; width: 1; height: parent.height; anchors.left: parent.left; color: "transparent"}
	Rectangle{id: rightborder; width: 1; height: parent.height; anchors.right: parent.right; color: "transparent"}
}
