import os
from PySide2.QtSql import QSqlQuery
from PySide2.QtSql import QSqlDatabase
from PySide2.QtCore import QStandardPaths

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
		return False


class Person(Db):
	__tablename__ = "people"
	CREATE_TABLE_SQL = f"""
	CREATE TABLE "{__tablename__}" (
		"id"	INTEGER,
		"uid"	TEXT NOT NULL UNIQUE,
		"name"	TEXT NOT NULL,
		"avatar_filename"	TEXT,
		PRIMARY KEY("id" AUTOINCREMENT)
	)
	"""

class Message(Db):
	__tablename__ = "messages"
	CREATE_TABLE_SQL = f"""
	CREATE TABLE {__tablename__} (
		id            INTEGER  PRIMARY KEY AUTOINCREMENT,
		body          TEXT,
		time_uploaded DATETIME NOT NULL,
		message_uid   STRING   UNIQUE
							NOT NULL,
		sender                 REFERENCES people (id) ON DELETE CASCADE,
		attached_file STRING,
		replying_to   STRING
	)
	"""

def init():

	# initialize sqlite3+
	dbfile = os.path.join(
		QStandardPaths.writableLocation(QStandardPaths.AppDataLocation),
		"Courier", "database", "courier-messages.sqlite3.crypt")
	db = QSqlDatabase.addDatabase("QSQLITE")
	db.setDatabaseName(dbfile)

	# open database
	if not db.open():
		return False
	
	# assign
	Db.db = db

	# create table
	Person().createTable()
	Message().createTable()

	return True
