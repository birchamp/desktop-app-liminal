# This script requires APP_VERSION environment variable to be set:
#     You can do this in powershell by: $env:APP_VERSION = "0.2.6"
#     Or in command prompt by: set APP_VERSION="0.2.6"

# run from pankosmia\desktop-app-liminal\windows\scripts directory in powershell by:  .\bundle_zip.ps1

@echo off
ECHO ""
ECHO "Version is $env:APP_VERSION"
ECHO ""

cd ..\..\
If (Test-Path releases\windows\*.zip) {
Remove-Item releases\windows\*.zip }
del releases\windows\*.zip
git checkout main
git pull
npm install
cd windows\scripts
node build.js
cd ..\build
Compress-Archive * ..\..\releases\windows\liminal-windows-$env:APP_VERSION.zip
cd ..\scripts