# Resource object code (Python 3)
# Created by: object code
# Created by: The Resource Compiler for Qt version 5.15.2
# WARNING! All changes made in this file will be lost!

from PySide2 import QtCore

qt_resource_data = b"\
\x00\x00\x09\x95\
i\
mport QtQuick 2.\
15\x0aimport QtQuic\
k.Controls 2.15\x0a\
import QtQuick.L\
ayouts 1.11\x0aimpo\
rt \x22./components\
\x22\x0a\x0aPage {\x0a\x09id: r\
oot\x0a\x09readonly pr\
operty StateMana\
ger statemanager\
_: statemanager\x0a\
\x0a\x09RowLayout {\x0a\x09\x09\
anchors.fill: pa\
rent\x0a\x0a\x09\x09Rectangl\
e {\x0a\x09\x09\x09width: 25\
0\x0a\x09\x09\x09color: \x22#f6\
f6f6\x22\x0a\x09\x09\x09Layout.\
fillHeight: true\
\x0a\x0a\x09\x09\x09ColumnLayou\
t {\x0a\x09\x09\x09\x09id: colu\
mnLayout\x0a\x09\x09\x09\x09anc\
hors.fill: paren\
t\x0a\x09\x09\x09\x09anchors.ma\
rgins: 25\x0a\x09\x09\x09\x09sp\
acing: 15\x0a\x0a\x09\x09\x09\x09R\
owLayout {\x0a\x09\x09\x09\x09\x09\
id: rowLayout\x0a\x09\x09\
\x09\x09\x09Layout.fillWi\
dth: true\x0a\x09\x09\x09\x09\x09L\
ayout.alignment:\
 Qt.AlignLeft | \
Qt.AlignTop\x0a\x0a\x09\x09\x09\
\x09\x09Column {\x0a\x09\x09\x09\x09\x09\
\x09id: column\x0a\x09\x09\x09\x09\
\x09\x09Layout.fillWid\
th: true\x0a\x09\x09\x09\x09\x09\x09L\
ayout.alignment:\
 Qt.AlignLeft | \
Qt.AlignTop\x0a\x0a\x09\x09\x09\
\x09\x09\x09Label {\x0a\x09\x09\x09\x09\x09\
\x09\x09id: label\x0a\x09\x09\x09\x09\
\x09\x09\x09text: qsTr(\x22C\
ourier\x22)\x0a\x09\x09\x09\x09\x09\x09\x09\
font.pointSize: \
14\x0a\x09\x09\x09\x09\x09\x09}\x0a\x0a\x09\x09\x09\x09\
\x09\x09Label {\x0a\x09\x09\x09\x09\x09\x09\
\x09id: label1\x0a\x09\x09\x09\x09\
\x09\x09\x09text: qsTr(\x22s\
tuffsbyrubbie\x22)\x0a\
\x09\x09\x09\x09\x09\x09\x09font.poin\
tSize: 10\x0a\x09\x09\x09\x09\x09\x09\
}\x0a\x09\x09\x09\x09\x09}\x0a\x0a\x09\x09\x09\x09\x09L\
abel {\x0a\x09\x09\x09\x09\x09\x09id:\
 label2\x0a\x09\x09\x09\x09\x09\x09te\
xt: qsTr(\x22rubbie\
\x22)\x0a\x09\x09\x09\x09\x09\x09Layout.\
alignment: Qt.Al\
ignRight | Qt.Al\
ignVCenter\x0a\x09\x09\x09\x09\x09\
}\x0a\x09\x09\x09\x09}\x0a\x0a\x09\x09\x09\x09Lab\
el {\x0a\x09\x09\x09\x09\x09id: la\
bel3\x0a\x09\x09\x09\x09\x09text: \
qsTr(`Peers (${s\
tatemanager_.pee\
rmodel.count})`)\
\x0a\x09\x09\x09\x09\x09font.point\
Size: 12\x0a\x09\x09\x09\x09\x09La\
yout.alignment: \
Qt.AlignLeft | Q\
t.AlignTop\x0a\x09\x09\x09\x09}\
\x0a\x09\x09\x09\x09ScrollView \
{\x0a\x09\x09\x09\x09\x09Layout.fi\
llHeight: true\x0a\x09\
\x09\x09\x09\x09Layout.fillW\
idth: true\x0a\x09\x09\x09\x09\x09\
ScrollBar.horizo\
ntal.policy: Scr\
ollBar.AlwaysOff\
\x0a\x09\x09\x09\x09\x09ScrollBar.\
vertical.policy:\
 ScrollBar.AsNee\
ded\x0a\x0a\x09\x09\x09\x09\x09ListVi\
ew {\x0a\x09\x09\x09\x09\x09\x09id: p\
eer_list_view\x0a\x09\x09\
\x09\x09\x09\x09spacing: 3\x0a\x09\
\x09\x09\x09\x09\x09clip: true\x0a\
\x09\x09\x09\x09\x09\x09delegate: \
Rectangle {\x0a\x09\x09\x09\x09\
\x09\x09\x09height: 40\x0a\x09\x09\
\x09\x09\x09\x09\x09width: (par\
ent || {\x0a\x09\x09\x09\x09\x09\x09\x09\
\x09\x09\x09\x22width\x22: 0\x0a\x09\x09\
\x09\x09\x09\x09\x09\x09\x09}).width\x0a\
\x09\x09\x09\x09\x09\x09\x09clip: tru\
e\x0a\x09\x09\x09\x09\x09\x09\x09color: \
\x22transparent\x22\x0a\x0a\x09\
\x09\x09\x09\x09\x09\x09RowLayout \
{\x0a\x09\x09\x09\x09\x09\x09\x09\x09anchor\
s.fill: parent\x0a\x09\
\x09\x09\x09\x09\x09\x09\x09anchors.m\
argins: 5\x0a\x0a\x09\x09\x09\x09\x09\
\x09\x09\x09Rectangle {\x0a\x09\
\x09\x09\x09\x09\x09\x09\x09\x09id: rect\
angle\x0a\x09\x09\x09\x09\x09\x09\x09\x09\x09w\
idth: height\x0a\x09\x09\x09\
\x09\x09\x09\x09\x09\x09height: pa\
rent.height\x0a\x09\x09\x09\x09\
\x09\x09\x09\x09\x09color: \x22#c4\
c4c4\x22\x0a\x09\x09\x09\x09\x09\x09\x09\x09\x09r\
adius: width / 2\
\x0a\x09\x09\x09\x09\x09\x09\x09\x09}\x0a\x0a\x09\x09\x09\x09\
\x09\x09\x09\x09Label {\x0a\x09\x09\x09\x09\
\x09\x09\x09\x09\x09height: par\
ent.height\x0a\x09\x09\x09\x09\x09\
\x09\x09\x09\x09text: userna\
me\x0a\x09\x09\x09\x09\x09\x09\x09\x09\x09font\
.pixelSize: 11\x0a\x09\
\x09\x09\x09\x09\x09\x09\x09\x09Layout.f\
illWidth: true\x0a\x09\
\x09\x09\x09\x09\x09\x09\x09}\x0a\x09\x09\x09\x09\x09\x09\x09\
}\x0a\x0a\x09\x09\x09\x09\x09\x09\x09MouseA\
rea{\x0a\x09\x09\x09\x09\x09\x09\x09\x09anc\
hors.fill: paren\
t\x0a\x09\x09\x09\x09\x09\x09\x09\x09hoverE\
nabled: true\x0a\x09\x09\x09\
\x09\x09\x09\x09\x09cursorShape\
: Qt.PointingHan\
dCursor\x0a\x09\x09\x09\x09\x09\x09\x09\x09\
onClicked: {}\x0a\x09\x09\
\x09\x09\x09\x09\x09}\x0a\x09\x09\x09\x09\x09\x09}\x0a\x09\
\x09\x09\x09\x09\x09model: stat\
emanager_.peermo\
del\x0a\x09\x09\x09\x09\x09}\x0a\x09\x09\x09\x09}\
\x0a\x09\x09\x09}\x0a\x09\x09}\x0a\x0a\x09\x09Sta\
ckLayout {\x0a\x09\x09\x09id\
: chat_stack\x0a\x09\x09\x09\
width: 100\x0a\x09\x09\x09he\
ight: 100\x0a\x09\x09\x09Lay\
out.fillHeight: \
true\x0a\x09\x09\x09Layout.f\
illWidth: true\x0a\x0a\
\x09\x09\x09Repeater {\x0a\x09\x09\
\x09\x09model: statema\
nager_.peermodel\
\x0a\x09\x09\x09\x09delegate: C\
hatPage {}\x0a\x09\x09\x09}\x0a\
\x09\x09}\x0a\x09}\x0a}\x0a\x0a/*##^#\
#\x0aDesigner {\x0a\x09D{\
i:0;autoSize:tru\
e;formeditorZoom\
:0.75;height:600\
;width:1000}D{i:\
3}D{i:1}\x0a}\x0a##^##\
*/\x0a\x0a\
\x00\x00\x0a}\
i\
mport QtQuick 2.\
15\x0aimport QtQuic\
k.Layouts 1.3\x0aim\
port QtQuick.Con\
trols 2.15\x0aimpor\
t \x22./components\x22\
\x0a\x0aPage {\x0a\x09id: ro\
ot\x0a\x0a\x09readonly pr\
operty StackView\
 mainstack_: mai\
nstack\x0a\x09readonly\
 property StateM\
anager statemana\
ger_: statemanag\
er\x0a\x0a\x09Column {\x0a\x09\x09\
id: column\x0a\x09\x09x: \
168\x0a\x09\x09y: 221\x0a\x09\x09w\
idth: 248\x0a\x09\x09anch\
ors.verticalCent\
er: parent.verti\
calCenter\x0a\x09\x09spac\
ing: 15\x0a\x0a\x09\x09Colum\
n {\x0a\x09\x09\x09id: colum\
n1\x0a\x09\x09\x09Label {\x0a\x09\x09\
\x09\x09id: label\x0a\x09\x09\x09\x09\
width: parent.wi\
dth\x0a\x09\x09\x09\x09text: qs\
Tr(\x22Courier\x22)\x0a\x09\x09\
\x09\x09horizontalAlig\
nment: Text.Alig\
nLeft\x0a\x09\x09\x09\x09font.p\
ointSize: 14\x0a\x09\x09\x09\
}\x0a\x0a\x09\x09\x09Label {\x0a\x09\x09\
\x09\x09id: label1\x0a\x09\x09\x09\
\x09opacity: 0.8\x0a\x09\x09\
\x09\x09text: qsTr(\x22Jo\
in Server\x22)\x0a\x09\x09\x09}\
\x0a\x09\x09}\x0a\x0a\x09\x09Column {\
\x0a\x09\x09\x09id: column3\x0a\
\x09\x09\x09width: parent\
.width\x0a\x09\x09\x09Item {\
\x0a\x09\x09\x09\x09id: item2\x0a\x09\
\x09\x09\x09width: parent\
.width\x0a\x09\x09\x09\x09heigh\
t: 25\x0a\x09\x09\x09\x09Label \
{\x0a\x09\x09\x09\x09\x09id: label\
3\x0a\x09\x09\x09\x09\x09text: qsT\
r(\x22hostname\x22)\x0a\x09\x09\
\x09\x09\x09anchors.verti\
calCenter: paren\
t.verticalCenter\
\x0a\x09\x09\x09\x09}\x0a\x09\x09\x09}\x0a\x0a\x09\x09\x09\
TextField {\x0a\x09\x09\x09\x09\
id: hostname_fie\
ld\x0a\x09\x09\x09\x09width: pa\
rent.width\x0a\x09\x09\x09\x09p\
laceholderText: \
qsTr(\x22Hostname o\
r IPv4 address..\
.\x22)\x0a\x09\x09\x09\x09enabled:\
 button1.enabled\
\x0a\x09\x09\x09}\x0a\x09\x09\x09spacing\
: 2\x0a\x09\x09}\x0a\x0a\x09\x09Colum\
n {\x0a\x09\x09\x09id: colum\
n2\x0a\x09\x09\x09width: par\
ent.width\x0a\x09\x09\x09spa\
cing: 2\x0a\x0a\x09\x09\x09Item\
 {\x0a\x09\x09\x09\x09id: item1\
\x0a\x09\x09\x09\x09width: pare\
nt.width\x0a\x09\x09\x09\x09hei\
ght: 25\x0a\x0a\x09\x09\x09\x09Lab\
el {\x0a\x09\x09\x09\x09\x09id: la\
bel2\x0a\x09\x09\x09\x09\x09text: \
qsTr(\x22password\x22)\
\x0a\x09\x09\x09\x09\x09anchors.ve\
rticalCenter: pa\
rent.verticalCen\
ter\x0a\x09\x09\x09\x09}\x0a\x0a\x09\x09\x09\x09B\
utton {\x0a\x09\x09\x09\x09\x09id:\
 button2\x0a\x09\x09\x09\x09\x09wi\
dth: 60\x0a\x09\x09\x09\x09\x09hei\
ght: parent.heig\
ht\x0a\x09\x09\x09\x09\x09text: qs\
Tr(password_fiel\
d.echoMode === T\
extInput.Passwor\
d ? \x22show\x22 : \x22hi\
de\x22)\x0a\x09\x09\x09\x09\x09anchor\
s.right: parent.\
right\x0a\x09\x09\x09\x09\x09flat:\
 true\x0a\x09\x09\x09\x09\x09ancho\
rs.rightMargin: \
0\x0a\x09\x09\x09\x09\x09onClicked\
: {\x0a\x09\x09\x09\x09\x09\x09if (pa\
ssword_field.ech\
oMode === TextIn\
put.Password)\x0a\x09\x09\
\x09\x09\x09\x09\x09password_fi\
eld.echoMode = T\
extInput.Normal\x0a\
\x09\x09\x09\x09\x09\x09else\x0a\x09\x09\x09\x09\x09\
\x09\x09password_field\
.echoMode = Text\
Input.Password\x0a\x09\
\x09\x09\x09\x09}\x0a\x09\x09\x09\x09}\x0a\x09\x09\x09}\
\x0a\x0a\x09\x09\x09TextField {\
\x0a\x09\x09\x09\x09id: passwor\
d_field\x0a\x09\x09\x09\x09widt\
h: parent.width\x0a\
\x09\x09\x09\x09enabled: but\
ton1.enabled\x0a\x09\x09\x09\
\x09placeholderText\
: qsTr(\x22Password\
...\x22)\x0a\x09\x09\x09\x09echoMo\
de: TextInput.Pa\
ssword\x0a\x09\x09\x09}\x0a\x09\x09}\x0a\
\x0a\x09\x09RowLayout {\x0a\x09\
\x09\x09id: row\x0a\x09\x09\x09wid\
th: parent.width\
\x0a\x09\x09\x09spacing: 5\x0a\x0a\
\x09\x09\x09Button {\x0a\x09\x09\x09\x09\
id: button\x0a\x09\x09\x09\x09e\
nabled: button1.\
enabled\x0a\x09\x09\x09\x09text\
: qsTr(\x22Cancel\x22)\
\x0a\x09\x09\x09\x09Layout.fill\
Width: false\x0a\x09\x09\x09\
\x09onClicked: main\
stack_.pop()\x0a\x09\x09\x09\
}\x0a\x0a\x09\x09\x09LoadButton\
 {\x0a\x09\x09\x09\x09id: butto\
n1\x0a\x09\x09\x09\x09text: qsT\
r(\x22Join\x22)\x0a\x09\x09\x09\x09La\
yout.fillWidth: \
true\x0a\x0a\x09\x09\x09\x09onClic\
ked: {\x0a\x09\x09\x09\x09\x09enab\
led = false\x0a\x09\x09\x09\x09\
\x09statemanager_.c\
onnectToServer(h\
ostname_field.te\
xt)\x0a\x09\x09\x09\x09}\x0a\x0a\x09\x09\x09\x09C\
onnections {\x0a\x09\x09\x09\
\x09\x09target: statem\
anager_\x0a\x0a\x09\x09\x09\x09\x09fu\
nction onRequire\
Auth(){\x0a\x09\x09\x09\x09\x09\x09cl\
ient.authenticat\
e(password_field\
.text)\x0a\x09\x09\x09\x09\x09}\x0a\x0a\x09\
\x09\x09\x09\x09function onH\
andshakeDone(sta\
te) {\x0a\x09\x09\x09\x09\x09\x09butt\
on1.enabled = tr\
ue\x0a\x09\x09\x09\x09\x09\x09if (sta\
te)\x0a\x09\x09\x09\x09\x09\x09\x09mains\
tack_.push(\x22./ho\
me.qml\x22)\x0a\x09\x09\x09\x09\x09}\x0a\
\x09\x09\x09\x09}\x0a\x09\x09\x09}\x0a\x09\x09}\x0a\x0a\
\x09\x09anchors.horizo\
ntalCenter: pare\
nt.horizontalCen\
ter\x0a\x09}\x0a}\x0a\x0a/*##^#\
#\x0aDesigner {\x0a\x09D{\
i:0;autoSize:tru\
e;formeditorZoom\
:0.9;height:480;\
width:640}D{i:5}\
\x0a}\x0a##^##*/\x0a\x0a\
\x00\x00\x04c\
i\
mport QtQuick 2.\
15\x0aimport QtQuic\
k.Controls 2.15\x0a\
\x0aPage {\x0a\x09id: roo\
t\x0a\x0a\x09readonly pro\
perty StackView \
mainstack_: main\
stack\x0a\x0a\x09Column {\
\x0a\x09\x09id: column\x0a\x09\x09\
x: 168\x0a\x09\x09y: 221\x0a\
\x09\x09height: 99\x0a\x09\x09a\
nchors.verticalC\
enter: parent.ve\
rticalCenter\x0a\x09\x09s\
pacing: 15\x0a\x09\x09anc\
hors.horizontalC\
enter: parent.ho\
rizontalCenter\x0a\x0a\
\x09\x09Column {\x0a\x09\x09\x09id\
: column1\x0a\x0a\x09\x09\x09La\
bel {\x0a\x09\x09\x09\x09id: la\
bel\x0a\x09\x09\x09\x09width: p\
arent.width\x0a\x09\x09\x09\x09\
text: qsTr(\x22Cour\
ier\x22)\x0a\x09\x09\x09\x09horizo\
ntalAlignment: T\
ext.AlignLeft\x0a\x09\x09\
\x09\x09font.pointSize\
: 14\x0a\x09\x09\x09}\x0a\x0a\x09\x09\x09La\
bel {\x0a\x09\x09\x09\x09id: la\
bel1\x0a\x09\x09\x09\x09opacity\
: 0.8\x0a\x09\x09\x09\x09text: \
qsTr(\x22stuffsbyru\
bbie\x22)\x0a\x09\x09\x09}\x0a\x09\x09}\x0a\
\x0a\x09\x09Row {\x0a\x09\x09\x09id: \
row\x0a\x09\x09\x09spacing: \
5\x0a\x0a\x09\x09\x09Button {\x0a\x09\
\x09\x09\x09id: button\x0a\x09\x09\
\x09\x09text: qsTr(\x22Cr\
eate Workspace\x22)\
\x0a\x09\x09\x09\x09onClicked: \
mainstack_.push(\
\x22./create_server\
.qml\x22)\x0a\x09\x09\x09}\x0a\x0a\x09\x09\x09\
Button {\x0a\x09\x09\x09\x09id:\
 button1\x0a\x09\x09\x09\x09tex\
t: qsTr(\x22Join Wo\
rkspace\x22)\x0a\x09\x09\x09\x09on\
Clicked: mainsta\
ck_.push(\x22./join\
_server.qml\x22)\x0a\x09\x09\
\x09}\x0a\x09\x09}\x0a\x09}\x0a\x0a\x09Labe\
l {\x0a\x09\x09y: 457\x0a\x09\x09o\
pacity: 0.8\x0a\x09\x09te\
xt: qsTr(`networ\
k: ${helper.host\
name()}`)\x0a\x09\x09anch\
ors.left: parent\
.left\x0a\x09\x09anchors.\
bottom: parent.b\
ottom\x0a\x09\x09anchors.\
bottomMargin: 10\
\x0a\x09\x09anchors.leftM\
argin: 10\x0a\x09}\x0a}\x0a\x0a\
/*##^##\x0aDesigner\
 {\x0a\x09D{i:0;autoSi\
ze:true;formedit\
orZoom:0.9;heigh\
t:480;width:640}\
D{i:8}\x0a}\x0a##^##*/\
\x0a\x0a\
\x00\x00\x0a\x1c\
i\
mport QtQuick 2.\
15\x0aimport QtQuic\
k.Layouts 1.3\x0aim\
port QtQuick.Con\
trols 2.15\x0aimpor\
t \x22./components\x22\
\x0a\x0aPage {\x0a\x09id: ro\
ot\x0a\x0a\x09readonly pr\
operty StackView\
 mainstack_: mai\
nstack\x0a\x09readonly\
 property StateM\
anager statemana\
ger_: statemanag\
er\x0a\x0a\x09Column {\x0a\x09\x09\
id: column\x0a\x09\x09x: \
168\x0a\x09\x09y: 221\x0a\x09\x09w\
idth: 248\x0a\x09\x09anch\
ors.verticalCent\
er: parent.verti\
calCenter\x0a\x09\x09spac\
ing: 15\x0a\x0a\x09\x09RowLa\
yout {\x0a\x09\x09\x09id: ro\
wLayout\x0a\x09\x09\x09width\
: parent.width\x0a\x0a\
\x09\x09\x09Column {\x0a\x09\x09\x09\x09\
id: column1\x0a\x09\x09\x09\x09\
Label {\x0a\x09\x09\x09\x09\x09id:\
 label\x0a\x09\x09\x09\x09\x09widt\
h: parent.width\x0a\
\x09\x09\x09\x09\x09text: qsTr(\
\x22Courier\x22)\x0a\x09\x09\x09\x09\x09\
horizontalAlignm\
ent: Text.AlignL\
eft\x0a\x09\x09\x09\x09\x09font.po\
intSize: 14\x0a\x09\x09\x09\x09\
}\x0a\x0a\x09\x09\x09\x09Label {\x0a\x09\
\x09\x09\x09\x09id: label1\x0a\x09\
\x09\x09\x09\x09opacity: 0.8\
\x0a\x09\x09\x09\x09\x09text: qsTr\
(\x22Create Server\x22\
)\x0a\x09\x09\x09\x09}\x0a\x09\x09\x09}\x0a\x0a\x09\x09\
\x09Label {\x0a\x09\x09\x09\x09tex\
t: helper.hostna\
me()\x0a\x09\x09\x09\x09Layout.\
alignment: Qt.Al\
ignRight | Qt.Al\
ignVCenter\x0a\x09\x09\x09\x09f\
ont.pointSize: 1\
2\x0a\x09\x09\x09}\x0a\x09\x09}\x0a\x0a\x09\x09Co\
lumn {\x0a\x09\x09\x09id: co\
lumn2\x0a\x09\x09\x09width: \
parent.width\x0a\x09\x09\x09\
spacing: 2\x0a\x0a\x09\x09\x09I\
tem {\x0a\x09\x09\x09\x09id: it\
em1\x0a\x09\x09\x09\x09width: p\
arent.width\x0a\x09\x09\x09\x09\
height: 25\x0a\x0a\x09\x09\x09\x09\
Label {\x0a\x09\x09\x09\x09\x09id:\
 label2\x0a\x09\x09\x09\x09\x09tex\
t: qsTr(\x22passwor\
d\x22)\x0a\x09\x09\x09\x09\x09anchors\
.verticalCenter:\
 parent.vertical\
Center\x0a\x09\x09\x09\x09}\x0a\x0a\x09\x09\
\x09\x09Button {\x0a\x09\x09\x09\x09\x09\
id: button2\x0a\x09\x09\x09\x09\
\x09width: 60\x0a\x09\x09\x09\x09\x09\
height: parent.h\
eight\x0a\x09\x09\x09\x09\x09text:\
 qsTr(password_f\
ield.echoMode ==\
= TextInput.Pass\
word ? \x22show\x22 : \
\x22hide\x22)\x0a\x09\x09\x09\x09\x09anc\
hors.right: pare\
nt.right\x0a\x09\x09\x09\x09\x09fl\
at: true\x0a\x09\x09\x09\x09\x09an\
chors.rightMargi\
n: 0\x0a\x09\x09\x09\x09\x09onClic\
ked: {\x0a\x09\x09\x09\x09\x09\x09if \
(password_field.\
echoMode === Tex\
tInput.Password)\
\x0a\x09\x09\x09\x09\x09\x09\x09password\
_field.echoMode \
= TextInput.Norm\
al\x0a\x09\x09\x09\x09\x09\x09else\x0a\x09\x09\
\x09\x09\x09\x09\x09password_fi\
eld.echoMode = T\
extInput.Passwor\
d\x0a\x09\x09\x09\x09\x09}\x0a\x09\x09\x09\x09}\x0a\x09\
\x09\x09}\x0a\x0a\x09\x09\x09TextFiel\
d {\x0a\x09\x09\x09\x09id: pass\
word_field\x0a\x09\x09\x09\x09w\
idth: parent.wid\
th\x0a\x09\x09\x09\x09enabled: \
button1.enabled\x0a\
\x09\x09\x09\x09placeholderT\
ext: qsTr(\x22Passw\
ord...\x22)\x0a\x09\x09\x09\x09ech\
oMode: TextInput\
.Password\x0a\x09\x09\x09}\x0a\x09\
\x09}\x0a\x0a\x09\x09RowLayout \
{\x0a\x09\x09\x09id: row\x0a\x09\x09\x09\
width: parent.wi\
dth\x0a\x09\x09\x09spacing: \
5\x0a\x0a\x09\x09\x09Button {\x0a\x09\
\x09\x09\x09id: button\x0a\x09\x09\
\x09\x09enabled: butto\
n1.enabled\x0a\x09\x09\x09\x09t\
ext: qsTr(\x22Cance\
l\x22)\x0a\x09\x09\x09\x09Layout.f\
illWidth: false\x0a\
\x09\x09\x09\x09onClicked: m\
ainstack_.pop()\x0a\
\x09\x09\x09}\x0a\x0a\x09\x09\x09LoadBut\
ton {\x0a\x09\x09\x09\x09id: bu\
tton1\x0a\x09\x09\x09\x09text: \
qsTr(\x22Create\x22)\x0a\x09\
\x09\x09\x09Layout.fillWi\
dth: true\x0a\x0a\x09\x09\x09\x09o\
nClicked: {\x0a\x09\x09\x09\x09\
\x09enabled = false\
\x0a\x09\x09\x09\x09\x09if (statem\
anager_.createSe\
rver(password_fi\
eld.text)) {\x0a\x0a\x09\x09\
\x09\x09\x09\x09// wait for \
signal:statemana\
ger.onClientAuth\
Complete\x0a\x09\x09\x09\x09\x09} \
else {\x0a\x09\x09\x09\x09\x09\x09ena\
bled = true\x0a\x09\x09\x09\x09\
\x09}\x0a\x09\x09\x09\x09}\x0a\x0a\x09\x09\x09\x09Co\
nnections {\x0a\x09\x09\x09\x09\
\x09target: statema\
nager_\x0a\x09\x09\x09\x09\x09\x0a\x09\x09\x09\
\x09\x09function onHan\
dshakeDone(state\
) {\x0a\x09\x09\x09\x09\x09\x09button\
1.enabled = true\
\x0a\x09\x09\x09\x09\x09\x09if (state\
)\x0a\x09\x09\x09\x09\x09\x09\x09mainsta\
ck_.push(\x22./home\
.qml\x22)\x0a\x09\x09\x09\x09\x09}\x0a\x0a\x09\
\x09\x09\x09\x09function onR\
equireAuth() {\x0a\x09\
\x09\x09\x09\x09\x09client.auth\
enticate(passwor\
d_field.text)\x0a\x09\x09\
\x09\x09\x09}\x0a\x09\x09\x09\x09}\x0a\x09\x09\x09}\x0a\
\x09\x09}\x0a\x0a\x09\x09anchors.h\
orizontalCenter:\
 parent.horizont\
alCenter\x0a\x09}\x0a}\x0a\x0a/\
*##^##\x0aDesigner \
{\x0a\x09D{i:0;autoSiz\
e:true;formedito\
rZoom:0.9;height\
:480;width:640}\x0a\
}\x0a##^##*/\x0a\x0a\
\x00\x00\x01h\
i\
mport QtQuick 2.\
15\x0aimport QtQuic\
k.Controls 2.15\x0a\
import \x22./compon\
ents\x22\x0a\x0aApplicati\
onWindow {\x0a\x09id: \
application\x0a\x09vis\
ible: true\x0a\x09widt\
h: 600\x0a\x09height: \
450\x0a\x0a\x09readonly p\
roperty StateMan\
ager statemanage\
r: StateManager \
{}\x0a\x0a\x09StackView {\
\x0a\x09\x09id: mainstack\
\x0a\x09\x09anchors.fill:\
 parent\x0a\x09\x09initia\
lItem: \x22select_m\
ode.qml\x22\x0a\x09}\x0a}\x0a/*\
##^##\x0aDesigner {\
\x0a\x09D{i:0;formedit\
orZoom:0.9}\x0a}\x0a##\
^##*/\x0a\x0a\
\x00\x00\x07\x8a\
i\
mport QtQuick 2.\
15\x0aimport QtQuic\
k.Controls 2.5\x0ai\
mport QtQuick.La\
youts 1.3\x0a\x0aButto\
n {\x0a\x09id: root\x0a\x09p\
roperty color bu\
dColor: \x22#000000\
\x22\x0a\x09property int \
delay_interval: \
200\x0a\x0a\x09onEnabledC\
hanged: {\x0a\x09\x09if (\
enabled)\x0a\x09\x09\x09anim\
.stop()\x0a\x09\x09else\x0a\x09\
\x09\x09anim.restart()\
\x0a\x09}\x0a\x0a\x09RowLayout \
{\x0a\x09\x09anchors.cent\
erIn: parent\x0a\x09\x09s\
pacing: 4\x0a\x09\x09visi\
ble: !root.enabl\
ed\x0a\x0a\x09\x09Rectangle \
{\x0a\x09\x09\x09id: bud\x0a\x09\x09\x09\
radius: 2\x0a\x09\x09\x09Lay\
out.alignment: Q\
t.AlignHCenter |\
 Qt.AlignVCenter\
\x0a\x09\x09\x09Layout.prefe\
rredHeight: 4\x0a\x09\x09\
\x09Layout.preferre\
dWidth: 4\x0a\x09\x09\x09col\
or: budColor\x0a\x09\x09\x09\
opacity: 0\x0a\x09\x09}\x0a\x0a\
\x09\x09Rectangle {\x0a\x09\x09\
\x09id: bud_2\x0a\x09\x09\x09ra\
dius: 2\x0a\x09\x09\x09Layou\
t.alignment: Qt.\
AlignHCenter | Q\
t.AlignVCenter\x0a\x09\
\x09\x09Layout.preferr\
edHeight: 4\x0a\x09\x09\x09L\
ayout.preferredW\
idth: 4\x0a\x09\x09\x09color\
: budColor\x0a\x09\x09\x09op\
acity: 0\x0a\x09\x09}\x0a\x0a\x09\x09\
Rectangle {\x0a\x09\x09\x09i\
d: bud_3\x0a\x09\x09\x09radi\
us: 2\x0a\x09\x09\x09Layout.\
alignment: Qt.Al\
ignHCenter | Qt.\
AlignVCenter\x0a\x09\x09\x09\
Layout.preferred\
Height: 4\x0a\x09\x09\x09Lay\
out.preferredWid\
th: 4\x0a\x09\x09\x09color: \
budColor\x0a\x09\x09\x09opac\
ity: 1\x0a\x09\x09}\x0a\x09}\x0a\x0a\x09\
SequentialAnimat\
ion {\x0a\x09\x09id: anim\
\x0a\x09\x09loops: -1\x0a\x09\x09P\
arallelAnimation\
 {\x0a\x09\x09\x09NumberAnim\
ation {\x0a\x09\x09\x09\x09targ\
et: bud\x0a\x09\x09\x09\x09easi\
ng.type: Easing.\
InQuad\x0a\x09\x09\x09\x09prope\
rties: \x22opacity\x22\
\x0a\x09\x09\x09\x09duration: d\
elay_interval\x0a\x09\x09\
\x09\x09from: 0\x0a\x09\x09\x09\x09to\
: 1\x0a\x09\x09\x09}\x0a\x0a\x09\x09\x09Num\
berAnimation {\x0a\x09\
\x09\x09\x09target: bud_3\
\x0a\x09\x09\x09\x09property: \x22\
opacity\x22\x0a\x09\x09\x09\x09dur\
ation: delay_int\
erval\x0a\x09\x09\x09\x09easing\
.type: Easing.In\
Quad\x0a\x09\x09\x09\x09from: 1\
\x0a\x09\x09\x09\x09to: 0\x0a\x09\x09\x09}\x0a\
\x09\x09}\x0a\x09\x09ParallelAn\
imation {\x0a\x09\x09\x09Num\
berAnimation {\x0a\x09\
\x09\x09\x09target: bud_2\
\x0a\x09\x09\x09\x09easing.type\
: Easing.InQuad\x0a\
\x09\x09\x09\x09properties: \
\x22opacity\x22\x0a\x09\x09\x09\x09du\
ration: delay_in\
terval\x0a\x09\x09\x09\x09from:\
 0\x0a\x09\x09\x09\x09to: 1\x0a\x09\x09\x09\
}\x0a\x0a\x09\x09\x09NumberAnim\
ation {\x0a\x09\x09\x09\x09targ\
et: bud\x0a\x09\x09\x09\x09prop\
erty: \x22opacity\x22\x0a\
\x09\x09\x09\x09duration: de\
lay_interval\x0a\x09\x09\x09\
\x09easing.type: Ea\
sing.InQuad\x0a\x09\x09\x09\x09\
from: 1\x0a\x09\x09\x09\x09to: \
0\x0a\x09\x09\x09}\x0a\x09\x09}\x0a\x09\x09Par\
allelAnimation {\
\x0a\x09\x09\x09NumberAnimat\
ion {\x0a\x09\x09\x09\x09target\
: bud_3\x0a\x09\x09\x09\x09easi\
ng.type: Easing.\
InQuad\x0a\x09\x09\x09\x09prope\
rties: \x22opacity\x22\
\x0a\x09\x09\x09\x09duration: d\
elay_interval\x0a\x09\x09\
\x09\x09from: 0\x0a\x09\x09\x09\x09to\
: 1\x0a\x09\x09\x09}\x0a\x0a\x09\x09\x09Num\
berAnimation {\x0a\x09\
\x09\x09\x09target: bud_2\
\x0a\x09\x09\x09\x09property: \x22\
opacity\x22\x0a\x09\x09\x09\x09dur\
ation: delay_int\
erval\x0a\x09\x09\x09\x09easing\
.type: Easing.In\
Quad\x0a\x09\x09\x09\x09from: 1\
\x0a\x09\x09\x09\x09to: 0\x0a\x09\x09\x09}\x0a\
\x09\x09}\x0a\x09}\x0a}\x0a\
\x00\x00\x056\
i\
mport QtQuick 2.\
15\x0a\x0aQtObject {\x0a\x09\
id: root\x0a\x09proper\
ty bool waitingF\
orAuth: false\x0a\x09r\
eadonly property\
 ListModel peerm\
odel: ListModel \
{}\x0a\x09readonly pro\
perty ListModel \
chatmodel: ListM\
odel {}\x0a\x0a\x09signal\
 requireAuth\x0a\x09si\
gnal handshakeDo\
ne(bool successf\
ul)\x0a\x0a\x09function c\
reateServer(pass\
word) {\x0a\x09\x09server\
.set_password(pa\
ssword)\x0a\x09\x09if (se\
rver.run()) {\x0a\x09\x09\
\x09// create clien\
t\x0a\x09\x09\x09client.conn\
ect_to(\x22:self\x22)\x0a\
\x0a\x09\x09\x09if (password\
.length > 0) {\x0a\x09\
\x09\x09\x09waitingForAut\
h = true\x0a\x09\x09\x09} el\
se {\x0a\x09\x09\x09\x09handsha\
keDone(true)\x0a\x09\x09\x09\
}\x0a\x09\x09\x09return true\
\x0a\x09\x09} else {\x0a\x09\x09\x09r\
eturn false\x0a\x09\x09}\x0a\
\x09}\x0a\x0a\x09function co\
nnectToServer(ho\
stname) {\x0a\x09\x09clie\
nt.connect_to(ho\
stname)\x0a\x09\x09waitin\
gForAuth = true\x0a\
\x09}\x0a\x0a\x09readonly pr\
operty list<Conn\
ections> connect\
ions: [\x0a\x09\x09Connec\
tions {\x0a\x09\x09\x09targe\
t: client\x0a\x0a\x09\x09\x09fu\
nction onHandsha\
keReceived(messa\
ge) {\x0a\x09\x09\x09\x09if (ro\
ot.waitingForAut\
h) {\x0a\x09\x09\x09\x09\x09if (me\
ssage.body === \x22\
$auth\x22) {\x0a\x09\x09\x09\x09\x09\x09\
requireAuth()\x0a\x09\x09\
\x09\x09\x09} else if (me\
ssage.body === \x22\
$successfull\x22\x0a\x09\x09\
\x09\x09\x09\x09\x09   || messa\
ge.body === \x22$no\
-auth\x22) {\x0a\x09\x09\x09\x09\x09\x09\
root.waitingForA\
uth = false\x0a\x09\x09\x09\x09\
\x09\x09handshakeDone(\
true)\x0a\x09\x09\x09\x09\x09} els\
e {\x0a\x09\x09\x09\x09\x09\x09handsh\
akeDone(false)\x0a\x09\
\x09\x09\x09\x09}\x0a\x09\x09\x09\x09}\x0a\x09\x09\x09}\
\x0a\x0a\x09\x09\x09function on\
NewPeerJoined(me\
ssage) {\x0a\x09\x09\x09\x09con\
st peer = messag\
e.body\x0a\x09\x09\x09\x09peerm\
odel.append(peer\
)\x0a\x09\x09\x09}\x0a\x0a\x09\x09\x09funct\
ion onContactLis\
tRecieved(messag\
e) {\x0a\x09\x09\x09\x09const c\
ontact_list = me\
ssage.body\x0a\x09\x09\x09\x09c\
ontact_list.forE\
ach(function(pee\
r){\x0a\x09\x09\x09\x09\x09peermod\
el.append(peer)\x0a\
\x09\x09\x09\x09})\x0a\x09\x09\x09}\x0a\x09\x09}\x0a\
\x09]\x0a}\x0a\
\x00\x00\x07\x92\
i\
mport QtQuick 2.\
15\x0aimport QtQuic\
k.Controls 2.15\x0a\
import QtQuick.L\
ayouts 1.11\x0a\x0aPag\
e {\x0a\x09id: root\x0a\x09p\
roperty string n\
ame: \x22{no-name}\x22\
\x0a\x0a\x09ColumnLayout \
{\x0a\x09\x09anchors.fill\
: parent\x0a\x09\x09ancho\
rs.topMargin: 5\x0a\
\x09\x09spacing: 0\x0a\x0a\x09\x09\
Rectangle {\x0a\x09\x09\x09h\
eight: 40\x0a\x09\x09\x09Lay\
out.alignment: Q\
t.AlignLeft | Qt\
.AlignTop\x0a\x09\x09\x09Lay\
out.fillWidth: t\
rue\x0a\x0a\x09\x09\x09Label {\x0a\
\x09\x09\x09\x09width: 372\x0a\x09\
\x09\x09\x09height: 11\x0a\x09\x09\
\x09\x09font.pixelSize\
: 12\x0a\x09\x09\x09\x09text: q\
sTr(\x22Hostname\x22)\x0a\
\x09\x09\x09\x09anchors.vert\
icalCenter: pare\
nt.verticalCente\
r\x0a\x09\x09\x09}\x0a\x09\x09}\x0a\x0a\x09\x09Sc\
rollView {\x0a\x09\x09\x09wi\
dth: 200\x0a\x09\x09\x09heig\
ht: 200\x0a\x09\x09\x09Layou\
t.fillHeight: tr\
ue\x0a\x09\x09\x09Layout.fil\
lWidth: true\x0a\x09\x09\x09\
Layout.alignment\
: Qt.AlignLeft |\
 Qt.AlignTop\x0a\x09\x09\x09\
ScrollBar.horizo\
ntal.policy: Scr\
ollBar.AlwaysOff\
\x0a\x09\x09\x09ScrollBar.ve\
rtical.policy: S\
crollBar.AsNeede\
d\x0a\x0a\x09\x09\x09ListView {\
\x0a\x09\x09\x09\x09id: listVie\
w\x0a\x09\x09\x09\x09width: 110\
\x0a\x09\x09\x09\x09height: 160\
\x0a\x09\x09\x09\x09clip: true\x0a\
\x09\x09\x09\x09delegate: It\
em {\x0a\x09\x09\x09\x09\x09x: 5\x0a\x09\
\x09\x09\x09\x09width: 80\x0a\x09\x09\
\x09\x09\x09height: 40\x0a\x09\x09\
\x09\x09\x09Row {\x0a\x09\x09\x09\x09\x09\x09i\
d: row1\x0a\x09\x09\x09\x09\x09\x09sp\
acing: 10\x0a\x09\x09\x09\x09\x09\x09\
Rectangle {\x0a\x09\x09\x09\x09\
\x09\x09\x09width: 40\x0a\x09\x09\x09\
\x09\x09\x09\x09height: 40\x0a\x09\
\x09\x09\x09\x09\x09\x09color: col\
orCode\x0a\x09\x09\x09\x09\x09\x09}\x0a\x0a\
\x09\x09\x09\x09\x09\x09Text {\x0a\x09\x09\x09\
\x09\x09\x09\x09text: name\x0a\x09\
\x09\x09\x09\x09\x09\x09anchors.ve\
rticalCenter: pa\
rent.verticalCen\
ter\x0a\x09\x09\x09\x09\x09\x09\x09font.\
bold: true\x0a\x09\x09\x09\x09\x09\
\x09}\x0a\x09\x09\x09\x09\x09}\x0a\x09\x09\x09\x09}\x0a\
\x09\x09\x09\x09model: ListM\
odel {\x0a\x09\x09\x09\x09\x09List\
Element {\x0a\x09\x09\x09\x09\x09\x09\
name: \x22Grey\x22\x0a\x09\x09\x09\
\x09\x09\x09colorCode: \x22g\
rey\x22\x0a\x09\x09\x09\x09\x09}\x0a\x0a\x09\x09\x09\
\x09\x09ListElement {\x0a\
\x09\x09\x09\x09\x09\x09name: \x22Red\
\x22\x0a\x09\x09\x09\x09\x09\x09colorCod\
e: \x22red\x22\x0a\x09\x09\x09\x09\x09}\x0a\
\x0a\x09\x09\x09\x09\x09ListElemen\
t {\x0a\x09\x09\x09\x09\x09\x09name: \
\x22Blue\x22\x0a\x09\x09\x09\x09\x09\x09col\
orCode: \x22blue\x22\x0a\x09\
\x09\x09\x09\x09}\x0a\x0a\x09\x09\x09\x09\x09List\
Element {\x0a\x09\x09\x09\x09\x09\x09\
name: \x22Green\x22\x0a\x09\x09\
\x09\x09\x09\x09colorCode: \x22\
green\x22\x0a\x09\x09\x09\x09\x09}\x0a\x09\x09\
\x09\x09}\x0a\x09\x09\x09}\x0a\x09\x09}\x0a\x0a\x09\x09\
Rectangle {\x0a\x09\x09\x09w\
idth: 200\x0a\x09\x09\x09hei\
ght: 50\x0a\x09\x09\x09color\
: \x22#00000000\x22\x0a\x09\x09\
\x09Layout.fillWidt\
h: true\x0a\x0a\x09\x09\x09Rect\
angle {\x0a\x09\x09\x09\x09colo\
r: \x22#f6f6f6\x22\x0a\x09\x09\x09\
\x09anchors.fill: p\
arent\x0a\x09\x09\x09\x09anchor\
s.margins: 5\x0a\x0a\x09\x09\
\x09\x09RowLayout {\x0a\x09\x09\
\x09\x09\x09anchors.fill:\
 parent\x0a\x0a\x09\x09\x09\x09\x09Te\
xtField {\x0a\x09\x09\x09\x09\x09\x09\
id: textField\x0a\x09\x09\
\x09\x09\x09\x09Layout.fillW\
idth: true\x0a\x09\x09\x09\x09\x09\
\x09placeholderText\
: qsTr(\x22Text Fie\
ld\x22)\x0a\x09\x09\x09\x09\x09}\x0a\x0a\x09\x09\x09\
\x09\x09Button {\x0a\x09\x09\x09\x09\x09\
\x09id: button\x0a\x09\x09\x09\x09\
\x09\x09text: qsTr(\x22se\
nd file\x22)\x0a\x09\x09\x09\x09\x09}\
\x0a\x09\x09\x09\x09}\x0a\x09\x09\x09}\x0a\x09\x09}\x0a\
\x09}\x0a}\x0a\x0a/*##^##\x0aDe\
signer {\x0a\x09D{i:0;\
autoSize:true;he\
ight:480;width:6\
40}D{i:7}D{i:6}D\
{i:1}\x0a}\x0a##^##*/\x0a\
\x0a\
"

