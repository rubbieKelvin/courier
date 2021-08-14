"""
this module is used to organise packet structure... text & binary.
all messages sent over the network will be organised as per str(Text|Binary)
"""
import os
import json
import uuid

from .paths import Path

from base64 import b85encode
from base64 import b85decode

from PySide2.QtCore import QUrl
from PySide2.QtCore import QFile
from PySide2.QtQml import QJSValue
from PySide2.QtCore import QDateTime
from PySide2.QtCore import QIODevice
from PySide2.QtCore import QByteArray
from PySide2.QtCore import QCryptographicHash


INTENT_HANDSHAKE = 1    # used when client - server are handshaking
INTENT_NEW_PEER = 2    # used to tell client a user has joined
INTENT_PROFILE_UPDATE = 3   # used by client to update profile on server & and by server to broadcast profile update
INTENT_CONTACT_LIST_REQUEST = 4     # used pass contact list to client
INTENT_PRIVATE_MESSAGE = 5          # used to send private messages between two clients
INTENT_PROFILE_PHOTO_UPDATE = 6 	# used in binary messages to update profile photo across network

MESSAGE_TYPE_TEXT = 0
MESSAGE_TYPE_STICKER = 1
MESSAGE_TYPE_VOICE_NOTE = 2
MESSAGE_TYPE_BINARY_FILE = 3


class Json:
	def __init__(self, **kwargs) -> None:
		self.data = kwargs
		self.data.setdefault('message_uid', uuid.uuid4().__str__())

		for key, value in self.data.items():
			self.__setattr__(f"_{key}", value)

	def __str__(self) -> str:
		return json.dumps(self.data)

	def __repr__(self) -> str:
		return f"<Json {', '.join(self.data.keys())}>"

	def to_dict(self) -> dict:
		return self.data

	def get(self, key: str, default=None):
		return self.data.get(key, default)

	@staticmethod
	def from_str(string: str):
		return Json(**json.loads(string))

	# noinspection SpellCheckingInspection
	@staticmethod
	def from_qvariant(variant: QJSValue):
		data = variant.toVariant()
		if type(data) is dict:
			return Json(**data)
		return Json(data=data)

	def copy(self):
		j = Json()
		j.data = self.data.copy()
		return j


class JsonBinary(Json):
	# noinspection PyMissingConstructor
	def __init__(self, payload: QByteArray, **kwargs) -> None:
		self._payload = payload
		self.data = kwargs
		self.root = Path().FILES_OTHER_ROOT
		self.data.setdefault('message_uid', uuid.uuid4().__str__())
		self.filename = self.data['message_uid']

		for key, value in self.data.items():
			self.__setattr__(f"_{key}", value)

		self.data['payload'] = b85encode(payload).decode()

	# noinspection SpellCheckingInspection
	def to_qbytearray(self) -> QByteArray:
		data = json.dumps(self.data).encode()
		return QByteArray(data)

	def __repr__(self) -> str:
		return f"<JsonBinary {self.__hash__()}>"

	def __str__(self) -> str:
		return f"<JsonBinary ({self.data.get('payload', '').__len__()})>"

	@property
	def payload_resolved(self):
		""" If payload has been saved to a file,
		the payload will be removed from dictionary. and a key filename" wil be added. 
		"""
		return not ("payload" in self.data)

	def to_dict(self) -> dict:
		d = self.data.copy()
		d['payload'] = self.save_to_file()
		return d

	def save_to_file(self) -> str:
		filepath = os.path.join(self.root, self.filename)
		file = QFile(filepath)

		if not file.exists():
			if not file.open(QIODevice.WriteOnly):
				# noinspection PyTypeChecker
				return None
			file.write(self._payload)

		return QUrl.fromLocalFile(filepath).toString()

	@staticmethod
	def from_str(string: str):
		"""this method is not implemented"""
		raise NotImplementedError

	# noinspection SpellCheckingInspection
	@staticmethod
	def from_qvariant(variant: QJSValue):
		"""this method is not implemented"""
		raise NotImplementedError

	@staticmethod
	def open_file(filename: QUrl) -> QByteArray:
		if not filename.isLocalFile():
			raise FileNotFoundError

		filename = filename.toLocalFile()

		file = QFile(filename)
		if not (file.exists() and file.open(QIODevice.ReadOnly)):
			raise FileNotFoundError(f'File "{filename}" does not exist')

		return file.readAll()

	# noinspection SpellCheckingInspection
	@staticmethod
	def from_qbytearray(qbytearray: QByteArray):
		# deconstruct
		data: dict = json.loads(bytes(qbytearray).decode())

		payload: str = data['payload']
		payload: bytes = payload.encode()
		# noinspection PyTypeChecker
		payload = b85decode(payload)
		# noinspection PyTypeChecker
		payload: QByteArray = QByteArray(payload)

		del data['payload']
		return JsonBinary(payload, **data)

	def copy(self):
		d = self.data.copy()
		del d['payload']
		return JsonBinary(QByteArray(self._payload), **d)


