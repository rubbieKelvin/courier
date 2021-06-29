# rubbie kelvin

main(){
	# check for ".qrc" file in workspace folder
	# if there's a .qrc file... compile it into a python file

	# script to compile .qrc
	if [[ -f .qrc ]]; then
		echo "👀 compiling .qrc to python file..."
		if pyside2-rcc \
			--compress-algo none \
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

		rm -r dist > /dev/null
		rm -r build > /dev/null

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

			# move executables to build
			rm -r build
			cp -r dist/ build
			rm -r dist/

			echo "✅ built executable. at build/Courier"
		else
			echo "❌ couldnt build executable..."
			return 1
		fi
	fi


	# run result
	if [[ -z "$1" ]]; then
		echo "👀 running python script..."
		python main.py > runtime.log
	else
		echo "👀 running executable..."
		if ./build/Courier > runtime.build.log; then
			echo "🎉 app ran succesfully!"
		else
			echo "😭 there was a problem while running app"
		fi
	fi
}

# run main
main $1