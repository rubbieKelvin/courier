import os
import json
import socket
from PySide2.QtCore import Slot
from PySide2.QtCore import QObject
from PySide2.QtQml import QJSValue
from PySide2.QtWebSockets import QWebSocketProtocol
# ...
from .server import CourierServer
from .client import CourierClient

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

		# whenever server starts running,
		# connect client to server.
		self.server.runningChanged.connect(self.connect_client_to_self)

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
		kv = kv.toVariant()
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
