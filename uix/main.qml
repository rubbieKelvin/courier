import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15
import Qt.labs.settings 1.1
import Qt.labs.platform 1.1
import QtMultimedia 5.12
import "./components/app"
import "./components/utils"
import "./components/popup"
import "./components/models"
import "./components/utils/svg.js" as Svg
import "./components/utils/constants.js" as Constants

ApplicationWindow {
	id: application
	visible: true
	width: 1000
	height: 650
	minimumHeight: 500
	minimumWidth: 300
	title: "Courier"
	font.family: poppins_regular.name
	font.pixelSize: 12
	background: Rectangle {
		color: theme.background
	}

	property Audio currentAudio
	property string settingsFileName: "settings.ini"
	property ContactModel contact_model: ContactModel {}
	readonly property bool minimal: (application.width < 400)

	// when a peer is clicked on the left side, this value will change
	// which will then be used to update the chatstack
	property int _currentPeerIndex: -1

	// this property tells what state the server/client pair is in
	readonly property string courier_state: {
		if (!client || !server)
			return Constants.COURIER_MODE_IDLE

		if (!server.running && !client.running) {
			return Constants.COURIER_MODE_IDLE
		} else if (!server.running && client.running) {
			return Constants.COURIER_MODE_CLIENT
		} else if (server.running && client.running) {
			return Constants.COURIER_MODE_SERVER
		} else {
			return Constants.COURIER_MODE_SETTING_SERVER
		}
	}

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

	Settings {
		id: notif_settings
		fileName: settingsFileName
		category: "Notification"
		property bool do_not_disturb: false
	}

	Theme {
		id: theme
		darkmode: apperance_settings.darkmode
	}

	FontLoader {
		id: poppins_regular
		source: "assets/fonts/Poppins/Poppins-Regular.ttf"
	}

	HelperFunctions {
		id: _
	}

	AppHeader {
		id: header
		anchors.left: parent.left
		anchors.right: parent.right
		property string currentPageName: "chat"

		onRequestPage: {
			if (currentPageName == pagename)
				return
			currentPageName = pagename

			if (pagename == "chat") {
				main_stack.replace("./chatpage.qml")
			} else if (pagename == "file") {
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

		LeftSection {
			Layout.preferredWidth: width
			Layout.fillHeight: true
		}

		StackLayout {
			id: main_stack
			Layout.fillHeight: true
			Layout.fillWidth: true
			clip: true

			Chat {
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
		}
	}

	SystemTrayIcon {
		visible: true
		icon.source: "qrc:/uix/assets/images/logo.png"
		tooltip: "Courier - stuffsbyrubbie"
		menu: Menu {

			MenuItem {
				enabled: courier_state !== Constants.COURIER_MODE_CLIENT
						 && courier_state !== Constants.COURIER_MODE_SERVER
				text: qsTr("Create Server")
				onTriggered: {
					header.avatar.menu.openCreateServerPopup()
					application.raise()
				}
			}

			MenuItem {
				enabled: courier_state !== Constants.COURIER_MODE_CLIENT
						 && courier_state !== Constants.COURIER_MODE_SERVER
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
				enabled: courier_state == Constants.COURIER_MODE_SERVER
						 || courier_state == Constants.COURIER_MODE_CLIENT
				text: qsTr((courier_state
							== Constants.COURIER_MODE_SERVER) ? "Shutdown Server" : "Leave Server")
				onTriggered: _.shutdownCourierNetwork()
			}

			MenuItem {
				text: qsTr("Quit")
				onTriggered: Qt.quit()
			}
		}
	}
}

/* TODO: make the stack that holds chatpage.qml and filepage.qml a StackLayout instead of StackView
  so the chatpage.qml doesnt reconstruct every time, costing us machine resource.
*/


/*##^##
Designer {
	D{i:0;formeditorZoom:0.66}
}
##^##*/

