cd ..\..\..\
cd core-client-content
git checkout main
git pull
npm install
npm run build
cd ..\core-client-dashboard
git checkout main
git pull
npm install
npm run build
cd ..\core-client-i18n-editor
git checkout main
git pull
npm install
npm run build
cd ..\core-client-remote-repos
git checkout main
git pull
npm install
npm run build
cd ..\core-client-settings
git checkout main
git pull
npm install
npm run build
cd ..\core-client-workspace
git checkout main
git pull
npm install
npm run build
cd ..\desktop-app-liminal\windows\scripts