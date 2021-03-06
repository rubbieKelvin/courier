import os
from . import logger
from PySide2.QtSql import QSqlQuery
from PySide2.QtSql import QSqlDatabase

FILENAME = "courier.sqlite3.crypt"

class Db:
	db: QSqlDatabase=None
	__tablename__ = ""
	CREATE_TABLE_SQL = """"""
	def __init__(self) -> None:
		self.query = QSqlQuery()

	def new(self, **kwargs) -> bool:
		SQL = f"""
		INSERT INTO {self.__tablename__} ({", ".join(kwargs.keys())})
			VALUES ({", ".join([':'+x for x in kwargs.keys()])})
		"""
		
		self.query.prepare(SQL)
		for key, value in kwargs.items():
			self.query.bindValue(f":{key}", value)

		return self.query.exec_()

	def createTable(self):
		if self.db:
			if not self.__tablename__ in self.db.tables():
				return self.query.exec_(self.CREATE_TABLE_SQL)
			return True
		return False


class Person(Db):
	__tablename__ = "people"
	CREATE_TABLE_SQL = f"""
	CREATE TABLE IF NOT EXISTS "{__tablename__}" (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		uid TEXT NOT NULL UNIQUE,
		username TEXT NOT NULL,
		avatar TEXT,
		last_interaction DATETIME
	)
	"""

	def update(self, uid: str, **kwargs) -> bool:
		SQL = f"""
		UPDATE
			{self.__tablename__}
		SET
			{
				", ".join([
					f"{key} = :{key}" for key, value in kwargs.items()
				])
			}
		WHERE
			uid = "{uid}"
		"""
		self.query.prepare(SQL)
		for key, value in kwargs.items():
			self.query.bindValue(f":{key}", value)

		return self.query.exec_()

	def getAll(self) -> list:
		SQL = f"""
		SELECT
			id,
			uid,
			username,
			avatar,
			last_interaction
		FROM {self.__tablename__}
		"""
		result = []
		if self.query.exec_(SQL):
			while self.query.next():
				result.append(dict(
					_id=self.query.value("id"),
					uid=self.query.value("uid"),
					username=self.query.value("username"),
					avatar=self.query.value("avatar"),
					last_interaction=self.query.value("last_interaction")
				))
			return result
		return None


class Message(Db):
	__tablename__ = "messages"
	CREATE_TABLE_SQL = f"""
	CREATE TABLE IF NOT EXISTS {__tablename__} (
		id            INTEGER  PRIMARY KEY AUTOINCREMENT,
		body          TEXT,
		timestamp	  DATETIME NOT NULL,
		message_uid   STRING UNIQUE NOT NULL,
		sender        REFERENCES people (id) ON DELETE CASCADE,
		attached_file STRING,
		replying_to   STRING
	)
	"""

def init(root):

	# initialize sqlite3+
	dbfile = os.path.join(root, FILENAME)
	db = QSqlDatabase.addDatabase("QSQLITE")
	db.setDatabaseName(dbfile)

	# open database
	if not db.open():
		logger.error(db.lastError())
		return False
	
	# assign
	Db.db = db

	# create table
	res = \
		Person().createTable() and \
		Message().createTable()

	if not res:
		logger.error(db.lastError())
	return res

# TODO: fix query binding on Person.update
