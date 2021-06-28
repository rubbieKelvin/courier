from socket import gethostname
import socket
from PySide2.QtCore import Slot
from PySide2.QtCore import QObject

class Helper(QObject):
	
	@Slot(result=str)
	def hostname(self):
		return socket.gethostname()
