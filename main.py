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
from lib.paths import Path
from lib.helper import Helper
from lib.recorder import Recorder
from lib.server import CourierServer
from lib.client import CourierClient


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

	# initialize path
	path = Path()

	# initialze
	if not db.init(path.DATABASE_DIR):
		sys.exit("couldn't initialize database.")
	
	# Q OBJECT
	recorder = Recorder()
	server = CourierServer()
	client = CourierClient()
	helper = Helper(
		server=server,
		client=client,
		dataroot=path.DATAROOT_FILE)

	# load libs & models
	engine.rootContext().setContextProperty("helper", helper)
	engine.rootContext().setContextProperty("server", server)
	engine.rootContext().setContextProperty("client", client)
	engine.rootContext().setContextProperty("recorder", recorder)

	# load engine
	engine.load(QtCore.QUrl("qrc:///uix/main.qml"))

	# run loop
	sys.exit(app.exec_())

# TODO: create contants.py file to store constants