qt_resource_name = b"\
\x00\x03\
\x00\x00|\x08\
\x00u\
\x00i\x00x\
\x00\x08\
\x068]\xdc\
\x00h\
\x00o\x00m\x00e\x00.\x00q\x00m\x00l\
\x00\x0f\
\x0cI\xac\x9c\
\x00j\
\x00o\x00i\x00n\x00_\x00s\x00e\x00r\x00v\x00e\x00r\x00.\x00q\x00m\x00l\
\x00\x0f\
\x00\xd5g\xbc\
\x00s\
\x00e\x00l\x00e\x00c\x00t\x00_\x00m\x00o\x00d\x00e\x00.\x00q\x00m\x00l\
\x00\x11\
\x08\x02C<\
\x00c\
\x00r\x00e\x00a\x00t\x00e\x00_\x00s\x00e\x00r\x00v\x00e\x00r\x00.\x00q\x00m\x00l\
\
\x00\x0a\
\x07j\x093\
\x00c\
\x00o\x00m\x00p\x00o\x00n\x00e\x00n\x00t\x00s\
\x00\x08\
\x08\x01Z\x5c\
\x00m\
\x00a\x00i\x00n\x00.\x00q\x00m\x00l\
\x00\x0e\
\x01\xd0}\x9c\
\x00L\
\x00o\x00a\x00d\x00B\x00u\x00t\x00t\x00o\x00n\x00.\x00q\x00m\x00l\
\x00\x10\
\x08\x95\xf6\xfc\
\x00S\
\x00t\x00a\x00t\x00e\x00M\x00a\x00n\x00a\x00g\x00e\x00r\x00.\x00q\x00m\x00l\
\x00\x0c\
\x0e\xedF\xfc\
\x00C\
\x00h\x00a\x00t\x00P\x00a\x00g\x00e\x00.\x00q\x00m\x00l\
"

