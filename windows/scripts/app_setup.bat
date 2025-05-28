@echo off

echo.
echo      ****************************************************
echo      * This script uses:                                *
echo      *   - \app_assets.txt,                             *
echo      *   - \app_clients.txt,                            *
echo      *   - \app_name.txt,                               *
echo      *   - \app_version.txt                             *
echo      * to generate/rebuild/replace:                     *
echo      *   - \windows\buildResources\setup\app_setup.json *
echo      *   - \macos\buildResources\setup\app_setup.json   *
echo      *   - \linux\buildResources\setup\app_setup.json   *
echo      *   - \buildSpec.json                              *
echo      *   - \globalBuildResources\i18nPatch.json         *
echo      ****************************************************
setlocal ENABLEDELAYEDEXPANSION

set /p appname= <..\..\app_name.txt
set /p ver= <..\..\app_version.txt

set clients=..\buildResources\setup\app_setup.json
set spec=..\..\buildSpec.json
set name=..\..\globalBuildResources\i18nPatch.json

echo {> %name%
echo   "branding": {>> %name%
echo     "software": {>> %name%
echo       "name": {>> %name%
echo         "en": "%appname%">> %name%
echo       }>> %name%
echo     }>> %name%
echo   }>> %name%
echo }>> %name%

echo {> %spec%
echo   "app": {>> %spec%
echo     "name": "%appname%",>> %spec%
echo     "version": "%ver%">> %spec%
echo   },>> %spec%

echo   "bin": {>> %spec%
echo     "src": "../../local_server/target/release/local_server">> %spec%
echo   },>> %spec%

echo   "lib": [>> %spec%
set countassets=0
for /f "tokens=*" %%a in (..\..\app_assets.txt) do (
  SET /a countassets+= 1
  set var!countassets!=%%a
)
REM *****HANDLE CASE OF resource-core x 2????*******
REM *****HANDLE SPACES before scr and quotes?*******
for /l %%a in (1,1,%countassets%) do (
  REM Remove spaces from app_assets.txt
  set var%%a=!var%%a: =!
  if not "!var%%a:~0,11!" == "targetPath:" (
    if not "!var%%a:~0,11!" == "targetName:" (
      echo     {>> %spec%
      set src=      "src": "../../../!var%%a!
    )
  )
  if "!var%%a:~0,11!" == "targetPath:" (
    set src=!src!!var%%a:~11!",
    echo !src!>> %spec%
  )
  if "!var%%a:~0,11!" == "targetName:" (
    echo       "targetName": "!var%%a:~11!">> %spec%
    echo     },>> %spec%
  )
)
echo     {>> %spec%
echo       "src": "../buildResources/setup",>> %spec%
echo       "targetName": "setup">> %spec%
echo     }>> %spec%
echo    ],>> %spec%

echo   "libClients": [>> %spec%
set countclients=0
for /f "tokens=*" %%c in (..\..\app_clients.txt) do (
  set /a countclients+= 1
  set var!countclients!=%%c
)

echo {> %clients%
echo   "clients": [>> %clients%

for /l %%c in (1,1,%countclients%) do (
  REM Remove spaces from app_clients.txt
  set var%%c=!var%%c: =!
  if "!var%%c:~-1!" == "," (
    echo     {>> %clients%
    REM Remove the comma then add it back
    set var%%c=!var%%c:^,=!
    echo       "path": "%%%%PANKOSMIADIR%%%%/!var%%c:^,=!!",>> %clients%
    if %%c==%countclients% (
      echo     "../../../!var%%c!">> %spec%
    ) else (
      echo     "../../../!var%%c!",>> %spec%
    )
  ) else (
    if "!var%%c:~0,18!" == "exclude_from_menu:" (
      echo       "!var%%c:~0,18!": !var%%c:~18!>> %clients%
    ) else (
      echo     {>> %clients%
      echo       "path": "%%%%PANKOSMIADIR%%%%/!var%%c!">> %clients%
      if %%c==%countclients% (
        echo     "../../../!var%%c!">> %spec%
      ) else (
        echo     "../../../!var%%c!",>> %spec%
      )
    )
    if %%c==%countclients% (
      echo     }>> %clients%
    ) else (
      echo     },>> %clients%
    )
  )
)
echo   ]>> %clients%
echo }>> %clients%

echo   ],>> %spec%
echo   "favIcon": "../../globalBuildResources/favicon.ico",>> %spec%
echo   "theme": "../../globalBuildResources/theme.json">> %spec%
echo }>> %spec%

echo.
echo \buildSpec.json generated/rebuilt/replaced
echo \globalBuildResources\i18nPatch.json generated/rebuilt/replaced
echo \windows\buildResources\setup\app_setup.json generated/rebuilt/replaced
echo.
echo Copying \windows\buildResources\setup\app_setup.json to \linux\buildResources\setup\
copy ..\buildResources\setup\app_setup.json ..\..\linux\buildResources\setup\app_setup.json
echo Copying \windows\buildResources\setup\app_setup.json to \macos\buildResources\setup\
copy ..\buildResources\setup\app_setup.json ..\..\macos\buildResources\setup\app_setup.json
