# Courier

![courier cover](images/cover.png)

Courier is desktop aplication witten in [Python](https://python.org/) and [Qt](https://qt.io/) for data transfer between machines connected to the same network. You can see the Ui design [here](https://www.figma.com/file/YilWzyYLOJDPxSjy4xw1Oq/Courier) The connection uses WebSockets to send text and binary data.

WebSockets is a web technology providing full-duplex communications channels over a single TCP connection. The WebSocket protocol was standardized by the IETF as [RFC 6455](http://tools.ietf.org/html/rfc6455) in 2011.

## Running Courier

running the follwing lines will `setup your virtual env`*, install the neccessary packages, compile qrc file and then run the script.

### Linux

```bash
. build.sh
```

if you are running powershell on linux you can run the following line.

```bash
pwsh ./build.sh
```

`Tip: installing powershell on linux (Fedora 33)`

```bash
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo
sudo yum install -y powershell

# the powershel command should now be available.
pwsh
```

### Windows (Powershell)

```ps
./build.ps1
```

## Building Courier

to create executables for courrier, pass a `--package` argument.

### Linux Build

```bash
. build.sh --package
```

### Windows Build

```ps
./build.ps1 --package
```

## Issues
- message queuing is not perfect because the previous message isn't really triggered after the first one is sent
- ui still freezes transferring large files.