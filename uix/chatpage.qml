import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import "./components/app"

Page {
	id: root
	background: Rectangle{
		color: theme.background
	}

	StackView{
		anchors.fill: parent

		ChatPage{
			anchors.fill: parent
		}
	}
}