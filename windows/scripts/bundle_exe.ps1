cd ..\..\
If (Test-Path releases\windows\*.exe) {
Remove-Item releases\windows\*.exe }
del releases\windows\*.exe
git checkout main
git pull
npm install
cd windows\scripts
node build.js
cd ..\install
.\makeInstall.bat
cd ..\scripts