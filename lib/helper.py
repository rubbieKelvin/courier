import socket
from PySide2.QtCore import Slot
from PySide2.QtCore import QObject

EXTENSION_TYPES = dict(
	TEXT=[".txt", ".log"],
	VIDEO=[".mp4", ".avi", ".mkv"],
	IMAGE=[".png", ".jpg", ".jpeg", ".gif"],
	MUSIC=[".mp3", ".wav", ".oog", ".flac", ".m4a"],
	CODE=[".htm", ".html", ".py", ".h", ".cpp", ".c", ".hpp", ".js", ".html", ".css", ".java", ".kt", ".sh"],
)


class Helper(QObject):
	
	# noinspection PyTypeChecker
	@Slot(result=str)
	def hostname(self) -> str:
		return socket.gethostname()

	# noinspection PyTypeChecker
	@Slot(result=str)
	def ip(self) -> str:
		return socket.gethostbyname(self.hostname())

	# noinspection PyTypeChecker
	@Slot(result=str)
	def determineExtType(self, extension: str) -> str:
		for type_, ext_list in EXTENSION_TYPES.items():
			if extension in ext_list:
				return type_
		return "UNKNOWN"
