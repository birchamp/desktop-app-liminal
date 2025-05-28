@echo off
call .\build_server.bat
echo "Running and Opening Browser..."
cd ..\build
.\liminal.bat