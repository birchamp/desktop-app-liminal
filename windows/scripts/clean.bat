@echo off
if exist ..\build (
  echo "Removing last build environment"
  rmdir ..\build /s /q
)

if exist ..\..\local_server\target\release\local_server.exe (
    echo "Cleaning local server"
    cd ..\..\local_server
    cargo clean
    cd ..\windows\scripts
)
