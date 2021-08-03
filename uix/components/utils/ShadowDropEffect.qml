import QtQuick 2.15
import QtGraphicalEffects 1.15

DropShadow{
	id: root
	verticalOffset: 0
	horizontalOffset: 0
	color: theme.darkmode ? "#55000000" : "#22695EE7"
	radius: 10
	samples: 8
	spread: 0
}