qt_resource_struct = b"\
\x00\x00\x00\x00\x00\x02\x00\x00\x00\x01\x00\x00\x00\x01\
\x00\x00\x00\x00\x00\x00\x00\x00\
\x00\x00\x00\x00\x00\x02\x00\x00\x00\x06\x00\x00\x00\x02\
\x00\x00\x00\x00\x00\x00\x00\x00\
\x00\x00\x00F\x00\x00\x00\x00\x00\x01\x00\x00\x14\x1a\
\x00\x00\x01zQ\xcb\x87\xf3\
\x00\x00\x00\x0c\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\
\x00\x00\x01zR\x0c\xe1\xac\
\x00\x00\x00\x92\x00\x02\x00\x00\x00\x03\x00\x00\x00\x08\
\x00\x00\x00\x00\x00\x00\x00\x00\
\x00\x00\x00\xac\x00\x00\x00\x00\x00\x01\x00\x00\x22\xa1\
\x00\x00\x01zQ\x9f0\x08\
\x00\x00\x00j\x00\x00\x00\x00\x00\x01\x00\x00\x18\x81\
\x00\x00\x01zQ\xe1u\x1e\
\x00\x00\x00\x22\x00\x00\x00\x00\x00\x01\x00\x00\x09\x99\
\x00\x00\x01zQ\xe3\x92\xb5\
\x00\x00\x00\xc2\x00\x00\x00\x00\x00\x01\x00\x00$\x0d\
\x00\x00\x01zP\xe4I\xe1\
\x00\x00\x00\xe4\x00\x00\x00\x00\x00\x01\x00\x00+\x9b\
\x00\x00\x01zR\x07\x86W\
\x00\x00\x01\x0a\x00\x00\x00\x00\x00\x01\x00\x000\xd5\
\x00\x00\x01zQE\xdbT\
"

def qInitResources():
    QtCore.qRegisterResourceData(0x03, qt_resource_struct, qt_resource_name, qt_resource_data)

def qCleanupResources():
    QtCore.qUnregisterResourceData(0x03, qt_resource_struct, qt_resource_name, qt_resource_data)

qInitResources()
