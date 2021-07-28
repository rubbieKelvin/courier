# rubbie kelvin

main(){
	# did we just create this virtual env
	local newvenv=0

	# setup environment
	echo "🎭 setting up virtual environment..."

	if [[ -d venv ]]; then
		echo "⚡ found existing venv folder."
		echo "⚡ activating virtual environment"
		source venv/bin/activate
	else
		echo "👀 creating virtual environment..."
		if python -m venv venv; then
			newvenv=1
			echo "*" > venv/.gitignore
			echo "⚡ activating virtual environment"
			source venv/bin/activate
		else
			echo "❌ coundn't create virtual envionment"
			return
		fi
	fi

	if [[ "$newvenv" -eq 1 ]]; then
		echo "👀 installing neccessary packages"
		if python -m pip install -r requirements.txt; then
			echo "" > /dev/null
		else
			echo "❌ couldnt install packages"
			return
		fi
	else
		echo "💬 skipping package install..."
		echo "💬 if you have any 'module not found' issue, run 'pip install -r requirements.txt'"
	fi
	
	# check for ".qrc" file in workspace folder
	# if there's a .qrc file... compile it into a python file

	# script to compile .qrc
	if [[ -f .qrc ]]; then
		echo "👀 compiling .qrc to python file..."
		if pyside2-rcc \
			--compress-algo zlib \
			-g python \
			.qrc -o qrc.py > /dev/null; then
			echo "✅ compiled .qrc -> qrc.py"
		else
			echo "❌ couldnt compile .qrc"
			return 1
		fi
	else
		echo "❌ no .qrc file."
		return 1
	fi

	# build executable
	if [[ "$1" = "--package" ]]; then
		echo "👀 cleaning up..."

		if [[ -d dist ]]; then rm -r dist > /dev/null; fi
		if [[ -d build ]]; then rm -r build > /dev/null; fi

		# optimize python scripts by removing all docstrings
		# assert statements are also removed from byte codes
		# this is an attempt to reduce bundle size along size --onefile in pyinstaller options
		export PYTHONOPTIMIZE=1

		echo "👀 building executable... might take a while"
		# enable --key=key(16 chars) option for byte-code encryption: requires tinyaes and pycrypto
		if pyinstaller \
			--windowed \
			-n Courier \
			--clean \
			--onefile \
			--log-level=CRITICAL \
			main.py > /dev/null; then

			# remove spec file
			rm *.spec

			# move executables to build
			rm -r build
			cp -r dist/ build
			rm -r dist/

			echo "✅ built executable. at build/"
		else
			echo "❌ couldnt build executable..."
			return 1
		fi
	fi


	# run result if not building
	if [[ -z "$1" ]]; then
		echo "👀 running python script..."
		python main.py
	fi
}

# run main
main $1
# close venv
deactivate