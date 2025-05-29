@echo off
REM set port environment variable
set ROCKET_PORT=19119
call .\build_server.bat
echo "Running..."
cd ..\build
SET APP_RESOURCES_DIR=.\lib\
start "" ".\bin\server.exe"