import QtQuick 2.15
import QtQuick.Controls 2.15

ListModel{
	id: root

	readonly property list<Connections> connections:[
		Connections{
			id: con1
			target: client

			function _prepNewPeer(peer){
				/* fills empty data for new peer. this should not be saved to database.
				  only to be used in model.
				*/
				peer._id = -1
				peer.avatar = ''
				peer.last_interaction = new Date().toJSON()
			}

			function hasPeerWithUID(uid){
				/* returns the index of the person with uid=$uid.
					if no peer exist returns null
				*/
				for (let i=0; i<root.count; i++){
					const peer_at_i = root.get(i)
					if (peer_at_i.uid === uid){
						return i
					}
				}
				return null
			}

			function onNewPeerJoined(message){
				/* handles when a new peer has joined.
				  the persons data is contained in $message.client
				*/

				const client = message.client
				con1.addClientDataToModel(client)
			}

			function onContactListReceived(message){
				const clients = message.clients
				clients.forEach(function(client){
					con1.addClientDataToModel(client)
				})
			}

			function addClientDataToModel(client){
				/* adds a single client data to the model.
				*/
				con1._prepNewPeer(client)
				const peer_uid = con1.hasPeerWithUID(client.uid)

				if (peer_uid === null){
					root.append(client)
				}else{
					// if the person exists, try to update the data in model.
					// database update would have already been done in python script, Helper class.
					root.set(peer_uid, client)
				}
			}

			function onClientProfileUpdateReceived(data){
				const uid = data.uid
				const profile = data.profile

				const i = con1.hasPeerWithUID(uid)
				if (i!==null){
					root.set(i, profile)
				}
			}
		}
	]

	Component.onCompleted: {
		const peers = helper.peersList()
		peers.forEach(function(peer){
			root.append(peer)
		})
	}
}
