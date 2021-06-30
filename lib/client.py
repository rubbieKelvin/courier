import socket

from . import PORT
from . import logger
from . import is_valid_ip

from PySide2.QtCore import QUrl
from PySide2.QtCore import Slot
from PySide2.QtCore import Signal
from PySide2.QtQml import QJSValue
from PySide2.QtCore import Property
from PySide2.QtCore import QByteArray
from PySide2.QtWebSockets import QWebSocket
from PySide2.QtNetwork import QAbstractSocket

from .messages import Text
from .messages import INTENT_NEW_PEER
from .messages import INTENT_BROADCAST
from .messages import INTENT_HANDSHAKE
from .messages import INTENT_PROFILE_UPDATE
from .messages import INTENT_CONTACT_LIST_REQUEST

from .server import CourierServer


class CourierClient(QWebSocket):
	def __init__(self):
		super(CourierClient, self).__init__()
		self.error.connect(self.on_error)
		self.data_ = dict()
		self.connected.connect(self.on_connected)
		self.textMessageReceived.connect(self.on_text_received)
		self.binaryMessageReceived.connect(self.on_binary_received)

	dataChanged = Signal("QVariant")
	newPeerJoined = Signal("QVariant")
	broadcastReceived = Signal("QVariant")
	handshakeReceived = Signal("QVariant")
	contactListReceived = Signal("QVariant")
	clientProfileUpdateReceived = Signal("QVariant")

	@Property("QVariant", notify=dataChanged)
	def data(self) -> dict:
		return self.data_

	@Slot(str)
	def connect_to(self, hostname: str):
		# hostaname might be a comuter network name or ipv4 address
		if is_valid_ip(hostname):
			target_ip = hostname
		else:
			hostname = socket.gethostname() if (hostname == ":self") else hostname
			target_ip = socket.gethostbyname(hostname)

		url = QUrl(f"ws://{target_ip}:{PORT}")
		self.open(url)

	@Slot(str, result=int)
	def broadcast(self, text: str) -> int:
		return self.sendTextMessage(str(Text(text)))

	@Slot(str)
	def authenticate(self, password: str):
		# sending raw passwords over network is a bad idea
		message = Text(password, intent=INTENT_HANDSHAKE)
		self.sendTextMessage(str(message))

	@Slot("QVariant")
	def update_profile(self, data: QJSValue):
		data: dict = data.toVariant()
		self.data_.update(data)
		self.dataChanged.emit(self.data_)
		self.sendTextMessage(
			str(Text(self.data_, intent=INTENT_PROFILE_UPDATE)))

	def on_connected(self):
		pass

	def on_error(self, error: QAbstractSocket.SocketError):
		logger.error(f"error: {str(error)}")

	def on_text_received(self, text: str):
		logger.log(f"Received: {text}")

		message = Text.fromStr(text)

		if message.intent == INTENT_HANDSHAKE:
			self.handle_handshake_intent(message)
		elif message.intent == INTENT_BROADCAST:
			self.handle_broadcast_intent(message)
		elif message.intent == INTENT_NEW_PEER:
			self.handle_new_peer_intent(message)
		elif message.intent == INTENT_CONTACT_LIST_REQUEST:
			self.handle_contact_list_request(message)
		elif message.intent == INTENT_PROFILE_UPDATE:
			self.handle_client_profile_update(message)

	def on_binary_received(self, data: QByteArray):
		pass

	def handle_handshake_intent(self, message: Text):
		if (message.body == CourierServer.HANDSHAKE_SUCCESSFULL or message.body == CourierServer.HANDSHAKE_NO_AUTH):
			self.data_ = message.meta.get("client")
		self.handshakeReceived.emit(message.toDict())

	def handle_broadcast_intent(self, message: Text):
		self.broadcastReceived.emit(message.toDict())

	def handle_new_peer_intent(self, message: Text):
		self.newPeerJoined.emit(message.toDict())

	def handle_contact_list_request(self, message: Text):
		self.contactListReceived.emit(message.toDict())

	def handle_client_profile_update(self, message: Text):
		self.clientProfileUpdateReceived.emit(message.toDict())
