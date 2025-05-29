# This script requires APP_VERSION environment variable to be set:
#     You can do this in powershell by: $env:APP_VERSION = "0.2.6"
#     Or in command prompt by: set APP_VERSION="0.2.6"

# run from pankosmia\desktop-app-liminal\windows\scripts directory in powershell by:  .\bundle_zip.ps1

ECHO ""
ECHO "Version is $env:APP_VERSION"
ECHO ""

cd ..\..\
If (Test-Path releases\windows\*.zip) {
  echo "A previous windows .zip release exists. Removing..."
  Remove-Item releases\windows\*.zip
}
echo "checkout main"
git checkout main | Out-Null
echo "pull"
git pull
echo "npm install"
npm install
cd windows\scripts
if (Test-Path ..\build) {
  echo "Removing last build environment"
  rm ..\build -r -force
}
echo "Assembling build environment"
node build.js
cd ..\build
echo "Bundling. Wait for the powershell prompt after the compression progress bar finishes."
Compress-Archive * ..\..\releases\windows\liminal-windows-$env:APP_VERSION.zip
cd ..\scripts