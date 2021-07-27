import unittest
from lib.messages import Json

class TestJsonStruct(unittest.TestCase):
	def test_json_property(self):
		data = Json(name="rubbie")
		self.assertTrue(
			hasattr(data, "_name") and \
			data._name == data.get('name')
		)