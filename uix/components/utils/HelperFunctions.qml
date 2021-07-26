import QtQuick 2.0

QtObject {
	id: root

	function createServer(password){
		server.set_password(password)
		return server.run()
	}

	function shutdownCourierNetwork(){
		server.shutdown()
		client.close()
	}

	function connectToServer(hostname, password){
		return helper.connectClientToServer(hostname, password)
	}
}
