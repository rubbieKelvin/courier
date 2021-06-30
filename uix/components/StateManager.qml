import QtQuick 2.15

QtObject {
	id: root
	property bool waitingForAuth: false
	readonly property ListModel peermodel: ListModel {}
	readonly property ListModel chatmodel: ListModel {}

	signal requireAuth
	signal handshakeDone(bool successful)

	function createServer(password) {
		server.set_password(password)
		if (server.run()) {
			// create client
			client.connect_to(":self")
			waitingForAuth = true

			return true
		} else {
			return false
		}
	}

	function connectToServer(hostname) {
		client.connect_to(hostname)
		waitingForAuth = true
	}

	readonly property list<Connections> connections: [
		Connections {
			target: client

			function onHandshakeReceived(message) {
				if (root.waitingForAuth) {
					if (message.body === "$auth") {
						requireAuth()
					} else if (message.body === "$successfull"
							   || message.body === "$no-auth") {
						root.waitingForAuth = false
						handshakeDone(true)
					} else {
						handshakeDone(false)
					}
				}
			}

			function onNewPeerJoined(message) {
				const peer = message.body
				peermodel.append(peer)
			}

			function onContactListReceived(message) {
				const contact_list = message.body
				contact_list.forEach(function (peer) {
					peermodel.append(peer)
				})
			}
		}
	]

	onHandshakeDone: {
		if (successful){
			// update profile
			const profile = {
				"username": helper.hostname()
			}
			client.update_profile(profile)
		}
	}
}
