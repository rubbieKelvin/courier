# This Python file uses the following encoding: utf-8
import sys

# noinspection PyUnresolvedReferences
import resource

# pyside modules
from PySide2 import QtQml
from PySide2 import QtCore
from PySide2 import QtGui

# lib
from lib.messages import Text
from lib.helper import Helper
from lib.server import CourierServer
from lib.client import CourierClient

if __name__ == "__main__":
    # core init
    app = QtGui.QGuiApplication(sys.argv)
    engine = QtQml.QQmlApplicationEngine()

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
