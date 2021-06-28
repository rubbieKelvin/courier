# check for "resource.qrc" file in workspace folder
# if there's a resource.qrc file... compile it into a python file

if [[ -f resource.qrc ]]; then
	pyside2-rcc resource.qrc -o resource.py
	python main.py
else
	echo "no resource.qrc file."
fi