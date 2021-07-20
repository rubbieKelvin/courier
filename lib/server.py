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

from .messages import Text
from .messages import Binary
from .queue import MessageQueue
from .messages import INTENT_NEW_PEER
from .messages import INTENT_HANDSHAKE
from .messages import INTENT_BROADCAST
from .messages import PrivateTextMessage
from .messages import INTENT_PROFILE_UPDATE
from .messages import INTENT_PRIVATE_MESSAGE
from .messages import INTENT_CONTACT_LIST_REQUEST


class CourierClientDummy:
	"""used to hold all data about the virtual client...
	including client object"""

	def __init__(self, client: QWebSocket) -> None:
		self.client = client
		self.unique_id = str(uuid4())
		self.username: str = "Anonymous"

	def to_dict(self) -> dict:
		return dict(
			username=self.username,
			unique_id=self.unique_id
		)

	def __repr__(self) -> str:
		return f"<ClientD id={self.unique_id} username={self.username}>"


class CourierServer(QWebSocketServer):
	HANDSHAKE_AUTH = "$auth"  # tell the client there's password on this server
	HANDSHAKE_NO_AUTH = "$no-auth"  # tell client there's no password on this server
	HANDSHAKE_SUCCESSFUL = "$successful"  # tell client the handshake was successful
	HANDSHAKE_UNSUCCESSFUL = "$unsuccessful"  # tell client the handshake was unsuccessful

	def __init__(self):
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
		self.queue.add((client, data))

	def sendTextMessage(self, client: QWebSocket, message: str):
		self.queue.add((client, message))

	@Property(bool, notify=runningChanged)
	def running(self) -> bool:
		return self._running and self.isListening()

	@Slot(str)
	def set_password(self, password: str):
		self.password = password

	# noinspection PyTypeChecker
	@Slot(result=bool)
	def run(self) -> bool:
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
		# tell client whose has been here
		if len(self.clients):
			message = Text([c.to_dict() for c in self.clients], intent=INTENT_CONTACT_LIST_REQUEST)
			self.sendTextMessage(client.client, str(message))

		# tell others client joined
		message = Text(client.to_dict(), intent=INTENT_NEW_PEER)
		for dummy in self.clients:
			self.sendTextMessage(dummy.client, str(message))
		
		self.clients.add(client)

	def on_new_connection(self):
		client: QWebSocket = self.nextPendingConnection()

		# if there's a password, tell client to send auth
		if len(self.password) > 0:
			self.sendTextMessage(client, str(Text(CourierServer.HANDSHAKE_AUTH, intent=INTENT_HANDSHAKE)))
		# client will be added to set after providing password
		else:
			# tell client no need to provide password
			client_dummy = CourierClientDummy(client)
			self.sendTextMessage(client, str(Text(
				CourierServer.HANDSHAKE_NO_AUTH,
				intent=INTENT_HANDSHAKE,
				client=client_dummy.to_dict()
			)))
			self.add_client(client_dummy)

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
		client: QWebSocket = self.sender()
		message = Text.fromStr(text)

		if message.intent == INTENT_HANDSHAKE:
			self.handle_handshake_intent(client, message)
		elif message.intent == INTENT_BROADCAST:
			self.handle_broadcast_intent(client, message)
		elif message.intent == INTENT_PROFILE_UPDATE:
			self.handle_profile_update_intent(client, message)
		elif message.intent == INTENT_PRIVATE_MESSAGE:
			self.handle_private_message(client, PrivateTextMessage.fromStr(text))

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

	def handle_handshake_intent(self, client: QWebSocket, message: Text):
		password = message.body
		if password == self.password:
			client_dummy = CourierClientDummy(client)
			self.sendTextMessage(client, str(
				Text(
					CourierServer.HANDSHAKE_SUCCESSFUL,
					intent=INTENT_HANDSHAKE,
					client=client_dummy.to_dict()
				)
			))
			self.add_client(client_dummy)

		# adding this else statement might result in a bug...
		# its been a while since i wrote this code, there must be a reason i removed it before
		# i'm putting it now though.
		else:
			self.sendTextMessage(client, str(Text(CourierServer.HANDSHAKE_UNSUCCESSFUL, intent=INTENT_HANDSHAKE)))

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
