# rubbie kelvin
# This Python file uses the following encoding: utf-8
import os
import sys

# noinspection PyUnresolvedReferences
import qrc

# pyside modules
from PySide2 import QtQml
from PySide2 import QtCore
from PySide2 import QtGui

# lib
from lib import db
from lib.helper import Helper
from lib.server import CourierServer
from lib.client import CourierClient


def prepareApplicationFolders(root_: str, tree: dict):
	for key, value in tree.items():
		directory = os.path.join(root_, key)

		if not os.path.exists(directory):
			os.mkdir(directory)

		if type(value) is dict:
			prepareApplicationFolders(directory, value)


# resolve Warning: Ignoring XDG_SESSION_TYPE=wayland on Gnome. Use QT_QPA_PLATFORM=wayland to run on Wayland anyway.
if sys.platform == 'linux':
	os.environ["XDG_SESSION_TYPE"] = "gnome"

if __name__ == "__main__":
	# core init
	app = QtGui.QGuiApplication(sys.argv)
	engine = QtQml.QQmlApplicationEngine()

	# set prerequisites for Qml.Settings Module
	app.setApplicationName("Courier")
	app.setOrganizationName("stuffsbyrubbie")
	app.setOrganizationDomain("com.stuffsbyrubbie.courier")

	root = QtCore.QStandardPaths.writableLocation(QtCore.QStandardPaths.AppDataLocation)

	# create root is not available
	if not os.path.exists(root):
		# create top level if not exist
		toplevel_dir = os.path.split(root)[0]
		if not os.path.exists(toplevel_dir):
			if not QtCore.QDir().mkdir(toplevel_dir):
				sys.exit("could'nt create application toplevel root")
		if not QtCore.QDir().mkdir(root):
			sys.exit("could'nt create application data root")

	# create application directory
	prepareApplicationFolders(root,	
		dict(
			files=dict(
				sent=None,
				recieved=None
			),
			user=dict(
				profile_photo=None
			),
			database=None,
		))

	# initialze
	if not db.init(os.path.join(
		root, "database"
	)):
		sys.exit("couldn't initialize database.")
	
	# Q OBJECT
	server = CourierServer()
	client = CourierClient()
	helper = Helper(
		server=server,
		client=client,
		dataroot=os.path.join(root, "user", ".appdat"))

	# load libs & models
	engine.rootContext().setContextProperty("helper", helper)
	engine.rootContext().setContextProperty("server", server)
	engine.rootContext().setContextProperty("client", client)

	# load engine
	engine.load(QtCore.QUrl("qrc:///uix/main.qml"))

	# run loop
	sys.exit(app.exec_())

# TODO: create contants.py file to store constants
