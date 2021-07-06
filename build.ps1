# rubbie kelvin
# NEED HELP FROM WINDOWS USERS

function Main($package) {
	Write-Host "🎭 setting up virtual environment..."

	if (Test-Path -Path ./venv){
		Write-Host "⚡ found existing venv folder."
		Write-Host "⚡ activating virtual environment"
		
		pwsh -File ./venv/bin/Activate.ps1 > $null
		if (-Not $?){
			pwsh.exe -File ./venv/bin/Activate.ps1
		}
	}else{
		Write-Host "👀 creating virtual environment..."
		if (python -m venv venv){

			# DEBUG: this line might not work on windows
			Write-Output "*" > venv/.gitignore

			Write-Host "⚡ activating virtual environment"
			
			#TODO: fix activate path
			pwsh -File ./venv/bin/Activate.ps1 > $null
			if (-Not $?){
				pwsh.exe -File ./venv/bin/Activate.ps1
			}
		}else{
			Write-Host "❌ coundn't create virtual envionment"
			return
		}
	}

	Write-Host "👀 installing neccessary packages"
	if (python -m pip install -r ./requirements.txt){
		Write-Host "" > $null
	}else{
		Write-Host "❌ couldnt install packages"
		return
	}

	# check for ".qrc" file in workspace folder
	# if there's a .qrc file... compile it into a python file

	# script to compile .qrc
	if (Test-Path -Path ./.qrc){
		Write-Host "👀 compiling .qrc to python file..."
		pyside2-rcc --compress-algo zlib -g python ./.qrc -o ./qrc.py > $null
		
		if ($?){
			Write-Host "✅ compiled .qrc -> qrc.py"
		}else{
			Write-Host "❌ couldnt compile .qrc"
			return $false
		}
	}else {
		Write-Host "❌ no .qrc file."
		return $false
	}

	# build executable
	if ($package -eq "--package"){
		Write-Host "👀 cleaning up..."

		if (Test-Path -Path ./dist){
			Remove-Item ./dist -Recurse
		}

		if (Test-Path -Path ./build){
			Remove-Item ./build -Recurse
		}

		# optimize python scripts by removing all docstrings
		# assert statements are also removed from byte codes
		# this is an attempt to reduce bundle size along size --onefile in pyinstaller options
		$env:PYTHONOPTIMIZE = 1

		Write-Host "👀 building executable... might take a while"
		pyinstaller --windowed -n Courier --clean --onefile --log-level=CRITICAL ./main.py > $null
		
		if ($?){
			Remove-Item *.spec

			Remove-Item ./build -Recurse
			Copy-Item ./dist -Destination ./build -Recurse
			Remove-Item ./dist -Recurse

			Write-Host "✅ built executable. at build/"
		}else{
			Write-Host "❌ couldnt build executable..."
			return $false
		}
	}

	if (-Not $package){
		Write-Host "👀 running python script..."
		python ./main.py
	}
	# return $true
}

Main $args[0]