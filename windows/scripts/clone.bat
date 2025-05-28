@echo off
setlocal ENABLEDELAYEDEXPANSION

set countassets=0
for /f "tokens=*" %%a in (..\..\app_assets.txt) do (
  set /a countassets+= 1
  set var!countassets!=%%a
)
REM For catching repeated repos every third row
set countdedupe=3
for /f "tokens=*" %%b in (..\..\app_assets.txt) do (
  set /a countdedupe+= 1
  set dedupe!countdedupe!=%%b
)
cd ..\..\..\
for /l %%a in (1,1,%countassets%) do (
  REM Remove spaces from app_assets.txt
  set var%%a=!var%%a: =!
  REM Don't clone targetPath or targetName lines.
  if not "!var%%a:~0,11!" == "targetPath:" (
    if not "!var%%a:~0,11!" == "targetName:" (
      REM Catch repeated repos
      if %%a gtr 2 (
        if not "!var%%a!" == "!dedupe%%a!" (
          echo Asset: !var%%a!
          if not exist !var%%a! (
            git clone https://github.com/pankosmia/!var%%a!.git
          ) else (
            echo "Directory already exists; Not cloned."
          )
        )
      ) else (
        echo Asset: !var%%a!
        if not exist !var%%a! (
          git clone https://github.com/pankosmia/!var%%a!.git
        ) else (
          echo "Directory already exists; Not cloned."
        )
      )
    )
  )
)
cd desktop-app-liminal\windows\scripts

set countclients=0
for /f "tokens=*" %%c in (..\..\app_clients.txt) do (
  set /a countclients+= 1
  set var!countclients!=%%c
)
cd ..\..\..\
for /l %%c in (1,1,%countclients%) do (
  REM Don't clone "exclude_from_menu:" lines
  if not "!var%%c:~0,18!" == "exclude_from_menu:" (
    REM Remove commas
    set var%%c=!var%%c:^,=!
    echo Client: !var%%c!
    echo !var%%c!
    if not exist !var%%c! (
      git clone https://github.com/pankosmia/!var%%c!.git
    ) else (
      echo "Directory already exists; Not cloned."
    )
  )
)
cd desktop-app-liminal\windows\scripts