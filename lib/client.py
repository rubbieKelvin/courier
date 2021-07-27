import os
import socket
from uuid import uuid4

from . import PORT
from . import logger
from . import username
from . import is_valid_ip
from . import getUniqueId

from PySide2.QtCore import QUrl
from PySide2.QtCore import Slot
from PySide2.QtCore import QFile
from PySide2.QtCore import Signal
from PySide2.QtCore import QThread
from PySide2.QtQml import QJSValue
from PySide2.QtCore import Property
from PySide2.QtCore import QIODevice
from PySide2.QtCore import QByteArray
from PySide2.QtWebSockets import QWebSocket
from PySide2.QtNetwork import QAbstractSocket
from PySide2.QtWebSockets import QWebSocketProtocol

from .messages import Text
from .messages import Binary
from .messages import PrivateTextMessage

from .messages import INTENT_HANDSHAKE
from .messages import INTENT_PROFILE_UPDATE

from .queue import MessageQueue

from .messages import Json
from .messages import ClientHandShakeMessage


class FileTransferWorker(QThread):
	def __init__(self, client: QWebSocket, file_url: QUrl, message: str, receiver_uid: str):
		super(FileTransferWorker, self).__init__()
		self.file_url = file_url
		self.client = client
		self.message = message
		self.extension = os.path.splitext(file_url.toLocalFile())[-1]
		self.receiver_uid = receiver_uid
		self.finished.connect(lambda: logger.log(f"finished thread handling {self.file_url}"))

	payloadHandled = Signal(Binary)

	def run(self):
		local_file = self.file_url.toLocalFile()
		file = QFile(local_file)

		if not (file.exists() and file.open(QIODevice.ReadOnly)):
			# noinspection PyUnresolvedReferences
			return

		byte_array = file.readAll()

		binary: Binary = Binary(
			id_=uuid4(),
			message=self.message,
			receiver_uid=self.receiver_uid,
			binary=byte_array,
			extension=self.extension)

		# noinspection PyUnresolvedReferences
		self.payloadHandled.emit(binary)


