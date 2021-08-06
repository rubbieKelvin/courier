import os
import json
import socket
from uuid import uuid4

from PySide2.QtCore import Qt
from PySide2.QtCore import QUrl
from PySide2.QtCore import Slot
from PySide2.QtGui import QImage
from PySide2.QtCore import Signal
from PySide2.QtCore import QObject
from PySide2.QtQml import QJSValue
from PySide2.QtCore import Property
from PySide2.QtCore import QDateTime 
from PySide2.QtGui import QClipboard
from PySide2.QtCore import QStandardPaths
from PySide2.QtWebSockets import QWebSocketProtocol
# ...
from .paths import Path
from .server import CourierServer
from .client import CourierClient
from .messages import ClientProfilePhotoBinary

from . import logger
from . import username
from .db import Person
from . import getUniqueId

class Helper(QObject):
	def __init__(self,
	#...
	server: CourierServer,
	client: CourierClient,
	dataroot: str=None):

		super(Helper, self).__init__()
		self.server = server
		self.client = client
		self._data = dict()
		self.dataroot = dataroot

		# load data from dataroot
		if self.dataroot:
			# ensure dataroot exists
			if not os.path.exists(self.dataroot):
				Helper.__write(self.dataroot, '{}')

			with open(self.dataroot) as file:
				data = file.read()
				try:
					self._data = json.loads(data)
				except json.JSONDecodeError:
					pass

		# ...
		self._photo = \
			QUrl.fromLocalFile(self.getItemData("profile_photo")).toString() or \
				QUrl("qrc:/uix/assets/images/unknown.svg").toString()

		# whenever server starts running,
		# connect client to server.
		self.server.runningChanged.connect(self.connect_client_to_self)


		# when client request for list of clients gets fufilled, handle data
		# also handle profile changes
		self.client.contactListReceived.connect(self.handle_client_list)
		self.client.newPeerJoined.connect(self.handle_client_data)
		self.client.clientProfileUpdateReceived.connect(self.handle_client_profile_update)
		self.client.peerUpdatedProfilePic.connect(self.save_avatar_to_db)
		self.client.handshakeDone.connect(self.handle_client_handshake)

	usernameChanged = Signal(str)
	profilePhotoChanged = Signal(str)

	@staticmethod
	def __write(filename: str, data: str):
		with open(filename, "w") as file:
			file.write(data)

	# noinspection PyTypeChecker
	@Slot(result=str)
	def hostname(self) -> str:
		""" returns the machine's network name
		"""
		return socket.gethostname()

	# noinspection PyTypeChecker
	@Slot(result=str)
	def ip(self) -> str:
		""" returns the machine's current ip address
		"""
		return socket.gethostbyname(self.hostname())

	def handle_client_handshake(self, status: bool):
		""" this method is called when handshake status is revcieved
		"""
		if status:
			# send profile photo to server
			url = QUrl(self._photo)
			message = ClientProfilePhotoBinary(filename=url, client_uid=getUniqueId())
			self.client.sendBinaryMessage(message.to_qbytearray())

	def connect_client_to_self(self):
		""" connects client to server once the server starts running
		"""
		if self.server._running and self.server.isListening():
			self.client.close(QWebSocketProtocol.CloseCodeGoingAway, "connected with someone else")
			self.client.connect_to(":self", self.server.password)

	@Slot(str, str, result=bool)
	def connectClientToServer(self, hostname: str, password: str) -> bool:
		# if server is running this should'nt work
		if self.server._running:
			return False
		self.client.close(QWebSocketProtocol.CloseCodeGoingAway, "connected with someone else")
		return self.client.connect_to(hostname, password)


	@Slot("QVariant")
	def setItemData(self, kv: QJSValue):
		"""sets key:value pairs to local data"""
		kv = kv if type(kv) is dict else kv.toVariant()
		self._data.update(kv)
		if self.dataroot:
			data = json.dumps(self._data)
			Helper.__write(self.dataroot, data)

	@Slot(str, result="QVariant")
	def getItemData(self, key: str):
		return self._data.get(key)

	@Slot(str)
	def deleteItemData(self, key: str):
		try:
			del self._data[key]
		except KeyError:
			pass

	@Slot()
	def resetItemData(self):
		self._data = dict()
		if self.dataroot:
			Helper.__write(self.dataroot, '{}')

	def _add_or_update_people_db(self, data: dict):
		person = Person()

		if not person.new(uid=data.get('uid'), username=data.get('username'), last_interaction=QDateTime.currentDateTime()):
			if person.query.lastError().text().startswith(f"UNIQUE constraint failed: {person.__tablename__}.uid"):
				# the person already exists.
				# just try to update
				if not person.update(data.get('uid'), username=data.get('username')):
					logger.error(person.query.lastError())

	def handle_client_list(self, data: dict):
		clients: list = data.get('clients', [])

		for client in clients:
			self._add_or_update_people_db(client)
			

	def handle_client_data(self, data: dict):
		client = data.get("client")
		self._add_or_update_people_db(client)

	def handle_client_profile_update(self, data: dict):
		person = Person()
		profile = data.get('profile', {})
		if profile:
			if not person.update(data.get('uid'), **profile):
				logger.error(person.query.lastError())

	def save_avatar_to_db(self, data: dict):
		person = Person()
		if not person.update(data.get('uid'), avatar=data.get('url')):
			logger.error(person.query.lastError())

	@Slot(result="QVariantList")
	def peersList(self) -> list:
		person = Person()
		peers = person.getAll()

		if peers is None:
			logger.debug("Error getting peers: ", person.query.lastError())
			return []

		return peers

	def set_username(self, username_: str):
		username(username_)
		self.client.updateUsernameOnServer(username_)
		self.usernameChanged.emit(username_)

	@Property(str, fset=set_username, notify=usernameChanged)
	def username(self):
		return username()

	@Slot(str)
	def saveTextToClipboard(self, text: str):
		QClipboard().setText(text)

	@staticmethod
	def scale_profile_image(image: QImage) -> QImage:
		# scale image 1:1
		# image size should be 300x300 or min(height, width)
		square = min(300, min(image.height(), image.width()))
		return image.scaled(square, square, Qt.KeepAspectRatioByExpanding)

	def set_photo(self, file: str):
		path = Path()

		# load image
		image = QImage(QUrl(file).toLocalFile())
		image = Helper.scale_profile_image(image)

		# now save image in new file
		new_file = os.path.join(path.PROFILE_PHOTO_ROOT, f"photo-{uuid4().__str__()[:10]}.png")
		image.save(new_file)

		# set and emit
		self.setItemData({"profile_photo": new_file})
		url = QUrl.fromLocalFile(new_file)
		self._photo = url.toString()
		self.profilePhotoChanged.emit(self._photo)

		# share
		message = ClientProfilePhotoBinary(filename=url, client_uid=getUniqueId())
		self.client.sendBinaryMessage(message.to_qbytearray())

	@Property(str, notify=profilePhotoChanged, fset=set_photo)
	def profilephoto(self) -> str:
		return self._photo
