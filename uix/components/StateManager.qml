import QtQuick 2.15

QtObject {
	id: root
	property bool waitingForAuth: false
	readonly property ListModel peermodel: ListModel {}

	signal requireAuth
	signal handshakeDone(bool successful)

	function resetData(){
		waitingForAuth = false
		peermodel.clear()
	}

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
		waitingForAuth = client.connect_to(hostname)
		if (!waitingForAuth) handshakeDone(false)
	}

	readonly property list<Connections> connections: [
		Connections {
			target: client

			function onHandshakeReceived(message) {
				if (root.waitingForAuth) {
					if (message.body === "$auth") {
						requireAuth()
					} else if (message.body === "$successful"
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

			function onError(e){
				if (e === 0 || e === 2){
					// QAbstractSocket::ConnectionRefusedError	0	The connection was refused by the peer (or timed out).
					// QAbstractSocket::HostNotFoundError		2	The host address was not found.
					handshakeDone(false)
				}
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
