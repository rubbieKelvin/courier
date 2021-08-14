import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtMultimedia 5.12
import "../controls"
import "../utils/svg.js" as Svg
import "../utils/constants.js" as Constants

Rectangle {
	id: root
	radius: 8
	width: 260
	height: 45
	property color label_color: theme.text
	property variant message: ({})

	function twoDigitString(number) {
		if (number < 10) {
			number = "0" + number
		}
		return number
	}

	function timeFromDuration(duration) {
		let dur = new Date(duration)
		let hour = dur.getUTCHours()
		let minute = dur.getUTCMinutes()
		let seconds = dur.getUTCSeconds()

		let time = ""
		if (hour > 0) {
			time += twoDigitString(hour) + ":"
		}

		time += twoDigitString(minute) + ":"
		time += twoDigitString(seconds)

		return time
	}

	Audio {
		id: audio
		audioRole: Audio.MusicRole
		property bool isPlaying: false

		Component.onCompleted: {
			if (message.type === Constants.PRIVATE_MESSAGE_VOICE_NOTE)
				source = message.filename
		}

		onPaused: isPlaying = false
		onPlaying: {
			currentAudio = this
			isPlaying = true
			durr.text = Qt.binding(function () {
				return timeFromDuration(audio.position)
			})
		}
		onStopped: {
			if (currentAudio == audio)
				currentAudio = null
			isPlaying = false
			durr.text = timeFromDuration(audio.duration)
		}
	}

	Connections {
		target: application
		function onCurrentAudioChanged() {
			if (currentAudio != audio)
				audio.stop()
		}
	}

	RowLayout {
		spacing: 8
		anchors.fill: parent
		anchors.leftMargin: 5
		anchors.rightMargin: 5

		ToolButtonIcon {
			id: play_button
			property color sourcecolor: theme.accent
			Layout.preferredWidth: 30
			Layout.preferredHeight: 30
			property string playsource: `<svg viewBox="0 0 15 15" class="bi bi-play-fill" fill="${sourcecolor}" xmlns="http://www.w3.org/2000/svg"><path d="M11.596 8.697l-6.363 3.692c-.54.313-1.233-.066-1.233-.697V4.308c0-.63.692-1.01 1.233-.696l6.363 3.692a.802.802 0 0 1 0 1.393z"/></svg>`
			property string pausesource: `<svg viewBox="0 0 15 15" class="bi bi-pause-fill" fill="${sourcecolor}" xmlns="http://www.w3.org/2000/svg"><path d="M5.5 3.5A1.5 1.5 0 0 1 7 5v6a1.5 1.5 0 0 1-3 0V5a1.5 1.5 0 0 1 1.5-1.5zm5 0A1.5 1.5 0 0 1 12 5v6a1.5 1.5 0 0 1-3 0V5a1.5 1.5 0 0 1 1.5-1.5z"/></svg>`
			source: Svg.fromString([audio.isPlaying ? pausesource : playsource])
			tiptext: "click to play"
			tiptimeout: 1000
			onClicked: {
				if (audio.isPlaying) {
					audio.pause()
				} else {
					audio.play()
				}
			}
		}

		Slider {
			id: seeker
			height: 1
			Layout.fillWidth: true
			from: 0
			to: 100
			stepSize: 0.1
			enabled: audio.seekable
			value: (audio.position / audio.duration) * this.to
			background: Rectangle {
				id: bg
				x: seeker.leftPadding
				y: seeker.rightPadding + seeker.availableHeight / 2 - height / 2
				width: seeker.availableWidth
				implicitHeight: 1
				implicitWidth: 200
				radius: 2
				color: theme.disabled_light
				transitions: Transition {
					NumberAnimation {
						property: "height"
						duration: 120
					}
				}

				Rectangle {
					id: v_pos
					width: seeker.visualPosition * parent.width
					height: parent.height
					color: theme.accent
					radius: 2
					transitions: Transition {
						NumberAnimation {
							property: "height"
							duration: 120
						}
					}
				}
			}

			handle: Rectangle {
				id: hd
				x: seeker.leftPadding + seeker.visualPosition * (seeker.availableWidth - width)
				y: seeker.topPadding + seeker.availableHeight / 2 - height / 2
				implicitWidth: 12
				implicitHeight: 5
				radius: 5
				color: theme.accent
				states: [
					State {
						name: "pressed"
						when: seeker.pressed
						PropertyChanges {
							target: hd
							height: 10
							width: 10
						}

						PropertyChanges {
							target: bg
							height: 2
						}

						PropertyChanges {
							target: v_pos
							height: 2
						}
					}
				]

				transitions: Transition {
					NumberAnimation {
						properties: "width,height"
						duration: 120
					}
				}
			}

			onMoved: {
				audio.seek((this.value / this.to) * audio.duration)
			}
		}

		Label {
			id: durr
			text: timeFromDuration(audio.duration)
			color: label_color
			font.pixelSize: 10
		}
	}
}

/*##^##
Designer {
	D{i:0;formeditorZoom:2}
}
##^##*/

