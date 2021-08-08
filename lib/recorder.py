import os
from uuid import uuid4
from .paths import Path

from PySide2.QtCore import QUrl
from PySide2.QtCore import Slot
from PySide2.QtCore import Signal
from PySide2.QtCore import QObject
from PySide2.QtCore import Property
from PySide2.QtMultimedia import QMultimedia
from PySide2.QtMultimedia import QAudioRecorder
from PySide2.QtMultimedia import QAudioEncoderSettings


RECORDER_QUALITY_VERY_LOW = "VeryLowQuality"
RECORDER_QUALITY_LOW = "LowQuality"
RECORDER_QUALITY_NORMAL = "NormalQuality"
RECORDER_QUALITY_HIGH = "HighQuality"
RECORDER_QUALITY_VERY_HIGH = "VeryHighQuality"


class Recorder(QObject):
	def __init__(self):
		super(Recorder, self).__init__()

		self.path = Path().VOICENOTE_ROOT
		self.recorder = QAudioRecorder(self)
		self.codecs = self.recorder.supportedAudioCodecs()

		self.recorder.durationChanged.connect(self.duration_changed)

		self._running = False
		self.codec = self.codecs[0]
		self.currentRecording: QUrl = None
		
		self.qualityOptions = {
			RECORDER_QUALITY_VERY_LOW : QMultimedia.VeryLowQuality,
			RECORDER_QUALITY_LOW : QMultimedia.LowQuality,
			RECORDER_QUALITY_NORMAL : QMultimedia.NormalQuality,
			RECORDER_QUALITY_HIGH : QMultimedia.HighQuality,
			RECORDER_QUALITY_VERY_HIGH : QMultimedia.VeryHighQuality
		}

	durationChanged = Signal(int)
	runningChanged = Signal(bool)
	codecsChanged = Signal("QVariantList")

	def duration_changed(self, duration: int):
		self.durationChanged.emit(duration)

	@Slot(result="QVariantList")
	def availableQualities(self) -> list:
		return list(self.qualityOptions.keys())

	@Property(bool, notify=runningChanged)
	def running(self) -> bool:
		return self._running

	@Property(str)
	def recorderPath(self) -> QUrl:
		return QUrl.fromLocalFile(self.path)

	@Slot(result=bool)
	@Slot(str, result=bool)
	def record(self, quality: str=RECORDER_QUALITY_NORMAL) -> bool:
		if self._running:
			# already recording stop recorder first
			return False

		filepath = os.path.join(self.path, uuid4().__str__())
		audiosetting = QAudioEncoderSettings()

		audiosetting.setCodec(self.codec)
		audiosetting.setQuality(self.qualityOptions[quality])
		audiosetting.setSampleRate(-1)

		self.currentRecording = QUrl.fromLocalFile(filepath)
		self.recorder.setEncodingSettings(audiosetting)
		self.recorder.setOutputLocation(self.currentRecording)

		self.recorder.record()
		self._running = True
		self.runningChanged.emit(self._running)
		return True

	def _stop(self):
		self.recorder.stop()
		self._running = False
		self.runningChanged.emit(self._running)

	@Slot(result=str)
	def stopRecording(self):
		""" stops the recorder an returns the filename of the last recording.
		"""
		self._stop()
		res = self.currentRecording.toLocalFile()
		self.currentRecording = None
		return res

	@Slot()
	def cancel(self):
		""" cancels the recording and deletes the previous recording.
		"""
		self._stop()
		if self.currentRecording:
			if os.path.exists(self.currentRecording.toLocalFile()):
				os.remove(self.currentRecording.toLocalFile())
