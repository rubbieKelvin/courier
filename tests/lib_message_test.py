import os
import uuid
import unittest
from lib.messages import Binary
from PySide2.QtCore import QFile
from PySide2.QtCore import QIODevice
from PySide2.QtCore import QByteArray
from PySide2.QtCore import QCryptographicHash


class TestBinaryMessage(unittest.TestCase):
	def setUp(self) -> None:
		with open(os.path.join(os.path.dirname(__file__), "data", "img.png"), "rb") as file:
			self.byte_array = QByteArray(file.read())

	def createBinary(self) -> Binary:
		return Binary(
			id_=uuid.uuid4(),
			message="text-message",
			receiver_uid="recv-id",
			binary=self.byte_array,
			extension=".png"
		)

	def test_Init(self):
		binary = self.createBinary()
		self.assertEqual(self.byte_array, binary.binary)

	def test_Conversion(self):
		binary: Binary = self.createBinary()
		self.assertTrue(type(binary.binary) == QByteArray)

		binary: QByteArray = binary.toQByteArray()
		self.assertTrue(type(binary) == QByteArray)

		binary: Binary = Binary.fromQByteArray(binary)
		self.assertTrue(type(binary.binary) == QByteArray)
		self.assertTrue(binary.meta.get("hash_verified"))

	def test_Restructuring(self):
		binary: Binary = self.createBinary()
		binary: QByteArray = binary.toQByteArray()
		binary: Binary = Binary.fromQByteArray(binary)

		file = QFile(os.path.join(os.path.dirname(__file__), "data", "img-copy.png"))

		if file.exists():
			file.moveToTrash()

		self.assertTrue(file.open(QIODevice.ReadWrite))
		file.write(binary.binary)

		self.assertTrue(type(binary.body.get("hash")) == QByteArray)
		self.assertEqual(
			binary.body.get("hash"),
			QCryptographicHash.hash(binary.binary, QCryptographicHash.Sha256))

	# def test_Restructuring_Over_network(self):
	# 	socket = QWebSocket()
	# 	socketserver = QWebSocketServer(serverName="test_server", secureMode=QWebSocketServer.NonSecureMode)
	#
	# 	def
	#
	# 	if socketserver.listen(QHostAddress("localhost"), 1244):
	# 		url = QUrl("ws://localhost:1244")
	# 		socket.open(url)
