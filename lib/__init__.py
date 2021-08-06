import os
import sys
import socket
import logging

from uuid import uuid4
from datetime import datetime

from .paths import Path
from PySide2.QtCore import QStandardPaths


PORT = 8977
LOG_TO_FILE = False
RUNNING_BUNDLE = getattr(sys, 'frozen', False)

# noinspection SpellCheckingInspection
logging.basicConfig(
	level=logging.INFO,
	format='%(asctime)s %(name)-8s %(levelname)-8s %(message)s',
	datefmt='%m-%d %H:%M',
	filename=os.path.join(QStandardPaths.writableLocation(QStandardPaths.TempLocation), 'courier.log'),
	filemode="w")


def is_valid_ip(ip: str) -> bool:
	try:
		socket.inet_aton(ip)
		return True
	except socket.error:
		return False


# noinspection PyPep8Naming
class logger:
	@staticmethod
	def _log(*args, mode=logging.info):
		MODE = "INFO"
		if mode == logging.debug:
			MODE = "DEBUG"
		elif mode == logging.error:
			MODE = "ERROR"
		elif mode == logging.warn:
			MODE = "WARN"

		if not RUNNING_BUNDLE:
			print(f"{MODE}: ", *args)
		if LOG_TO_FILE:
			mode(" ".join([str(i) for i in args]))

	@staticmethod
	def log(*args):
		logger._log(*args)
		
	@staticmethod
	def debug(*args):
		logger._log(*args, mode=logging.debug)

	@staticmethod
	def error(*args):
		logger._log(*args, mode=logging.error)

	@staticmethod
	def warn(*args):
		logger._log(*args, mode=logging.warning)


def getUniqueId() -> str:
	""" creates a unique id for this device.
	the id will be used for unique identification in chats.
	if there's no unique id, a new one will be created
	"""
	path = Path()
	filedir = path.UUID_FILE

	if os.path.exists(filedir):
		# just get the file and return data
		with open(filedir) as file:
			uid = file.read()
		return uid
		
	# create new and return data
	uid = uuid4().__str__()+"-"+datetime.now().__str__()
	with open(filedir, "w") as file:
		file.write(uid)
	return uid


def username(name: str=None) -> str:
	""" returns the hostname if client has not set a username
	if client has a username, just return it then.
	if the name argument is passed, just set if as a new username 
	"""

	path = Path()
	filedir = path.USERNAME_FILE

	if not name:
		if os.path.exists(filedir):
			# just get the file and return data
			with open(filedir) as file:
				username = file.read()
			return username.splitlines(keepends=False)[0]
		
	# create new and return data
	username = name or socket.gethostname()
	with open(filedir, "w") as file:
		file.write(username)
	return username
