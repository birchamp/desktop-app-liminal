@echo off
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
.\Liminal.bat