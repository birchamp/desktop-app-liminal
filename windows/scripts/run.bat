@echo off
call .\build_server.bat
echo "Running..."
cd ..\build
SET APP_RESOURCES_DIR=.\lib\
start "" ".\bin\server.exe"
