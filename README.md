# desktop-app-liminal
A Pankosmia App

## Ecosystem setup and configuration
This repo pulls together several libraries and projects into a single app. The projects are spread across several repos to allow modular reuse. Scripts follow for assisting in setup, though it can also all be setup manually. The following assume [the repos](https://github.com/pankosmia/repositories) are installed with the following directory structure.

This is an example. Clients in use may vary.  (See also the Configuration section under Scripts, towards the bottom.)

```
|-- repos
    |-- pankosmia
        |-- core-client-content repository
        |-- core-client-dashboard repository
        |-- core-client-i18n-editor repository
        |-- core-client-remote-repos repository
        |-- core-client-settings repository
        |-- core-client-workspace repository
        |-- desktop-app-liminal
        |-- resource-core
        |-- webfonts-core
```

## Installing the clients
The local_server (pankosmia_web) serves compiled files from the `build` directory of each client, each client must be built. Scripts follow for assisting in setup, though it can also all be setup manually:
```
# In each client repo, NOT this repo!
npm install
npm run build
```

## Environment requirements for this repo (desktop-app-liminal)

Tested on:
| Ubuntu 24.04 with: | Windows 11 with: | MacOS with: |
|-------|---------|-------|
|- npm 9.2.0<br />- node 18.19.1<br />- rustc 1.83.0 -- `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \| sh` | - npm 10.7.0<br />- node 18.20.4<br />- rustc 1.83.0 -- See https://www.rust-lang.org/tools/install<br />- cmake 3.31.0 -- Version 3 is required. See https://cmake.org/download/ | - npm 10.7.0 (tested on Monterey)<br />- npm 10.8.2 (tested on Sequoia)<br />- node 18.20.4<br />- rustc 1.86.0 -- `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \| sh`<br />- OpenSSL 3.5.0 -- brew install openssl |

## Installing the server / builder (back to _this_ repo -- desktop-app-liminal)
Scripts follow, though it can also be setup manually:<br />
**This is at the root of this repo:**
```text
npm install
```

## Running the server in dev mode
Scripts follow, though it can also be run manually:

| Linux | Windows | MacOS |
|-------|---------|-------|
| <pre>cd linux/scripts<br />./build_and_run.bsh</pre> | <pre>cd windows/scripts<br />.\build_and_run.bat</pre> | <pre>cd macos/scripts<br />chmod +x build_and_run.zsh<br />./build_and_run.zsh |

## Building for release
See the Configuration section under Scripts, towards the bottom. Once configured, it can also be built manually:

1. cd local_server
2. cargo clean
3. Run the server in dev mode.
4. Stop the server (optional)
5. Then proceed below.

| Linux | Windows | MacOS |
|-------|---------|-------|
| <pre>cd linux/scripts<br />node build.js</pre> | <pre>cd windows/scripts<br />node build.js</pre> | <pre>cd macos/scripts<br />node build.js</pre> |

## Bundling
See the Configuration section under Scripts, towards the bottom. Once configured, it can also be bundled manually:

| Linux | Windows | MacOS |
|-------|---------|-------|
| tgz:<br />`cd ../build`<br />`tar cfz ../../releases/linux/liminal-linux.tgz .` | exe, in powershell :<br />1. Install [Inno Setup](https://jrsoftware.org/isdl.php) -tested with v6.4.3<br />2. In powershell, enter the following where where 0.2.7 is the new version number:<br />`cd ../install<br />$env:APP_VERSION = "0.2.7"`<br />`.\makeInstall.bat` | zip:<br />`cd ../build`<br />`chmod 755 liminal.zsh`<br />`zip -r ../../releases/macos/liminal-macos.zip *` |
| &nbsp; | Or, for zip, in powershell:<br />`cd ../build`<br />`Compress-Archive * ../../releases/windows/liminal-windows.zip`<br />(Delete /releases/windows/liminal-windows.zip first, if it already exists.) | &nbsp; |

## Scripts

### Configuration

Config files must match clients and assets utilized. Scripts that write them are provided, or you can adjust them manually. The configuration files are:

| Linux | Windows | MacOS |
|-------|---------|-------|
| <pre>buildSpec.json<br />/globalBuildResources/i18nPatch.json<br />/linux/buildResources/setup/app_setup.json</pre> | <pre>buildSpec.json<br />/globalBuildResources/i18nPatch.json<br />/windows/buildResources/setup/app_setup.json</pre> | <pre>buildSpec.json<br />/globalBuildResources/i18nPatch.json<br />/macos/buildResources/setup/app_setup.json</pre> 

To setup config files using one of the scripts that follow, first update the following 4 text files with no empty rows:
- /app_name.txt:
  - Enter the app name on row 1
- /app_version.txt:
  - Enter the version number on row 1
- /app_assets.txt:
  - Enter three rows for each asset repo, in the following order: 1. repo, 2. targetPath, 3. targetName.
  - Keep repos with multiple assets together, listing the repos separately for each asset.
- /app_clients.txt:
  - One repo per row where included in the menu.
  - To exclude from the menu, add a comma after the repo, then on the next line enter: `exclude_from_menu: true`


#### Config scripts:
Run from the provided location:
| Description | Linux | Windows | MacOS |
|-------------|-------|---------|-------|
| Uses app_name.txt, app_version.txt, app_assets.txt, and app_clients.txt to generate/rebuild/replace app_setup.json, buildSpec.json, and i18nPatch.json| | `/windows/scripts/app_setup.bat` | |

#### Setup scripts:
Run from the provided location:
| Description | Linux | Windows | MacOS |
|-------|-------|---------|-------|
| Clones all repos listed in `/app_assets.txt` and `/app_clients.txt` if a directly by that name does not already exit | | /windows/scripts/clone.bat | |
| For each repo listed in `/app_assets.txt`: git checkout main, git pull<br />For each repo listed in  `/app_clients.txt`: `git checkout main`, `git pull`, `npm install`, and `npm run build`.<br />***Dev's should build manually when testing branch(es).*** | | /windows/scripts/build_clients | |

#### Usage scripts:

| Description | Linux | Windows | MacOS |
|-------|-------|---------|-------|
| removes the build directory and runs `cargo clean` | | /windows/scripts/clean.bat | |
| runs cargo build and `node build.js` | | /windows/scripts/build_server.bat | |
| starts the server | | /windows/scripts/run.bat | |
| starts the server and launches a browser | | /windows/scripts/open.bat | |
| on this repo runs `git checkout main`, `git pull`, and `npm install`, runs `node build.js`, then makes an exe installer | | /windows/scripts/bundle_exe.ps1 | |
| Deletes the last .zip release bundle if it it exists, on this repo runs `git checkout main`, `git pull`, and `npm install`, runs `node build.js`, then makes a zip release bundle | | /windows/scripts/bundle_zip.ps1 | |