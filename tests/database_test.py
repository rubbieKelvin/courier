import os
import unittest
from lib import db
from uuid import uuid4
from PySide2.QtSql import QSqlQuery
from PySide2.QtCore import QDateTime

class TestPeopleDatabase(unittest.TestCase):
	def setUp(self) -> None:
		if os.path.exists(db.FILENAME):
			os.remove(db.FILENAME)
		db.init("")

		person = db.Person()
		data = [
			dict(
				uid=uuid4().__str__(),
				username=uuid4().__str__()[:5],
				last_interaction=QDateTime.currentDateTime()
			) for _ in range(10)
		]

		for one in data:
			person.new(**one)

	def test_insert(self):
		self.assertTrue(db.Person().new(
			uid="test",
			username="rubbie kelvin - test name"
		))

	def test_multiple_query(self):
		query = QSqlQuery()
		res = query.exec_("""
		INSERT INTO people (uid, username) values ('new uid', 'kelvin')
		""")

		query = QSqlQuery()
		res = res and query.exec_("""
		INSERT INTO people (uid, username) values ('new-uid', 'kelvin')
		""")

		if not res:
			print(query.lastError())

		self.assertTrue(res)

	def test_person_update(self):
		person = db.Person()
		
		res = person.new(uid="new", username="james")
		self.assertTrue(res)

		res = person.update("new", username="kandy man")
		self.assertTrue(res)

	def test_getAll(self):
		person = db.Person()
		data = person.getAll()
		print(data)
		self.assertTrue(type(data) is list)

class TestMessageDatabase(unittest.TestCase):
	def setUp(self):
		if os.path.exists(db.FILENAME):
			os.remove(db.FILENAME)
		db.init("")

		person = db.Person()
		data = [
			dict(
				uid=uuid4().__str__(),
				username=f"person_{_}",
				last_interaction=QDateTime.currentDateTime()
			) for _ in range(2)
		]

		for one in data:
			person.new(**one)

	def test_create_message(self):
		message = db.Message()
		message.new(body="hello", time_uploaded=QDateTime.currentDateTime(), message_uid=uuid4().__str__(), sender=1)
