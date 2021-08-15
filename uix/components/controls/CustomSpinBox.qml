import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

SpinBox {
	id: root
	property string prefix: ""

	background: Rectangle {
		implicitWidth: 250
		color: "transparent"
	}

	contentItem: RowLayout {
		x: root.down.indicator.x + root.down.indicator.width + root.spacing
		width: root.width - (this.x * 2)

		Label {
			text: root.prefix
			color: theme.text
			font.pixelSize: theme.fontsize.normal
			horizontalAlignment: Text.AlignRight
			verticalAlignment: Text.AlignVCenter
			Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
			Layout.preferredWidth: !!text ? parent.width / 2 : 0
		}

		Label {
			text: root.textFromValue(root.value) || root.value
			color: theme.accent
			font.pixelSize: theme.fontsize.normal
			verticalAlignment: Text.AlignVCenter
			Layout.preferredWidth: !!text ? parent.width / 2 : 0
		}
	}

	up.indicator: CustomSpinBoxIndicator {
		x: parent.width - (width + root.rightPadding)
		label.text: "+"
		label.color: root.up.pressed ? theme.accent : theme.text
	}

	down.indicator: CustomSpinBoxIndicator {
		x: root.leftPadding
		label.text: "-"
		label.color: root.down.pressed ? theme.accent : theme.text
	}
}
