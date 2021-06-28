import socket

from . import PORT
from . import logger
from . import is_valid_ip

from PySide2.QtCore import QUrl
from PySide2.QtCore import Slot
from PySide2.QtCore import Signal
from PySide2.QtCore import QByteArray
from PySide2.QtWebSockets import QWebSocket
from PySide2.QtNetwork import QAbstractSocket

from .messages import Text
from .messages import INTENT_BROADCAST
from .messages import INTENT_HANDSHAKE
from .messages import INTENT_PROFILE_UPDATE

from .server import CourierServer


class CourierClient(QWebSocket):
	def __init__(self):
		super(CourierClient, self).__init__()
		self.error.connect(self.on_error)
		self.data_ = dict()
		self.connected.connect(self.on_connected)
		self.textMessageReceived.connect(self.on_text_received)
		self.binaryMessageReceived.connect(self.on_binary_received)

	broadcastReceived = Signal("QVariant")
	handshakeReceived = Signal("QVariant")

	@Slot(result="QVariant")
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
		message = Text(password, intent=INTENT_HANDSHAKE) # sending raw passwords over network is a bad idea
		self.sendTextMessage(str(message))

	@Slot(str)
	def update_profile(self, username: str):
		self.sendTextMessage(str(Text(username, intent=INTENT_PROFILE_UPDATE)))

	def on_connected(self):
		pass

	def on_error(self, error: QAbstractSocket.SocketError):
		logger.error(f"error: {str(error)}")

	def on_text_received(self, text: str):
		logger.log(f"recieved: {text}")

		message = Text.fromStr(text)

		if message.intent == INTENT_HANDSHAKE:
			self.handle_handshake_intent(message)
		elif message.intent == INTENT_BROADCAST:
			self.handle_broadcast_intent(message)

	def on_binary_received(self, data: QByteArray):
		pass

	def handle_handshake_intent(self, message: Text):
		if (message.body == CourierServer.HANDSHAKE_SUCCESSFULL):
			self.data_ = message.meta.get("client")
		self.handshakeReceived.emit(message.toDict())

	def handle_broadcast_intent(self, message: Text):
		self.broadcastReceived.emit(message.toDict())

