import unittest
from lib import db
from uuid import uuid4

class TestDatabase(unittest.TestCase):
	def setUp(self) -> None:
		db.init()

	def test_insert(self):
		self.assertTrue(db.Person().new(
			uid=uuid4().__str__(),
			name="rubbie kelvin - test name"
		))
