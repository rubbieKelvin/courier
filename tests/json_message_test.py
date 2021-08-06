import os
import unittest
from lib.messages import Json
from lib.messages import JsonBinary
from PySide2.QtCore import QByteArray

class TestJsonStruct(unittest.TestCase):
	def test_json_property(self):
		data = Json(name="rubbie")
		self.assertTrue(
			hasattr(data, "_name") and \
			data._name == data.get('name')
		)

class TestJsonBinary(unittest.TestCase):
	def test_bjson(self):
		initial_qbyte = QByteArray(os.urandom(30))
		bjson = JsonBinary(payload=initial_qbyte, **dict(id=0))
		tr_bjson = bjson.to_qbytearray()
		new_bjson = JsonBinary.from_qbytearray(tr_bjson)

		self.assertTrue(new_bjson._payload == initial_qbyte)