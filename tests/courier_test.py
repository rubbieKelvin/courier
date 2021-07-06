"""
ME I CANNOT WRITE TEST OHH... :(
"""

import unittest
from uuid import uuid4
from lib.server import CourierServer
from lib.client import CourierClient
from lib.messages import PrivateTextMessage


class TestCourierWorkflow(unittest.TestCase):
	def setUp(self) -> None:
		self.server = CourierServer()
		self.client_1 = CourierClient()
		self.client_2 = CourierClient()

		# ...
		self.initialized = self.server.run()
		self.c1_connected = self.client_1.connect_to(":self")
		self.c2_connected = self.client_2.connect_to(":self")

	def test_connection(self):
		self.assertTrue(self.initialized)
		self.assertTrue(self.c1_connected)
		self.assertTrue(self.c2_connected)

	def test_connection_auth(self):
		pass

	def test_message_sending(self):
		r_uid = self.client_2.data.get("unique_id")
		print(self.client_2.data)

		self.assertTrue(not (r_uid is None), msg="client_2 does not have a unique id")

		msg = PrivateTextMessage(id_=uuid4(), message="hello", receiver_uid=self.client_2.data.get())
