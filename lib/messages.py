"""
this module is used to organise packet stucture... text & binary.
all messages sent over the network will be organised as per str(Text|Binary)
"""
import json
import uuid
from datetime import datetime

INTENT_BROADCAST = 0	# used when messages are meant to be shared
INTENT_HANDSHAKE = 1	# used when client - server are handshaking
INTENT_NEW_PEER  = 2	# used to tell client a user has joined
INTENT_PROFILE_UPDATE = 3 # used by client to update profle on server & and by server to braodcast profile update
INTENT_CONTACT_LIST_REQUEST = 4 # used pass contact list to client
INTENT_PRIVATE_MESSAGE = 5 # used to send private meassges between two clients

class Text:
	def __init__(self, body:str, intent:int = INTENT_BROADCAST, **meta):
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
		message:dict = json.loads(message)
		t_obj = Text(message.get("body"), message.get("intent"))
		
		del message["body"]
		del message["intent"]
		t_obj.meta = message
		return t_obj

class PrivateTextMessage(Text):
	def __init__(self, id:uuid.UUID, message:str, receiver_uid:str):
		super(PrivateTextMessage, self).__init__(
			dict(
				message_id=str(id) or str(uuid.uuid4()),
				text=message,
				receiver_uid=receiver_uid),
			intent=INTENT_PRIVATE_MESSAGE
		)
		self.body: dict

	def sign(self, sender_uid:str):
		"""tag the message with the sender's uid"""
		if not self.body.get("sender_uid"):
			self.body["sender_uid"] = sender_uid

	@property
	def signer(self) -> str:
		# returns the signer. none if not signed
		return self.body.get("sender_uid")

	@staticmethod
	def fromStr(message: str):
		message:dict = json.loads(message)
		t_obj = PrivateTextMessage(
			message.get("body").get("message_id"),
			message.get("body").get("text"),
			message.get("body").get("receiver_uid"))

		t_obj.body["sender_uid"] = message.get("body").get("sender_uid")
		
		del message["body"]
		del message["intent"]

		t_obj.meta = message
		return t_obj
