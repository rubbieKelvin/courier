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
from PySide2 import QtQuickControls2

# lib
from lib.helper import Helper
from lib.server import CourierServer
from lib.client import CourierClient

# chatlib
from chatlib import getUniqueId

def prepareApplicationFolders(root: str, tree: dict):
	for key, value in tree.items():
		directory = os.path.join(root, key)

		if not os.path.exists(directory):
			os.mkdir(directory)

		if type(value) is dict:
			prepareApplicationFolders(directory, value)

# resolve Warning: Ignoring XDG_SESSION_TYPE=wayland on Gnome. Use QT_QPA_PLATFORM=wayland to run on Wayland anyway.
if sys.platform == 'linux':
	os.environ["XDG_SESSION_TYPE"] = "gnome"

core_application_dir_tree = dict(
	Courier=dict(
		files=dict(
			sent=None,
			recieved=None
		),
		user=None,
		database=None,
	)
)

# create application directory
root = QtCore.QStandardPaths.writableLocation(QtCore.QStandardPaths.AppDataLocation)
prepareApplicationFolders(root, core_application_dir_tree)
# ensure we have a uid
getUniqueId()

if __name__ == "__main__":
	# core init
	app = QtGui.QGuiApplication(sys.argv)
	engine = QtQml.QQmlApplicationEngine()

	# set prerequisites for Qml.Settings Module
	app.setApplicationName("Courier")
	app.setOrganizationName("stuffsbyrubbie")
	app.setOrganizationDomain("com.stuffsbyrubbie.courier")

	QtQuickControls2.QQuickStyle.setStyle("Default")

	# Q OBJECT
	helper = Helper()
	server = CourierServer()
	client = CourierClient()

	# load engine & libs
	engine.rootContext().setContextProperty("helper", helper)
	engine.rootContext().setContextProperty("server", server)
	engine.rootContext().setContextProperty("client", client)
	engine.load(QtCore.QUrl("qrc:///uix/main.qml"))

	# run loop
	sys.exit(app.exec_())
