"""
this module is used to organise packet stucture... text & binary.
all messages sent over the network will be organised as per str(Text|Binary)
"""
import json
from datetime import datetime

INTENT_BROADCAST = 0	# used when messages are meant to be shared
INTENT_HANDSHAKE = 1	# used when client - server are handshaking
INTENT_NEW_PEER  = 2	# used to tell client a user has joined
INTENT_PROFILE_UPDATE = 3 # used by client to update profle on server
INTENT_CONTACT_LIST_REQUEST = 4 # used pass contact list to client

class Text:
	def __init__(self, body:str, intent:int = INTENT_BROADCAST, **meta) -> None:
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

	@staticmethod
	def fromStr(message: str):
		message:dict = json.loads(message)
		t_obj = Text(message.get("body"), message.get("intent"))
		
		del message["body"]
		del message["intent"]
		t_obj.meta = message
		return t_obj