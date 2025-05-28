@echo off
if not exist ..\..\local_server\target\release\local_server.exe (
    echo "Building local server"
    cd ..\..\local_server
    cargo build --release
    cd ..\windows\scripts
)

echo "Assembling build environment"
node build.js
