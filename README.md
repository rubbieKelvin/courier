# Courier
corrier is simple desktop aplication for sending files and messages between computers using your Local WiFi or Internet Connection.

# Running Courier
running the follwing lines will `setup your virtual env`*, install the neccessary packages, compile qrc file and then run the script.
## Linux
```bash
. build.sh
```
if you are running powershell on linux you can run the following line.
```bash
pwsh ./build.sh
```
### Tip: installing powershell on linux (Fedora 33)
```bash
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo
sudo yum install -y powershell

# the powershel command should now be available.
pwsh
```
## Windows (Powershell)
```ps
./build.ps1
```
# Building Courier
to create executables for courrier, pass a `--package` argument. 
## Linux
```bash
. build.sh --package
```
## Windows (Powershell)
```ps
./build.ps1 --package
```
