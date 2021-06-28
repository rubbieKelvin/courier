"""
this module is used to organise packet stucture... text & binary.
all messages sent over the network will be organised as per str(Text|Binary)
"""
import json
from datetime import datetime
from PySide2.QtCore import QObject, Slot

INTENT_BROADCAST = 0	# used when messages are meant to be shared
INTENT_HANDSHAKE = 1	# used when client - server are handshaking
INTENT_PROFILE_UPDATE = 2 # used byt client to update profle on server

class Text(QObject):
	def __init__(self, body:str, intent:int = INTENT_BROADCAST, **meta) -> None:
		super(Text, self).__init__()
		self.body = body
		self.intent = intent
		self.meta = meta

	def __str__(self) -> str:
		data = dict(
			body=self.body,
			intent=self.intent,
			datetime=str(datetime.now())
		)

		data.update(self.meta)
		return json.dumps(data)

	@staticmethod
	@Slot(str)
	def fromStr(message: str):
		message:dict = json.loads(message)
		t_obj = Text(message.get("body"), message.get("intent"))
		
		del message["body"]
		del message["intent"]
		t_obj.meta = message
		return t_obj