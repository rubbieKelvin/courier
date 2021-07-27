import socket

from . import PORT
from . import logger
from uuid import uuid4
from typing import Set
from typing import Union

from PySide2.QtCore import Slot
from PySide2.QtCore import Signal
from PySide2.QtCore import Property
from PySide2.QtCore import QByteArray
from PySide2.QtNetwork import QHostAddress
from PySide2.QtWebSockets import QWebSocket
from PySide2.QtWebSockets import QWebSocketServer

from .queue import MessageQueue

from .messages import Text
from .messages import Binary
from .messages import PrivateTextMessage

from .messages import INTENT_HANDSHAKE

from .messages import Json
from .messages import AuthStatusMessage
from .messages import ClientDataMessage
from .messages import ConnectedClientsMessage


class CourierClientDummy:
	"""used to hold all data about the virtual client...
	including client object"""

	def __init__(self, client: QWebSocket, username: str, uid: str) -> None:
		self.client = client
		self.uid = uid
		self.username = username

	def to_dict(self) -> dict:
		return dict(
			username=self.username,
			uid=self.uid
		)

	def __repr__(self) -> str:
		return f"<ClientD id={self.uid} username={self.username}>"


class CourierServer(QWebSocketServer):

	def __init__(self):
		"""
		HOW IT WORKS:
		1. the server starts listening for clients,
		2. the server then recieves a message body from client containing:
			- uid: str
			- username: str
			- password: str
		4. the server checks the password...
			and then sends a status message to client...
			while creating a dummy profile here.
		5. the client is added to the network and ready to go.

		* in this commit, password on server is compulsary
		* removed HANDSHAKE_NO_AUTH. cause there'll always be auth
		"""

		super(CourierServer, self).__init__("courier", QWebSocketServer.NonSecureMode)
		self.clients: Set[CourierClientDummy] = set()
		self.password = ""
		self._running = False
		self.queue = MessageQueue("server")

		self.newConnection.connect(self.on_new_connection)
		self.closed.connect(self.on_connection_closed)
		self.queue.currentItemUpdated.connect(self.handleQueue)

	runningChanged = Signal(bool)

	def handleQueue(self):
		"""
		this function is triggered when ever the 0th item in self.queue is changed.
		once the 0th item is changed it will be sent over the network as text or as byte.
		after which the item will be deleted as the newxt one comes in for proccessing.
		"""
		client: QWebSocket
		message: Union[str, QWebSocket]
		current = self.queue.current

		if not (current is None):
			client, message = current
			if type(message) is str:
				client.sendTextMessage(message)
			elif type(message) is QByteArray:
				client.sendBinaryMessage(message)
			else:
				raise TypeError
			self.queue.reverse_pop()

	def sendBinaryMessage(self, client: QWebSocket, data: QByteArray):
		"""overides QWebSocket's implementation to enable
		ordered data be recieved on the other end as they are sent here.
		"""
		self.queue.add((client, data))

	def sendTextMessage(self, client: QWebSocket, message: str):
		"""overides QWebSocket's implementation to enable
		ordered data be recieved on the other end as they are sent here.
		"""
		self.queue.add((client, message))

	@Property(bool, notify=runningChanged)
	def running(self) -> bool:
		"""holds server runnning state, for use in qml/js files."""
		return self._running and self.isListening()

	@Slot(str)
	def set_password(self, password: str):
		""""set server password.
		this method best has its effect before run menthos is called"""
		self.password = password

	# noinspection PyTypeChecker
	@Slot(result=bool)
	def run(self) -> bool:
		""" this method will make the server start listening for connections
		"""

		# get host ip
		host_name = socket.gethostname()
		host_ip = socket.gethostbyname(host_name)

		if self.listen(QHostAddress(host_ip), PORT):
			logger.log(f"running on {self.serverUrl()}")

			self._running = True
			# noinspection PyUnresolvedReferences
			self.runningChanged.emit(True)
			return True
		
		logger.log(f"could not run server.")
		return False

	def add_client(self, client: CourierClientDummy):
		"""
		 this method will send data of existing clients to new client,
		 send new client's data to old clients,
		 and then add client to clients set.
		"""

		# tell client whose has been here
		if len(self.clients):
			message = ConnectedClientsMessage(clients=[c.to_dict() for c in self.clients])
			self.sendTextMessage(client.client, str(message))

		# tell others client joined
		message = ClientDataMessage(client=client.to_dict())
		for dummy in self.clients:
			self.sendTextMessage(dummy.client, str(message))
		
		self.clients.add(client)

	def on_new_connection(self):
		"""
		This method is called once a new client has connected to server
		"""

		client: QWebSocket = self.nextPendingConnection()

		client.disconnected.connect(self.on_client_disconnected)
		client.textMessageReceived.connect(self.on_text_received)
		# noinspection PyUnresolvedReferences
		client.binaryMessageReceived.connect(self.on_binary_received)

	def on_connection_closed(self):
		self._running = False
		# noinspection PyUnresolvedReferences
		self.runningChanged.emit(False)

	def on_client_disconnected(self):
		# noinspection PyUnusedLocal
		client: QWebSocket = self.sender()

	def on_text_received(self, text: str):
		"""
		This method is called once a text is sent to the server
		"""

		client: QWebSocket = self.sender()
		message: Json = Json.from_str(text)

		if message.get('intent') == INTENT_HANDSHAKE:
			self.handle_handshake_intent(client, message)

		else:
			logger.warn("message with unregistered intent:", message)

		# elif message.get('intent') == INTENT_BROADCAST:
		# 	self.handle_broadcast_intent(client, message)

		# elif message.get('intent') == INTENT_PROFILE_UPDATE:
		# 	self.handle_profile_update_intent(client, message)
		
		# elif message.get('intent') == INTENT_PRIVATE_MESSAGE:
		# 	self.handle_private_message(client, PrivateTextMessage.fromStr(text))

	def on_binary_received(self, data: QByteArray):
		client: QWebSocket = self.sender()
		client_dummy = self.get_client_dummy_from_qwebsocket_object(client)

		binary: Binary = Binary.fromQByteArray(data)
		binary.sign(client_dummy.unique_id)

		receiver_uid = binary.body.get("receiver_uid")
		receiver: QWebSocket
		for dummy in self.clients:
			if dummy.unique_id == receiver_uid:
				receiver = dummy.client
				self.sendBinaryMessage(receiver, binary.toQByteArray())
				return

	def handle_handshake_intent(self, client: QWebSocket, message: Json):
		"""
		handle messages with intent=1.
		"""
		uid = message.get('uid')
		password = message.get('password')
		username = message.get("username")
		message = AuthStatusMessage(successful=(password==self.password))

		if password==self.password:
			dummy = CourierClientDummy(uid=uid, username=username, client=client)
			self.add_client(dummy)

		self.sendTextMessage(client, str(message))
			

	def handle_broadcast_intent(self, client: QWebSocket, message: Text):
		client_dummy = self.get_client_dummy_from_qwebsocket_object(client)
		message.meta["from"] = client_dummy.username
		for dummy in self.clients:
			if dummy != client_dummy:
				self.sendTextMessage(dummy.client, str(message))

	def handle_profile_update_intent(self, client: QWebSocket, message: Text):
		client_dummy = self.get_client_dummy_from_qwebsocket_object(client)
		profile: dict = message.body

		if profile.get("username"):
			client_dummy.username = profile.get("username")

		# now tell everyone asides $client that he updated his profile
		for dummy in self.clients:
			if dummy != client_dummy:
				self.sendTextMessage(dummy.client, str(message))

	# noinspection SpellCheckingInspection
	def get_client_dummy_from_qwebsocket_object(self, client: QWebSocket) -> CourierClientDummy:
		return list(filter(lambda d: d.client == client, self.clients))[0]

	def handle_private_message(self, client: QWebSocket, message: PrivateTextMessage):
		client_dummy = self.get_client_dummy_from_qwebsocket_object(client)
		message.sign(client_dummy.unique_id)
		
		# send to receiver
		receiver: QWebSocket
		for dummy in self.clients:
			if dummy.unique_id == message.body.get("receiver_uid"):
				receiver = dummy.client
				self.sendTextMessage(receiver, str(message))
				return

	@Slot()
	def shutdown(self):
		self.close()

# TODO: fix server shutdown bug
