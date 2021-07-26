import json
import socket
from PySide2.QtCore import Slot
from PySide2.QtCore import QObject
from PySide2.QtWebSockets import QWebSocketProtocol
# ...
from .server import CourierServer
from .client import CourierClient

class Helper(QObject):
	def __init__(self, server: CourierServer, client: CourierClient):
		super(Helper, self).__init__()
		self.server = server
		self.client = client

		# whenever server starts running,
		# connect client to server.
		self.server.runningChanged.connect(self.connect_client_to_self)

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


	def setItemData(self):
		pass

	def getItemData(self):
		pass

	def deleteItemData(self):
		pass