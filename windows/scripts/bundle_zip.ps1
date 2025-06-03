# This script requires APP_VERSION environment variable to be set:
#     You can do this in powershell by: $env:APP_VERSION = "0.2.6"
#     Or in command prompt by: set APP_VERSION="0.2.6"

# run from pankosmia\desktop-app-liminal\windows\scripts directory in powershell by:  .\bundle_zip.ps1

If (-Not (Test-Path ..\..\local_server\target\release\local_server.exe)) {
  echo "`n"
  echo "   ***************************************************************"
  echo "   * IMPORTANT: Build the local server, then re-run this script! *"
  echo "   ***************************************************************"
  echo "`n"
  pause
  exit
}

echo "`n"
echo "Running app_setup to ensure version number consistency between buildSpec.json and this build bundle:"
.\app_setup.bat

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
echo "`n"
echo "   *****************************************************************************************"
echo "   *                                                                                       *"
echo "   *                                          =====                                        *"
echo "   * Bundling. Wait for the powershell prompt AFTER the compression progress bar finishes. *"
echo "   *                                          =====                                        *"
echo "   *                                                                                       *"
echo "   *****************************************************************************************"
echo "`n"
Compress-Archive * ..\..\releases\windows\liminal-windows-$env:APP_VERSION.zip
cd ..\scripts