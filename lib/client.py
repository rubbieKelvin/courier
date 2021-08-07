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

from .messages import INTENT_NEW_PEER
from .messages import INTENT_HANDSHAKE
from .messages import INTENT_PROFILE_UPDATE
from .messages import INTENT_PRIVATE_MESSAGE
from .messages import INTENT_CONTACT_LIST_REQUEST
from .messages import INTENT_PROFILE_PHOTO_UPDATE

from .paths import Path
from .queue import MessageQueue

from .messages import Json
from .messages import JsonBinary
from .messages import ClientHandShakeMessage
from .messages import ClientPrivateTextMessage
from .messages import ClientProfileUpdateMessage


# class FileTransferWorker(QThread):
# 	def __init__(self, client: QWebSocket, file_url: QUrl, message: str, receiver_uid: str):
# 		super(FileTransferWorker, self).__init__()
# 		self.file_url = file_url
# 		self.client = client
# 		self.message = message
# 		self.extension = os.path.splitext(file_url.toLocalFile())[-1]
# 		self.receiver_uid = receiver_uid
# 		self.finished.connect(lambda: logger.log(f"finished thread handling {self.file_url}"))

# 	payloadHandled = Signal(Binary)

# 	def run(self):
# 		local_file = self.file_url.toLocalFile()
# 		file = QFile(local_file)

# 		if not (file.exists() and file.open(QIODevice.ReadOnly)):
# 			# noinspection PyUnresolvedReferences
# 			return

# 		byte_array = file.readAll()

# 		binary: Binary = Binary(
# 			id_=uuid4(),
# 			message=self.message,
# 			receiver_uid=self.receiver_uid,
# 			binary=byte_array,
# 			extension=self.extension)

# 		# noinspection PyUnresolvedReferences
# 		self.payloadHandled.emit(binary)


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
	peerUpdatedProfilePic = Signal("QVariant")

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

	@Slot(str, str)
	@Slot(str, str, bool)
	def sendPrivateMessage(self, text: str, recv_uid: str, sticker: bool=False):
		""" send a text message `text` to a client with uid==`recv_uid`.
		the server will recieve the message and send to the client who the message is assigned to.
		"""
		message = ClientPrivateTextMessage(
			text=text,
			recv_uid=recv_uid,
			sender_uid=getUniqueId(),
			msg_type=ClientPrivateTextMessage.STICKER_MESSAGE if sticker else ClientPrivateTextMessage.TEXT_MESSAGE
		)
		self.sendTextMessage(str(message))

		# # noinspection PyUnresolvedReferences
		self.privateMessageSent.emit(message.to_dict())

	@Slot(str, str, str)
	def sendFile(self, message: str, file_url: str, to: str):
		# file_sender = FileTransferWorker(self, file_url=QUrl(file_url), message=message, receiver_uid=to)

		# def do_del():
		# 	logger.debug("deleting", file_sender)
		# 	file_sender.deleteLater()

		# file_sender.finished.connect(do_del)
		# # noinspection PyUnresolvedReferences
		# file_sender.payloadHandled.connect(self.binary_payload_handled)
		# file_sender.start()
		pass

	# noinspection PyMethodMayBeStatic
	# def binary_payload_handled(self, binary: Binary):
	# 	byte_array = binary.toQByteArray()
	# 	self.sendBinaryMessage(byte_array)
	# 	# call a binary sent signal here
	# 	# noinspection PyUnresolvedReferences
	# 	self.binarySent.emit(binary.toDict())

	# noinspection PyTypeChecker
	# @Slot("QVariant")
	# def update_profile(self, data: QJSValue):
	# 	data: dict = data.toVariant()
	# 	self.data_.update(data)
	# 	# noinspection PyUnresolvedReferences
	# 	self.dataChanged.emit(self.data_)
	# 	self.sendTextMessage(
	# 		str(Text(self.data_, intent=INTENT_PROFILE_UPDATE)))

	# noinspection PyMethodMayBeStatic
	def on_error(self, error: QAbstractSocket.SocketError):
		logger.error(f"error: {str(error)}")

	def on_text_received(self, text: str):
		""" this method will be called once a text is recieved from the server.
		"""
		message: Json = Json.from_str(text)
		intent: str = message.get('intent')

		if intent == INTENT_HANDSHAKE:
			self.handle_handshake(message)

		elif intent == INTENT_CONTACT_LIST_REQUEST:
			self.handle_contact_list_request(message)

		elif intent == INTENT_NEW_PEER:
			self.handle_new_peer_intent(message)

		elif intent == INTENT_PROFILE_UPDATE:
			self.handle_client_profile_update(message)

		elif intent == INTENT_PRIVATE_MESSAGE:
			self.handle_pm_intent(message)

		else:
			logger.warn("got message with unregistered intent:", message)

	# noinspection PyMethodMayBeStatic
	def on_binary_received(self, data: QByteArray):
		message = JsonBinary.from_qbytearray(data)
		intent: str = message.get('intent')

		if intent == INTENT_PROFILE_PHOTO_UPDATE:
			self.handle_profile_pic_update(message)
		
		else:
			logger.warn("recvd binary with unregistered intent:", message)

	def handle_profile_pic_update(self, message: JsonBinary):
		"""this is a client's profile pic.
		save the binary to file, and then send a signal with the file name
		"""
		path = Path()
		payload = message._payload
		filename = uuid4().__str__()[:10]+message.get('extension', '.img')
		filepath = os.path.join(path.PROFILE_PHOTO_ROOT, filename)

		file = QFile(filepath)
		if file.open(QIODevice.WriteOnly):
			file.write(payload)

			url = QUrl.fromLocalFile(filepath)
			self.peerUpdatedProfilePic.emit({
				'uid': message.get('client_uid'),
				'url': url.toString()
			})

	def handle_handshake(self, message: Json):
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

	def handle_broadcast_intent(self, message: Json):
		# noinspection PyUnresolvedReferences
		self.broadcastReceived.emit(message.to_dict())

	def handle_new_peer_intent(self, message: Json):
		""" this function is called when a new client connected to
		...the same server this one is connected to.
		"""
		# noinspection PyUnresolvedReferences
		self.newPeerJoined.emit(message.to_dict())

	def handle_contact_list_request(self, message: Json):
		""" message contains (should contain) key 'clients',
		which is a list of all the connected clients.
		"""
		# noinspection PyUnresolvedReferences
		self.contactListReceived.emit(message.to_dict())

	def handle_client_profile_update(self, message: Json):
		# noinspection PyUnresolvedReferences
		""" this method is called when another client updates its profile.
		this data should be handled in some helper class, or in qml file.
		"""
		self.clientProfileUpdateReceived.emit(message.to_dict())

	def handle_pm_intent(self, message: Json):
		""" this method is called when the client get the message
		written to it from another client.
		"""
		self.privateMessageReceived.emit(message.to_dict())

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
		logger.log("client disconnected")
		self._running = False
		self._handshake_successful = False
		self.runningChanged.emit(self._running)

	@Property(bool, notify=runningChanged)
	def running(self) -> bool:
		return self._running

	@Property(bool, notify=handshakeDone)
	def handshake_successful(self) -> bool:
		return self._handshake_successful

	@Slot(str)
	def updateUsernameOnServer(self, username: str):
		message = ClientProfileUpdateMessage(username=username)
		logger.debug("updating username on server")
		self.sendTextMessage(message.__str__())
