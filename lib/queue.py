from typing import List
from typing import Union
from .messages import Text
from .messages import Binary
from PySide2.QtCore import Signal
from PySide2.QtCore import QObject
from .messages import PrivateTextMessage


class MessageQueue(QObject):
	"""
	This is just a container to keep messages in a queue,
	ensuring messages goes one after the other
	"""
	def __init__(self):
		super(MessageQueue, self).__init__()
		self.stack: List[Union[Text, PrivateTextMessage, Binary]] = []

	itemReady = Signal(Union[Text, PrivateTextMessage, Binary])

	def push(self, item: Union[Text, PrivateTextMessage, Binary]):
		self.stack.append(item)

	def pop(self, item):
		item = self.stack.pop(0)
		# noinspection PyUnresolvedReferences
		self.itemReady.emit(item)
