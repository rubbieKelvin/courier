import os
import sys
from PySide2.QtCore import QDir
from PySide2.QtCore import QStandardPaths

class Path:
	INITIALIZED = False

	def __init__(self) -> None:
		# get root
		self.root = QStandardPaths.writableLocation(QStandardPaths.AppDataLocation)
		self.temp_root = QStandardPaths.writableLocation(QStandardPaths.TempLocation)

		if not Path.INITIALIZED:
			Path.INITIALIZED = True

			# create root if not available
			Path.force_mkdir(self.root)
			Path.force_mkdir(self.temp_root)

			# prepare folders	
			Path.mk_tree(self.root, {
				'files': dict(
					images=None,
					audio=None,
					video=None,
					others=None,
					documents=None,
					voicenotes=dict(
						me=None
					),
					profile_photos=None
				),
				'user': None,
				'.temp': None,
				'database': None}
			)

			Path.mk_tree(self.temp_root, dict(tmp=None))

		# CONSTANTS
		self.DATABASE_DIR = os.path.join(self.root, "database")
		self.DATAROOT_FILE = os.path.join(self.root, "user", ".appdat")
		self.FILES_OTHER_ROOT = os.path.join(self.root, 'files', 'others')
		self.UUID_FILE = os.path.join(self.root, "user", ".u")
		self.USERNAME_FILE = os.path.join(self.root, "user", ".n")
		self.PROFILE_PHOTO_ROOT = os.path.join(self.root, "files", "profile_photos")
		self.VOICENOTE_ROOT = os.path.join(self.root, "files", "voicenotes")
		self.MY_VOICENOTE_ROOT = os.path.join(self.root, "files", "voicenotes", "me")
		self.TEMP_ROOT = os.path.join(self.temp_root, 'tmp')

	@staticmethod
	def mk_tree(root_: str, tree: dict):
		for key, value in tree.items():
			directory = os.path.join(root_, key)

			if not os.path.exists(directory):
				os.mkdir(directory)

			if type(value) is dict:
				Path.mk_tree(directory, value)

	@staticmethod
	def force_mkdir(dir: str) -> bool:
		if not os.path.exists(dir):
			# create top level if not exist
			toplevel_dir = os.path.split(dir)[0]

			if not os.path.exists(toplevel_dir):
				if not QDir().mkdir(toplevel_dir):
					return False
			
			if not QDir().mkdir(dir):
				return False

			return True
		return True
