# desktop-app-liminal
A Pankosmia App

## Ecosystem setup and configuration
This repo pulls together several libraries and projects into a single app. The projects are spread across several repos to allow modular reuse. The sanest way to get this working is to install [the repos](https://github.com/pankosmia/repositories) with the following structure:

```
pankosmia
-- webfonts-core
-- resources-core
-- desktop-app-liminal
-- core-client-dashboard repository
-- core-client-settings repository
-- core-client-workspace repository
-- core-client-content repository
-- core-client-remote-repos repository
-- core-client-i18n-editor repository
```

*It Should Just Work* if your pankosmia directory is under `repos` under your user directory, ie `/home/myname/repos/pankosmia` in Linux.

The local_server (pankosmia_web) serves compiled files from the `build` directory of each client, so you need to build each client:
```
# In each client repo, NOT this repo!
npm install
npm run build
```

## Installing the builder (back to _this_ repo -- desktop-app-liminal)
**This is at the root of the repo**
```text
npm install
```

## Environment requirements for this repo (desktop-app-liminal)

### Tested on Ubuntu 24.04 with:
- npm 9.2.0
- node 18.19.1
- rustc 1.83.0 -- curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

### Tested on Windows 11 with:
- npm 10.7.0
- node 18.20.4
- rustc 1.83.0 -- See https://www.rust-lang.org/tools/install
- cmake 3.31.0 -- Version 3 is required. See https://cmake.org/download/

### Tested on MacOS with:
- npm 10.7.0 (tested on Monterey)
- npm 10.8.2 (tested on Sequoia)
- node 18.20.4
- rustc 1.86.0 -- curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
- OpenSSL 3.5.0 -- brew install openssl

## Running the server in dev mode
Linux:
```text
cd linux/scripts
./build_and_run.bsh
```
(may need chmod +x build_and_run.bsh)

Windows:
```text
cd windows/scripts
.\build_and_run.bat
```
MacOS:
```text
cd macos/scripts
./build_and_run.zsh
```

## Building for release)

1. Delete the contents of local_server/target/release
2. Run the server in dev mode.
3. Stop the server (optional)
4. Then proceed below.

Linux:
```text
cd linux/scripts
node build.js
```
Windows:
```text
cd windows/scripts
node build.js
```
MacOS:
```text
cd macos/scripts
node build.js
```
## Bundling
You can bundle up the built project with the following incantation:

Linux (tgz):
```text
cd ../build
tar cfz ../../releases/linux/liminal-linux.tgz .
```

MacOS (zip):
```text
cd ../build
chmod 755 liminal.zsh
zip -r ../../releases/macos/liminal-macos.zip *
```
Windows Powershell (exe):
1. Install [Inno Setup](https://jrsoftware.org/isdl.php) -tested with v6.4.3
2. In powershell, enter the following where where 0.2.7 is the new version number:
```text
cd ../install
$env:APP_VERSION = "0.2.7"
.\makeInstall.bat
```

Or, if you really want a windows zip file -- Windows Powershell (zip):
```text
cd ../build
Compress-Archive * ../../releases/windows/liminal-windows.zip
```
(Delete /releases/windows/liminal-windows.zip first, if it already exists.)