#####################################################################################


class ClientHandShakeMessage(Json):
	def __init__(self, uid: str, username: str, password: str):
		""" this class if used to structure data that is sent when client
		is sending authentication and self details to server.
		"""
		super().__init__(uid=uid, username=username, password=password, intent=INTENT_HANDSHAKE)


class AuthStatusMessage(Json):
	def __init__(self, successful: bool):
		""" this message is sent to client.
		used to tell client if authentication was successful
		"""
		super().__init__(successful=successful, intent=INTENT_HANDSHAKE)


class ConnectedClientsMessage(Json):
	def __init__(self, clients: list):
		""" this is sent to client with data
		containing list of connected clients and their details
		"""
		super().__init__(clients=clients, intent=INTENT_CONTACT_LIST_REQUEST)


class ClientDataMessage(Json):
	def __init__(self, client: dict) -> None:
		"""
		used to send client data to other clients
		"""
		super().__init__(client=client, intent=INTENT_NEW_PEER)


class ClientProfileUpdateMessage(Json):
	def __init__(self, username: str = None) -> None:
		""" Client uses this to send data to server about profile changes.
		the server will share it to other users, who will now update it on their database
		"""
		profile = dict()

		if username:
			profile['username'] = username

		super().__init__(profile=profile, intent=INTENT_PROFILE_UPDATE)


class ClientProfileUpdateWithUidMessage(Json):
	def __init__(self, uid: str, profile: Json) -> None:
		""" The server uses this to broadcast to other clients, the updated client's profile.
		adding a 'uid' key to the ClientProfileUpdateMessage.
		"""
		profile = profile.copy()
		profile.data['uid'] = uid
		super().__init__(**profile.to_dict())


class ClientPrivateTextMessage(Json):
	# noinspection PyShadowingBuiltins
	def __init__(self, text: str, recv_uid: str, sender_uid: str, type: int) -> None:
		super().__init__(
			intent=INTENT_PRIVATE_MESSAGE,
			message=dict(
				text=text,
				recv_uid=recv_uid,
				sender_uid=sender_uid,
				type=type,
				timestamp=QDateTime.currentDateTime().toString()
			))


# noinspection PyAbstractClass
class ClientProfilePhotoBinary(JsonBinary):
	def __init__(self, filename: QUrl, client_uid: str) -> None:
		extension = os.path.splitext(filename.toLocalFile())[-1]
		super().__init__(
			self.open_file(filename),
			client_uid=client_uid,
			extension=extension,
			intent=INTENT_PROFILE_PHOTO_UPDATE)


# noinspection PyAbstractClass
class PrivateVoiceNoteMessage(JsonBinary):
	def __init__(self, filename: QUrl, recv_uid: str, sender_uid: str) -> None:
		super().__init__(
			self.open_file(filename),
			intent=INTENT_PRIVATE_MESSAGE,
			message=dict(
				filename="", 	# this will be determined on the receiver's machine
				recv_uid=recv_uid,
				sender_uid=sender_uid,
				type=MESSAGE_TYPE_VOICE_NOTE,
				timestamp=QDateTime.currentDateTime().toString()
			)
		)
		self.root = Path().MY_VOICENOTE_ROOT

	def to_dict(self) -> dict:
		d = super().to_dict()
		d['message']['filename'] = d['payload']
		return d


# noinspection PyAbstractClass
class PrivateMessageFile(JsonBinary):
	def __init__(self, filename: QUrl, recv_uid: str, sender_uid: str) -> None:
		name = os.path.split(filename.toLocalFile())[-1]
		payload = self.open_file(filename)

		# noinspection SpellCheckingInspection
		filehash = bytes(
			QCryptographicHash.hash(
				payload,
				QCryptographicHash.Sha256
			).toBase64()
		).decode()

		super().__init__(
			payload,
			intent=INTENT_PRIVATE_MESSAGE,
			message=dict(
				filehash=filehash, 	# the hash of the payload
				filename="", 	# this will be determined on the receiver's machine as the path to where the file is stored
				name=name,		# the original file name (not path)
				recv_uid=recv_uid,
				sender_uid=sender_uid,
				type=MESSAGE_TYPE_BINARY_FILE,
				timestamp=QDateTime.currentDateTime().toString()
			)
		)

		self.root = Path().SENT_ROOT
		self.filename = name

	def to_dict(self) -> dict:
		d = super().to_dict()
		d['message']['filename'] = d['payload']
		return d
