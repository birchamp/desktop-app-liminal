# This script requires APP_VERSION environment variable to be set:
#     You can do this in powershell by: $env:APP_VERSION = "0.2.6"
#     Or in command prompt by: set APP_VERSION="0.2.6"

# run from pankosmia\desktop-app-liminal\windows\scripts directory in powershell by:  .\bundle_zip.ps1

cd ..\..\
If (Test-Path releases\windows\*.exe) {
  echo "A previous windows .exe release exists. Removing..."
  Remove-Item releases\windows\*.exe
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
cd ..\install
echo "Making .exe installer..."
.\makeInstall.bat
cd ..\scripts