import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15
import Qt.labs.settings 1.1
import Qt.labs.platform 1.1
import "./components/app"
import "./components/utils"
import "./components/popup"

ApplicationWindow {
	id: application
	visible: true
	width: 1000
	height: 650
	title: "Courier"
	font.family: poppins_regular.name
	font.pixelSize: 12
	minimumHeight: 520
	minimumWidth: 740
	background: Rectangle{
		color: theme.background
	}

	property string settingsFileName: "settings.ini"

	Settings {
		category: "Window"
		fileName: settingsFileName
		property alias width: application.width
		property alias height: application.height
	}

	Settings {
		id: apperance_settings
		category: "Appearance"
		fileName: settingsFileName
		property bool darkmode: true
	}

	Settings{
		id: notif_settings
		fileName: settingsFileName
		category: "Notification"
		property bool do_not_disturb: false
	}

	Theme{
		id: theme
		darkmode: apperance_settings.darkmode
	}

	FontLoader{
		id: poppins_regular
		source: "assets/fonts/Poppins/Poppins-Regular.ttf"
	}

	AppHeader{
		id: header
		anchors.left: parent.left
		anchors.right: parent.right
		property string currentPageName: "chat"

		onRequestPage: {
			if (currentPageName == pagename) return
			currentPageName = pagename

			if (pagename == "chat"){
				main_stack.replace("./chatpage.qml")
			}else if (pagename == "file"){
				main_stack.replace("./filepage.qml")
			}
		}
	}

	RowLayout {
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.top: header.bottom
		anchors.bottom: parent.bottom
		anchors.topMargin: 0
		spacing: 0

		LeftSection{
			Layout.preferredWidth: 250
			Layout.fillHeight: true
		}

		StackView{
			id: main_stack
			Layout.fillHeight: true
			Layout.fillWidth: true
			initialItem: "./chatpage.qml"
			clip: true
		}
	}

	SystemTrayIcon {
		visible: true
		icon.source: "qrc:/uix/assets/images/logo.png"
		tooltip: "Courier - stuffsbyrubbie"
		menu: Menu {

			MenuItem {
				text: qsTr("Create Server")
				onTriggered: {
					header.avatar.menu.openCreateServerPopup()
					application.raise()
				}
			}

			MenuItem {
				text: qsTr("Join Server")
				onTriggered: {
					header.avatar.menu.openJoinServerPopup()
					application.raise()
				}
			}

			MenuItem {
				text: qsTr(notif_settings.do_not_disturb ? "Turn on notifications" : "Turn off notifications")
				onTriggered: {
					notif_settings.do_not_disturb = !notif_settings.do_not_disturb
				}
			}

			MenuItem {
				text: qsTr("Quit")
				onTriggered: Qt.quit()
			}
		}
	}
}

/*##^##
Designer {
	D{i:0;formeditorZoom:0.66}
}
##^##*/

