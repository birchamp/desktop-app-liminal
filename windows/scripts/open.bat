@echo off

for /F "tokens=1,2 delims==" %%a in (..\..\app_config.env) do set %%a=%%b

if exist ..\build (
  echo "Removing last build environment"
  rmdir ..\build /s /q
)
if not exist ..\build (
  echo "Assembling build environment"
  node build.js
)
echo "Running and Opening Browser..."
cd ..\build
.\%APP_NAME%.bat