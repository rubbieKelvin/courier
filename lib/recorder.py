import os
from PySide2.QtCore import QUrl
from PySide2.QtCore import Slot
from PySide2.QtCore import Signal
from PySide2.QtCore import QObject
from PySide2.QtCore import Property
from PySide2.QtMultimedia import QMultimedia
from PySide2.QtMultimedia import QAudioRecorder
from PySide2.QtMultimedia import QAudioEncoderSettings

class Recorder(QObject):
	def __init__(self, root: str):
		self.path = root
		self.recorder = QAudioRecorder(self)
		self.codecs = self.recorder.supportedAudioCodecs()

		self.recorder.durationChanged.connect()
		self._running = False
		self.codec = self.codecs[0]

	durationChanged = Signal(int)
	runningChanged = Signal(bool)
	codecsChanged = Signal("QVariantList")

	def duration_changed(self, duration: int):
		self.durationChanged.emit(duration)

	@Property(bool, notify=runningChanged)
	def running(self) -> bool:
		return self._running

	@Property(str)
	def recorderPath(self) -> QUrl:
		return QUrl.fromLocalFile(self.path)

	@Slot(str, result=bool)
	def record(self, name: str) -> bool:
		if self._running:
			# already recording stop recorder first
			return False

		filepath = os.path.join(self.root, name)
		audiosetting = QAudioEncoderSettings()

		audiosetting.setCodec(self.codec)
		audiosetting.setQuality(QMultimedia.HighQuality)

		self.recorder.setEncodingSettings(audiosetting)
		self.recorder.setOutputLocation(QUrl.fromLocalFile(filepath))

		self.recorder.record()
		self._running = True
		self.runningChanged.emit(self._running)
		return True

	@Slot()
	def stopRecording(self):
		self.recorder.stop()
		self._running = False
		self.runningChanged.emit(self._running)
