from . import logger
from typing import List
from typing import Union
from typing import Tuple
from PySide2.QtCore import Signal
from PySide2.QtCore import QTimer
from PySide2.QtCore import QObject
from PySide2.QtCore import QByteArray
from PySide2.QtWebSockets import QWebSocket


class MessageQueue(QObject):
	"""
	This is just a container to keep messages in a queue,
	ensuring messages goes one after the other
	"""
	def __init__(self, /, name: str = ""):
		super(MessageQueue, self).__init__()
		self.current = None
		self.name = name
		self.list: List[Union[str, QByteArray, Tuple[QWebSocket, Union[str, QByteArray]]]] = []

	itemAdded = Signal()
	currentItemUpdated = Signal()

	def setCurrent(self):
		self.current = self.list[0] if len(self) else None
		# noinspection PyUnresolvedReferences
		self.currentItemUpdated.emit()

	def add(self, /, item: Union[str, QByteArray, Tuple[QWebSocket, Union[str, QByteArray]]]):
		self.list.append(item)
		# noinspection PyUnresolvedReferences
		self.itemAdded.emit()
		if self.current is None:
			self.setCurrent()
		logger.log(f"{self.name}{'_' if self.name else ''}stack: +1 ({len(self)})")

	def reverse_pop(self):
		"""
		this function will wait 5 millisecond before calling the original function.
		i'm doing this because "somehow", calling the original function directly,
		the item in the stack is "somehow" removed before it is added, and it triggered some sneaky
		errors. the behavior might be traced back to Qt's Signal design or my tangled code or...
		the fact that i still cant find a way to trigger an event once data has been sent over the network..
		if any latency issue arises, the delay can be lowered to 1 millisecond.
		the original function removes the first item in the list and then set the new item at `0`
		as the current item.
		"""
		QTimer.singleShot(5, self.reverse_pop_)

	def reverse_pop_(self):
		assert self.list[0] == self.current
		del self.list[0]
		self.setCurrent()
		logger.log(f"{self.name}{'_' if self.name else ''}stack: -1 ({len(self)})")

	def __len__(self):
		return self.list.__len__()
