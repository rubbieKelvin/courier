"""
this module is used to organise packet structure... text & binary.
all messages sent over the network will be organised as per str(Text|Binary)
"""
import os
import json
import uuid
from typing import Any
from datetime import datetime
from PySide2.QtCore import QUrl
from PySide2.QtCore import QDir
from PySide2.QtCore import QFile
from PySide2.QtCore import QIODevice
from PySide2.QtCore import QByteArray
from PySide2.QtCore import QStandardPaths
from PySide2.QtCore import QCryptographicHash


INTENT_BROADCAST = 0    # used when messages are meant to be shared
INTENT_HANDSHAKE = 1    # used when client - server are handshaking
INTENT_NEW_PEER = 2    # used to tell client a user has joined
INTENT_PROFILE_UPDATE = 3   # used by client to update profile on server & and by server to broadcast profile update
INTENT_CONTACT_LIST_REQUEST = 4     # used pass contact list to client
INTENT_PRIVATE_MESSAGE = 5          # used to send private messages between two clients


class Text:
	def __init__(self, body: Any, intent: int = INTENT_BROADCAST, **meta):
		self.body = body
		self.intent = intent
		self.meta = meta

	def toDict(self) -> dict:
		data = dict(
			body=self.body,
			intent=self.intent,
			datetime=str(datetime.now())
		)

		data.update(self.meta)
		return data

	def __str__(self) -> str:
		return json.dumps(self.toDict())

	def __repr__(self) -> str:
		return f"<Message body={self.body} intent={self.intent}>"

	@staticmethod
	def fromStr(message: str):
		message: dict = json.loads(message)
		t_obj = Text(message.get("body"), message.get("intent"))
		
		del message["body"]
		del message["intent"]
		t_obj.meta = message
		return t_obj


class PrivateTextMessage(Text):
	def __init__(self, id_: uuid.UUID, message: str, receiver_uid: str):
		super(PrivateTextMessage, self).__init__(
			dict(
				message_id=str(id_) or str(uuid.uuid4()),
				text=message,
				receiver_uid=receiver_uid),
			intent=INTENT_PRIVATE_MESSAGE
		)
		self.body: dict

	def sign(self, sender_uid: str):
		"""tag the message with the sender's uid"""
		if not self.body.get("sender_uid"):
			self.body["sender_uid"] = sender_uid

	@property
	def signer(self) -> str:
		# returns the signer. none if not signed
		return self.body.get("sender_uid")

	@staticmethod
	def fromStr(message: str):
		message: dict = json.loads(message)
		t_obj = PrivateTextMessage(
			message.get("body").get("message_id"),
			message.get("body").get("text"),
			message.get("body").get("receiver_uid"))

		t_obj.body["sender_uid"] = message.get("body").get("sender_uid")
		
		del message["body"]
		del message["intent"]

		t_obj.meta = message
		return t_obj


class Binary(PrivateTextMessage):
	"""docstring for Binary"""
	root = QStandardPaths.writableLocation(QStandardPaths.AppDataLocation)
	root = os.path.join(root, "Courier")

	if not QDir(root).exists():
		os.mkdir(root)

	def __init__(self, id_: uuid.UUID, message: str, receiver_uid: str, binary: QByteArray, extension: str):
		super(Binary, self).__init__(id_, message, receiver_uid)
		self.binary = binary
		self.body["extension"] = extension

	@staticmethod
	def qByteArrayToBase64Str(byte_array: QByteArray) -> str:
		return bytearray(byte_array.toBase64()).decode("utf8")

	@staticmethod
	def base64StrToQByteArray(b64: str) -> QByteArray:
		b64: bytes = bytes(b64, "utf8")
		result = QByteArray(b64)
		return QByteArray.fromBase64(result)

	def toQByteArray(self) -> QByteArray:
		binary = Binary.qByteArrayToBase64Str(self.binary)

		self.body["binary"] = binary
		self.body["hash"] = QCryptographicHash.hash(self.binary, QCryptographicHash.Sha256)
		self.body["hash"] = Binary.qByteArrayToBase64Str(self.body["hash"])

		data = dict(
			body=self.body,
			intent=self.intent,
			datetime=str(datetime.now())
		)

		data.update(self.meta)

		byte_array = json.dumps(data)
		return QByteArray(bytes(byte_array, "utf8"))

	@staticmethod
	def fromQByteArray(byte_array: QByteArray):
		data: str = bytearray(byte_array).decode("utf8")
		data: dict = json.loads(data)
		body: dict = data.get("body")

		binary = Binary.base64StrToQByteArray(body.get("binary"))
		hash_ = Binary.base64StrToQByteArray(body.get("hash"))

		binary_message = Binary(
			id_=body.get("message_id"),
			message=body.get("text"),
			receiver_uid=body.get("receiver_uid"),
			binary=binary,
			extension=body.get("extension")
		)

		binary_message.body["hash"] = hash_
		binary_message.meta["hash_verified"] = hash_ == QCryptographicHash.hash(binary, QCryptographicHash.Sha256)

		del data["body"]
		del data["intent"]

		binary_message.meta.update(data)
		return binary_message

	def fromStr(self):
		"""
		this method doesnt work here
		"""
		raise NotImplementedError

	def toDict(self) -> dict:
		result = super().toDict()
		del result["body"]["hash"]

		# save binary to file
		filename = result["body"]["message_id"]+result["body"]["extension"]
		filename = os.path.join(Binary.root, filename)
		file = QFile(filename)

		if not file.exists():
			if file.open(QIODevice.WriteOnly):
				file.write(self.binary)
				result['fileurl'] = QUrl.fromLocalFile(filename).toString()
			else:
				result["fileurl"] = ""
		else:
			result['fileurl'] = QUrl.fromLocalFile(filename).toString()

		return result