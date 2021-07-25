import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15
import "../controls"
import "../widgets"
import "../utils/svg.js" as Svg

BorderedRectangle {
	id: root
	height: 48
	color: "transparent"
	bottomborder.color: theme.stroke
	property alias avatar: avatar

	signal requestPage(string pagename)

	Row {
		id: row
		anchors.fill: parent
		anchors.margins: 8

		RowLayout {
			width: parent.width / 3
			anchors.verticalCenter: parent.verticalCenter

			SearchField {
				Layout.fillWidth: true
				leftPadding: 30
				Layout.preferredHeight: 34
				Layout.preferredWidth: 240
			}
		}

		RowLayout {
			width: parent.width / 3
			anchors.verticalCenter: parent.verticalCenter

			ToolButtonIcon {
				Layout.fillHeight: true
				Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
				source: Svg.fromString([
					'<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">',
					`<path opacity="0.4" d="M22 15.9402C22 18.7302 19.76 20.9902 16.97 21.0002H16.96H7.05C4.27 21.0002 2 18.7502 2 15.9602V15.9502C2 15.9502 2.006 11.5242 2.014 9.29821C2.015 8.88021 2.495 8.64621 2.822 8.90621C5.198 10.7912 9.447 14.2282 9.5 14.2732C10.21 14.8422 11.11 15.1632 12.03 15.1632C12.95 15.1632 13.85 14.8422 14.56 14.2622C14.613 14.2272 18.767 10.8932 21.179 8.97721C21.507 8.71621 21.989 8.95021 21.99 9.36721C22 11.5762 22 15.9402 22 15.9402Z" fill="${theme.accent}"/>`,
					`<path d="M21.4761 5.6736C20.6101 4.0416 18.9061 2.9996 17.0301 2.9996H7.05013C5.17413 2.9996 3.47013 4.0416 2.60413 5.6736C2.41013 6.0386 2.50213 6.4936 2.82513 6.7516L10.2501 12.6906C10.7701 13.1106 11.4001 13.3196 12.0301 13.3196C12.0341 13.3196 12.0371 13.3196 12.0401 13.3196C12.0431 13.3196 12.0471 13.3196 12.0501 13.3196C12.6801 13.3196 13.3101 13.1106 13.8301 12.6906L21.2551 6.7516C21.5781 6.4936 21.6701 6.0386 21.4761 5.6736Z" fill="${theme.accent}"/>`,
					'</svg>'])
				tiptext: "Open chat view"
				onClicked: requestPage("chat")
			}

			ToolButtonIcon {
				Layout.fillHeight: true
				source: Svg.fromString([
					'<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">',
					`<path opacity="0.4" d="M16.8843 5.11485H13.9413C13.2081 5.11969 12.512 4.79355 12.0474 4.22751L11.0782 2.88762C10.6214 2.31661 9.9253 1.98894 9.19321 2.00028H7.11261C3.37819 2.00028 2.00001 4.19201 2.00001 7.91884V11.9474C1.99536 12.3904 21.9956 12.3898 21.9969 11.9474V10.7761C22.0147 7.04924 20.6721 5.11485 16.8843 5.11485Z" fill="${theme.accent}"/>`,
					`<path fill-rule="evenodd" clip-rule="evenodd" d="M20.8321 6.54347C21.1521 6.91755 21.3993 7.34787 21.5612 7.81237C21.8798 8.76705 22.0273 9.7703 21.9969 10.7761V16.0291C21.9956 16.4716 21.963 16.9134 21.8991 17.3513C21.7775 18.124 21.5057 18.8655 21.0989 19.5341C20.9119 19.8571 20.6849 20.1552 20.4231 20.4215C19.2383 21.5089 17.665 22.0749 16.0574 21.992H7.93061C6.32049 22.0743 4.74462 21.5085 3.55601 20.4215C3.2974 20.1547 3.07337 19.8566 2.88915 19.5341C2.48475 18.866 2.21869 18.1238 2.1067 17.3513C2.03549 16.9141 1.99981 16.472 2 16.0291V10.7761C1.99983 10.3374 2.02357 9.89896 2.07113 9.46282C2.08113 9.3863 2.09614 9.31103 2.11098 9.23653C2.13573 9.11234 2.16005 8.99032 2.16005 8.8683C2.25031 8.34198 2.41496 7.8311 2.64908 7.35095C3.34261 5.8691 4.76525 5.11486 7.09481 5.11486H16.8754C18.1802 5.01395 19.4753 5.40674 20.5032 6.21516C20.6215 6.31554 20.7316 6.42534 20.8321 6.54347ZM6.97033 15.5411H17.0355H17.0533C17.2741 15.5507 17.4896 15.4716 17.6517 15.3216C17.8137 15.1715 17.9088 14.963 17.9157 14.7425C17.9282 14.5487 17.8644 14.3577 17.7379 14.2101C17.5924 14.0118 17.3618 13.8934 17.1155 13.8906H6.97033C6.51365 13.8906 6.14343 14.2601 6.14343 14.7159C6.14343 15.1716 6.51365 15.5411 6.97033 15.5411Z" fill="${theme.accent}"/>`,
					'</svg>'])
				tiptext: "See all recieved files"
				onClicked: requestPage("file")
			}
		}

		RowLayout {
			width: parent.width / 3
			anchors.verticalCenter: parent.verticalCenter

			ProfileAvatar {
				id: avatar
				Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
				Layout.preferredHeight: 34
				Layout.preferredWidth: 34
			}
		}
	}
}
