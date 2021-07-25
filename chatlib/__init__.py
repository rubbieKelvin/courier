import os
from uuid import uuid4
from datetime import datetime
from PySide2.QtCore import QStandardPaths

def getUniqueId() -> str:
	""" creates a unique id for this device.
	the id will be used for unique identification in chats.
	if there's no unique id, a new one will be created
	"""
	filedir = os.path.join(
		QStandardPaths.writableLocation(QStandardPaths.AppDataLocation),
		"Courier", "user", ".user"
	)

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
