import socket

from . import PORT
from typing import Set
from random import randint

from PySide2.QtCore import Slot
from PySide2.QtCore import Signal
from PySide2.QtCore import qDebug
from PySide2.QtCore import QByteArray
from PySide2.QtNetwork import QHostAddress
from PySide2.QtWebSockets import QWebSocket
from PySide2.QtWebSockets import QWebSocketServer

from .messages import INTENT_PROFILE_UPDATE, Text
from .messages import INTENT_HANDSHAKE
from .messages import INTENT_BROADCAST


class CourierClientDummy:
	"""used to hold all data about the virtual client...
	including client object"""

	def __init__(self, client: QWebSocket) -> None:
		self.client = client
		self.username: str = "Anonymous"


class CourierServer(QWebSocketServer):
	HANDSHAKE_AUTH = "$auth"  # tell the client there's password on this server
	HANDSHAKE_NO_AUTH = "$no-auth"  # tell client there's no pasword on this server
	HANDSHAKE_SUCCESSFULL = "$successfull"  # tell client the handshake was successful
	HANDSHAKE_UNSUCCESSFULL = "$unsuccessfull"  # tell client the handshake was unsuccessful

	def __init__(self):
		super(CourierServer, self).__init__("courier", QWebSocketServer.NonSecureMode)
		self.newConnection.connect(self.on_new_connection)
		self.clients: Set[CourierClientDummy] = set()
		self.password: str = ""

	started = Signal()

	@Slot(str)
	def set_password(self, password: str):
		self.password = password

	@Slot()
	def run(self):
		# get host ip
		host_name = socket.gethostname()
		host_ip = socket.gethostbyname(host_name)

		if self.listen(QHostAddress(host_ip), PORT):
			qDebug(f"running on {self.serverUrl()}")
			self.started.emit()
		else:
			qDebug(f"could not run server.")

	def on_new_connection(self):
		client: QWebSocket = self.nextPendingConnection()

		# if there's a password, tell client to send auth
		if self.password:
			client.sendTextMessage(str(Text(CourierServer.HANDSHAKE_AUTH, intent=INTENT_HANDSHAKE)))
		# client will be added to set after providing password
		else:
			# tell client no need to provide password
			client.sendTextMessage(str(Text(CourierServer.HANDSHAKE_NO_AUTH, intent=INTENT_HANDSHAKE)))
			client_dummy = CourierClientDummy(client)
			self.clients.add(client_dummy)

		client.disconnected.connect(self.on_client_disconnected)
		client.textMessageReceived.connect(self.on_text_received)
		client.binaryMessageReceived.connect(self.on_binary_received)

	def on_client_disconnected(self):
		client: QWebSocket = self.sender()

	def on_text_received(self, text: str):
		client: QWebSocket = self.sender()
		message = Text.fromStr(text)

		if message.intent == INTENT_HANDSHAKE:
			self.handle_handshake_intent(client, message)
		elif message.intent == INTENT_BROADCAST:
			self.handle_broadcast_intent(client, message)
		elif message.intent == INTENT_PROFILE_UPDATE:
			self.handle_profile_update_intent(client, message)

	def on_binary_received(self, data: QByteArray):
		client: QWebSocket = self.sender()

	def handle_handshake_intent(self, client: QWebSocket, message: Text):
		password = message.body
		if password == self.password:
			client_dummy = CourierClientDummy(client)
			self.clients.add(client_dummy)
			return client.sendTextMessage(str(Text(CourierServer.HANDSHAKE_SUCCESSFULL, intent=INTENT_HANDSHAKE)))
		return client.sendTextMessage(str(Text(CourierServer.HANDSHAKE_UNSUCCESSFULL, intent=INTENT_HANDSHAKE)))

	def handle_broadcast_intent(self, client: QWebSocket, message: Text):
		client_dummy = self.get_client_dummy_from_qwebsocket_object(client)
		message.meta["from"] = client_dummy.username
		for dummy in self.clients:
			if dummy != client_dummy:
				dummy.client.sendTextMessage(str(message))

	def handle_profile_update_intent(self, client: QWebSocket, message: Text):
		client_dummy = self.get_client_dummy_from_qwebsocket_object(client)
		client_dummy.username = message.body.strip()

	def get_client_dummy_from_qwebsocket_object(self, client: QWebSocket) -> CourierClientDummy:
		return list(filter(lambda d: d.client == client, self.clients))[0]