class CourierClient(QWebSocket):
	def __init__(self):
		"""
		HOW IT WORKS:
		1. after connecting to a network...
		2. send details containing:
			- uid: str
			- username: str
			- password: str
		4. wait for success message
		5. if successfull, we're in.
		"""

		super(CourierClient, self).__init__()
		self.data_ = dict()
		self.queue = MessageQueue("client")

		self.error.connect(self.on_error)
		self.queue.currentItemUpdated.connect(self.handleQueue)
		self.textMessageReceived.connect(self.on_text_received)
		self.binaryMessageReceived.connect(self.on_binary_received)
		self.connected.connect(self.on_connected)
		self.disconnected.connect(self.on_disconnected)
		self._running = False
		self._handshake_successful = False
		self.password = ""

	binarySent = Signal("QVariant")
	dataChanged = Signal("QVariant")
	newPeerJoined = Signal("QVariant")
	runningChanged = Signal(bool)
	binaryReceived = Signal("QVariant")
	broadcastReceived = Signal("QVariant")
	handshakeReceived = Signal("QVariant")
	privateMessageSent = Signal("QVariant")
	contactListReceived = Signal("QVariant")
	privateMessageReceived = Signal("QVariant")
	clientProfileUpdateReceived = Signal("QVariant")
	handshakeDone = Signal(bool)

	def handleQueue(self):
		"""
		this function is triggered when ever the 0th item in self.queue is changed.
		"""
		current = self.queue.current

		if not (current is None):
			if type(current) is str:
				super(CourierClient, self).sendTextMessage(current)
			elif type(current) is QByteArray:
				super(CourierClient, self).sendBinaryMessage(current)
			else:
				raise TypeError
			self.queue.reverse_pop()

	def sendTextMessage(self, message: str) -> int:
		self.queue.add(message)
		# the signals in the message queue will handle message transport
		return 0

	def sendBinaryMessage(self, data: QByteArray) -> int:
		self.queue.add(data)
		return 0

	# noinspection PyTypeChecker
	@Property("QVariant", notify=dataChanged)
	def data(self) -> dict:
		return self.data_

	# noinspection PyTypeChecker
	@Slot(str, str, result=bool)
	def connect_to(self, hostname: str, password: str) -> bool:
		"""
		connects to the given host... no protocol or port.
		* use :self to connect to a server create on this machine.
		"""
		self.password = password
		# hostname might be a computer network name or ipv4 address
		if is_valid_ip(hostname):
			target_ip = hostname
		else:
			hostname = socket.gethostname() if (hostname == ":self") else hostname
			try:
				target_ip = socket.gethostbyname(hostname)
			except socket.gaierror:
				return False

		url = QUrl(f"ws://{target_ip}:{PORT}")
		self.open(url)
		return True

	# noinspection PyTypeChecker
	@Slot(str, result=int)
	def broadcast(self, text: str) -> int:
		return self.sendTextMessage(str(Text(text)))

	@Slot(str, str)
	def sendPrivateMessage(self, text: str, to: str):
		message = PrivateTextMessage(uuid4(), text, to)
		# message will be signed at the server
		self.sendTextMessage(str(message))
		# noinspection PyUnresolvedReferences
		self.privateMessageSent.emit(message.toDict())

	@Slot(str, str, str)
	def sendFile(self, message: str, file_url: str, to: str):
		file_sender = FileTransferWorker(self, file_url=QUrl(file_url), message=message, receiver_uid=to)

		def do_del():
			logger.debug("deleting", file_sender)
			file_sender.deleteLater()

		file_sender.finished.connect(do_del)
		# noinspection PyUnresolvedReferences
		file_sender.payloadHandled.connect(self.binary_payload_handled)
		file_sender.start()

	# noinspection PyMethodMayBeStatic
	def binary_payload_handled(self, binary: Binary):
		byte_array = binary.toQByteArray()
		self.sendBinaryMessage(byte_array)
		# call a binary sent signal here
		# noinspection PyUnresolvedReferences
		self.binarySent.emit(binary.toDict())

	@Slot(str)
	def authenticate(self, password: str):
		# sending raw passwords over network is a bad idea
		message = Text(password, intent=INTENT_HANDSHAKE)
		self.sendTextMessage(str(message))

	# noinspection PyTypeChecker
	@Slot("QVariant")
	def update_profile(self, data: QJSValue):
		data: dict = data.toVariant()
		self.data_.update(data)
		# noinspection PyUnresolvedReferences
		self.dataChanged.emit(self.data_)
		self.sendTextMessage(
			str(Text(self.data_, intent=INTENT_PROFILE_UPDATE)))

	# noinspection PyMethodMayBeStatic
	def on_error(self, error: QAbstractSocket.SocketError):
		logger.error(f"error: {str(error)}")

	def on_text_received(self, text: str):
		""" this method will be called once a text is recieved from the server.
		"""
		message: Json = Json.from_str(text)

		if message.get('intent') == INTENT_HANDSHAKE:
			self.handle_handshake_intent(message)

		else:
			logger.warn("got message with unregistered intent:", message)
		# elif message.intent == INTENT_BROADCAST:
		# 	self.handle_broadcast_intent(message)
		# elif message.intent == INTENT_NEW_PEER:
		# 	self.handle_new_peer_intent(message)
		# elif message.intent == INTENT_CONTACT_LIST_REQUEST:
		# 	self.handle_contact_list_request(message)
		# elif message.intent == INTENT_PROFILE_UPDATE:
		# 	self.handle_client_profile_update(message)
		# elif message.intent == INTENT_PRIVATE_MESSAGE:
		# 	self.handle_pm_intent(PrivateTextMessage.fromStr(text))

	# noinspection PyMethodMayBeStatic
	def on_binary_received(self, data: QByteArray):
		logger.log("received binaries!")
		binary: Binary = Binary.fromQByteArray(data)

		# this will save the binary as file and feed the file path instead
		binary_dict: dict = binary.toDict()

		# noinspection PyUnresolvedReferences
		self.binaryReceived.emit(binary_dict)

	def handle_handshake_intent(self, message: Json):
		# we'll get a successful=true message if authentication is successful.
		
		self.handshakeReceived.emit(message.to_dict())
		if message.get('successful'):
			self._running = True
			self._handshake_successful = True
			self.runningChanged.emit(self._running)
		else:
			self._handshake_successful = False
			self.close(QWebSocketProtocol.CloseCodePolicyViolated, "handshake unsuccessfull")
		self.handshakeDone.emit(self._handshake_successful)

	def handle_broadcast_intent(self, message: Text):
		# noinspection PyUnresolvedReferences
		self.broadcastReceived.emit(message.toDict())

	def handle_new_peer_intent(self, message: Text):
		""" this function is called when a new client connected to
		...the same server this one is connected to.

		.ex: {
			"body": {
				"username": ~str,
				"unique_id": ~uuid
			},
			"intent": 2,
			"datetime": ~datetime
		}
		"""
		# noinspection PyUnresolvedReferences
		self.newPeerJoined.emit(message.toDict())

	def handle_contact_list_request(self, message: Text):
		# noinspection PyUnresolvedReferences
		self.contactListReceived.emit(message.toDict())

	def handle_client_profile_update(self, message: Text):
		# noinspection PyUnresolvedReferences
		self.clientProfileUpdateReceived.emit(message.toDict())

	def handle_pm_intent(self, message: PrivateTextMessage):
		if not message.signer:
			logger.warn(
				"there's a problem with the received message.",
				"message has not been signed"
			)
		# noinspection PyUnresolvedReferences
		self.privateMessageReceived.emit(message.toDict())

	def on_connected(self):
		""" send auth details. after auth details are sent,
		a text will be recieved from the server with a intent=INTENT_HANDSHAKE (which we'l have to listen for)
		the text will be structured as laid out in messages.AuthStatusMessage,
		which will contain data, that tells if authentication was successful.
		"""
		message = ClientHandShakeMessage(
			uid=getUniqueId(),
			username=username(),
			password=self.password
		)

		self.sendTextMessage(str(message))

	def on_disconnected(self):
		""" client has been disconnected
		"""
		self._running = False
		self._handshake_successful = False
		self.runningChanged.emit(self._running)

	@Property(bool, notify=runningChanged)
	def running(self) -> bool:
		return self._running

	@Property(bool, notify=handshakeDone)
	def handshake_successful(self) -> bool:
		return self._handshake_successful
