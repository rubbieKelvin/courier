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
from PySide2.QtWebSockets import QWebSocketProtocol

from .queue import MessageQueue

from .messages import INTENT_HANDSHAKE
from .messages import INTENT_PROFILE_UPDATE
from .messages import INTENT_PRIVATE_MESSAGE
from .messages import INTENT_PROFILE_PHOTO_UPDATE

from .messages import Json
from .messages import JsonBinary
from .messages import AuthStatusMessage
from .messages import ClientDataMessage
from .messages import ConnectedClientsMessage
from .messages import ClientProfileUpdateWithUidMessage


class CourierClientDummy:
	"""used to hold all data about the virtual client...
	including client object"""

	# using this to reduce time complexity when searching for client dummy
	# with client:QWebSocket object. 
	MAP = dict()

	def __init__(self, client: QWebSocket, username: str, uid: str) -> None:
		self.client = client
		self.uid = uid
		self.username = username
		
		# profile photo will be sent
		# to new connections. it's stored here as a jsonbinary
		self.photo: JsonBinary = None

		# ...
		CourierClientDummy.MAP[self.client] = self

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

		# tell clients who has been here
		if len(self.clients):
			message = ConnectedClientsMessage(clients=[c.to_dict() for c in self.clients])
			self.sendTextMessage(client.client, str(message))

		# tell others client joined
		message = ClientDataMessage(client=client.to_dict())
		for dummy in self.clients:
			self.sendTextMessage(dummy.client, str(message))
			if dummy.photo:
				self.sendBinaryMessage(dummy.client, dummy.photo.to_qbytearray())

		self.clients.add(client)

	def on_new_connection(self):
		"""
		This method is called once a new client has connected to server
		"""

		client: QWebSocket = self.nextPendingConnection()

		client.disconnected.connect(self.on_client_disconnected)
		client.textMessageReceived.connect(self.on_text_received)
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
		intent: str = message.get('intent')

		if intent == INTENT_HANDSHAKE:
			self.handle_handshake_intent(client, message)

		elif intent == INTENT_PROFILE_UPDATE:
			self.handle_profile_update_intent(client, message)

		elif intent == INTENT_PRIVATE_MESSAGE:
			self.handle_private_message(client, message)

		else:
			logger.warn("message with unregistered intent:", message)

	def on_binary_received(self, data: QByteArray):
		client: QWebSocket = self.sender()
		dummy = self.get_dummy(client)

		message = JsonBinary.from_qbytearray(data)
		intent = message.get('intent')

		if intent == INTENT_PROFILE_PHOTO_UPDATE:
			self.handle_profile_photo_update(client, message)

		elif intent == INTENT_PRIVATE_MESSAGE:
			self.handle_private_binary_message(client, message)

		else:
			logger.warn("got binrary with unregistered intent:", message)

	def handle_profile_photo_update(self, client: QWebSocket, message: JsonBinary):
		# store photo
		my_dummy = self.get_dummy(client)
		my_dummy.photo = message

		# update client profile pic every where
		for dummy in self.clients:
			if not (dummy.client == client):
				self.sendBinaryMessage(dummy.client, message.to_qbytearray())

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
			
	def handle_profile_update_intent(self, client: QWebSocket, message: Json):
		""" whenever a client updates it's profile, this method id called.
		with message containing 'profile' key which holds the updated profile.
		"""
		dummy = self.get_dummy(client)
		profile: dict = message.get('profile')

		if profile.get("username"):
			dummy.username = profile.get("username")

		# now tell everyone asides $client that he updated his profile
		new_message = ClientProfileUpdateWithUidMessage(uid=dummy.uid, profile=message)
		for other_dummy in self.clients:
			if other_dummy != dummy:
				self.sendTextMessage(other_dummy.client, str(new_message))

	# noinspection SpellCheckingInspection
	def get_dummy(self, client: QWebSocket) -> CourierClientDummy:
		"""finds the dummy assoiciated with client"""
		return CourierClientDummy.MAP[client]

	def handle_private_message(self, client: QWebSocket, message: Json):
		""" this function is called when a private text is recieved.
		the text is sent to the client who's dummy has the matching uid. 
		"""
		txt_message: dict = message.get('message', {})

		# # send to receiver
		for recv_dummy in self.clients:
			if recv_dummy.uid  == txt_message.get('recv_uid'):
				self.sendTextMessage(recv_dummy.client, str(message))
				return

	def handle_private_binary_message(self, client: QWebSocket, message: JsonBinary):
		""""""
		bin_message: dict = message.get('message', {})

		for recv_dummy in self.clients:
			if recv_dummy.uid == bin_message.get('recv_uid'):
				self.sendBinaryMessage(recv_dummy.client, message.to_qbytearray())
				return

	@Slot()
	def shutdown(self):
		""" do away with all the connected clients and then stop listening for connections
		"""
		
		for dummy in self.clients:
			dummy.client.close(QWebSocketProtocol.CloseCodeGoingAway, "server shutdown")
		self.clients.clear()
		CourierClientDummy.MAP = dict()
		self.close()

# TODO: onclient disconnect, remove client from clients list
