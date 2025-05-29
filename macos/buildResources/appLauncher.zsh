#!/usr/bin/env zsh

clear
URL="http://localhost:19119"
if [ -e /Applications/Firefox.app ]
then
    open -a firefox -g "$URL" &
else
    open "$URL" &
fi
echo "Launch a web browser and enter http://localhost:19119"
echo "(Best viewed with a Graphite-enabled browser such as Firefox.)"
echo " "
export APP_RESOURCES_DIR=./lib/
./bin/server.bin
