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
## Updating the server to the latest version of pankosmia-web
- [Latest version](https://docs.rs/pankosmia_web/latest/pankosmia_web/)
- Update in `/local_server/Cargo.toml`

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
| tgz:<br />`cd ../build`<br />`tar cfz ../../releases/linux/liminal-linux.tgz .` | exe, in powershell :<br />1. Install [Inno Setup](https://jrsoftware.org/isdl.php) -tested with v6.4.3<br />2. In powershell, enter the following where where 0.2.7 is the new version number:<br />`cd ../install`<br />`$env:APP_VERSION = "0.2.7"`<br />`.\makeInstall.bat` | zip:<br />`cd ../build`<br />`zip -r ../../releases/macos/liminal-macos.zip *` |
| &nbsp; | Or, for zip, in powershell:<br />`cd ../build`<br />`Compress-Archive * ../../releases/windows/liminal-windows.zip`<br />(Delete /releases/windows/liminal-windows.zip first, if it already exists.) | &nbsp; |

## Scripts

### Configuration

Config files must match clients and assets utilized. Scripts that write them are provided, or you can adjust them manually. The configuration files are:

| Linux | Windows | MacOS |
|-------|---------|-------|
| <pre>buildSpec.json<br />/globalBuildResources/i18nPatch.json<br />/globalBuildResources/theme.json<br />/linux/buildResources/setup/app_setup.json</pre> | <pre>buildSpec.json<br />/globalBuildResources/i18nPatch.json<br />/globalBuildResources/theme.json<br />/windows/buildResources/setup/app_setup.json</pre> | <pre>buildSpec.json<br />/globalBuildResources/i18nPatch.json<br />/globalBuildResources/theme.json<br />/macos/buildResources/setup/app_setup.json</pre> 

To setup config files using one of the scripts that follow, first update `app_config.env`.

#### Config scripts:
Run from the provided location:
| Description | Linux | Windows | MacOS |
|-------------|-------|---------|-------|
| Uses app_config.env to generate/rebuild/replace app_setup.json, buildSpec.json, and i18nPatch.json| `/linux/scripts/app_setup.bsh` | `/windows/scripts/app_setup.bat` | `/macos/scripts/app_setup.zsh` |

#### Setup scripts:
Run from the provided location:
| Description | Linux | Windows | MacOS |
|-------|-------|---------|-------|
| Clones all repos in `/app_config.env` if a directly by that name does not already exit | /linux/scripts/clone.bsh | /windows/scripts/clone.bat | /macos/scripts/clone.zsh |
| For each asset repo in `/app_config.env`: git checkout main, git pull<br />For each client repo in  `/app_config.env`: `git checkout main`, `git pull`, `npm install`, and `npm run build`.<br />***Dev's should build manually when testing branch(es).*** | /linux/scripts/build_clients.bsh | /windows/scripts/build_clients.bat | /macos/scripts/build_clients.zsh |

#### Usage scripts:

| Description | Linux | Windows | MacOS |
|-------|-------|---------|-------|
| removes the build directory and runs `cargo clean` | /linux/scripts/clean.bsh | /windows/scripts/clean.bat | /macos/scripts/clean.zsh |
| runs `clean.bat`, cargo build, and `node build.js` | /linux/scripts/build_server.bsh | /windows/scripts/build_server.bat | /macos/scripts/build_server.zsh |
| Assembles the build environment (clients) and starts the server **(*)** | /linux/scripts/run.bsh | /windows/scripts/run.bat | /macos/scripts/run.zsh |
| Assembles the build environment (clients), starts the server, and launches a browser **(*)** | /linux/scripts/open.bsh | /windows/scripts/open.bat | /macos/scripts/open.zsh |
| Deletes the last .zip release bundle if it it exists, runs `app_setup.bat` to ensure version consistency, then on this repo runs `git checkout main`, `git pull`, and `npm install`, runs `node build.js`, then makes a zip release bundle **(*)** | /linux/scripts/bundle_tgz.bsh | /windows/scripts/bundle_zip.ps1 | /macos/scripts/bundle_zip.zsh |
| Deletes the last .exe release bundle if it it exists, runs `app_setup.bat` to ensure version consistency, then on this repo runs `git checkout main`, `git pull`, and `npm install`, runs `node build.js`, then makes an exe installer **(*)** | | /windows/scripts/bundle_exe.ps1 | |
**(*)** ***Ensure the server (build_server.bat) is current!***